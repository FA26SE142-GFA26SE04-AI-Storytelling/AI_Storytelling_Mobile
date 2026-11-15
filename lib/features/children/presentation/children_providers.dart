import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/child_access_credential_dto.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/learning_profile_dto.dart';
import '../../../models/safety_policy_dto.dart';
import '../../access/data/child_access_repository.dart';
import '../data/child_profile_repository.dart';

class SelectedChildIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void select(int id) {
    state = id;
  }

  void clear() {
    state = null;
  }
}

final selectedChildIdProvider =
    NotifierProvider<SelectedChildIdNotifier, int?>(
  SelectedChildIdNotifier.new,
);

final childrenListProvider =
    FutureProvider.autoDispose<List<ChildProfileDto>>((ref) {
  return ref.watch(childProfileRepositoryProvider).fetchMine();
});

final childDetailProvider =
    FutureProvider.autoDispose.family<ChildProfileDto, int>((ref, id) {
  return ref.watch(childProfileRepositoryProvider).fetchById(id);
});

class ChildOverview {
  final LearningProfileDto? learning;
  final SafetyPolicyDto? safety;
  final ChildAccessCredentialDto? access;

  const ChildOverview({
    this.learning,
    this.safety,
    this.access,
  });
}

Future<T?> _optional<T>(Future<T> Function() f) async {
  try {
    return await f();
  } on ApiException catch (e) {
    if (e.statusCode == 404) {
      return null;
    }
    rethrow;
  }
}

final childOverviewProvider =
    FutureProvider.autoDispose.family<ChildOverview, int>((ref, id) async {
  final childRepo = ref.watch(childProfileRepositoryProvider);
  final accessRepo = ref.watch(childAccessRepositoryProvider);

  final results = await Future.wait([
    _optional(() => childRepo.fetchLearning(id)),
    _optional(() => childRepo.fetchSafety(id)),
    _optional(() => accessRepo.fetchCredential(id)),
  ]);

  return ChildOverview(
    learning: results[0] as LearningProfileDto?,
    safety: results[1] as SafetyPolicyDto?,
    access: results[2] as ChildAccessCredentialDto?,
  );
});
