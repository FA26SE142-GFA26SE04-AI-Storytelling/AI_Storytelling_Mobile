import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reading_time_dto.dart';
import '../data/kid_repository.dart';
import '../data/kid_session_controller.dart';

/// Mã chức năng bố mẹ bật/tắt cho bé (backend ChildFeatures, `disabledFeatures` trong /me) — như Web kidFeatures.tsx.
const kKidFeatureQuiz = 'child.quiz';
const kKidFeatureNotebook = 'child.notebook';
const kKidFeatureLibrary = 'child.library.browse';
const kKidFeatureWishes = 'child.wishes';
const kKidFeatureVoice = 'child.voice';
const kKidFeatureReflection = 'child.reflection';
const kKidFeatureRewards = 'child.rewards';

const kKidFeatureOffMessage = 'Bố mẹ chưa bật chức năng này. Em hỏi bố mẹ nhé.';

@immutable
class KidStatus {
  const KidStatus({
    this.readingTime,
    this.habit,
    this.disabledFeatures = const <String>[],
    this.nickname,
  });

  final ReadingTimeStatusDto? readingTime;
  final ChildHabitDto? habit;
  final List<String> disabledFeatures;
  final String? nickname;

  bool isFeatureOn(String code) => !disabledFeatures.contains(code);

  KidStatus copyWith({
    ReadingTimeStatusDto? readingTime,
    ChildHabitDto? habit,
    List<String>? disabledFeatures,
    String? nickname,
  }) {
    return KidStatus(
      readingTime: readingTime ?? this.readingTime,
      habit: habit ?? this.habit,
      disabledFeatures: disabledFeatures ?? this.disabledFeatures,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KidStatus &&
          runtimeType == other.runtimeType &&
          readingTime == other.readingTime &&
          habit == other.habit &&
          listEquals(disabledFeatures, other.disabledFeatures) &&
          nickname == other.nickname;

  @override
  int get hashCode => Object.hash(
        readingTime,
        habit,
        Object.hashAll(disabledFeatures),
        nickname,
      );

  @override
  String toString() =>
      'KidStatus(readingTime: $readingTime, habit: $habit, disabledFeatures: $disabledFeatures, nickname: $nickname)';
}

class KidStatusNotifier extends Notifier<KidStatus> {
  Timer? _timer;
  AppLifecycleListener? _lifecycleListener;
  bool _disposed = false;

  @override
  KidStatus build() {
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      refresh();
    });

    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        refresh();
      },
    );

    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
      _lifecycleListener?.dispose();
    });

    final session = ref.watch(kidSessionProvider);
    if (session is KidActive) {
      Future.microtask(refresh);
    }

    return const KidStatus();
  }

  Future<void> refresh() async {
    final session = ref.read(kidSessionProvider);
    if (session is! KidActive) {
      if (!_disposed) {
        state = const KidStatus();
      }
      return;
    }

    try {
      final repo = ref.read(kidRepositoryProvider);
      final profile = await repo.getSessionProfile(session.session.accessToken);
      if (_disposed) return;
      state = KidStatus(
        readingTime: profile.readingTime,
        habit: profile.habit,
        disabledFeatures: profile.disabledFeatures,
        nickname: profile.nickname,
      );
    } catch (_) {
      // Giữ state cũ khi có lỗi (mạng, bất kỳ exception), không ném lỗi ra UI, không xoá dữ liệu.
    }
  }
}

final kidStatusProvider = NotifierProvider<KidStatusNotifier, KidStatus>(
  KidStatusNotifier.new,
);
