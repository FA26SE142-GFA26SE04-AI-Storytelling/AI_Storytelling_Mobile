import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/learning_profile_dto.dart';
import '../../auth/application/auth_controller.dart';
import '../data/child_profile_repository.dart';
import 'learning_form.dart';

class ChildLearningScreen extends ConsumerStatefulWidget {
  const ChildLearningScreen({super.key, required this.childId});

  final int childId;

  @override
  ConsumerState<ChildLearningScreen> createState() =>
      _ChildLearningScreenState();
}

class _ChildLearningScreenState extends ConsumerState<ChildLearningScreen> {
  ChildProfileDto? _child;
  LearningFormValue? _saved;
  LearningFormValue? _current;

  bool _isLoading = true;
  bool _saving = false;
  String? _errorMessage;

  bool get _dirty =>
      _saved != null && _current != null && _saved != _current;

  @override
  void initState() {
    super.initState();
    _load();
  }

  LearningFormValue _defaultFormValue(String ageBand) {
    final isAge9To10 = ageBand == 'Age_9_10';
    return LearningFormValue(
      readingLevel: isAge9To10 ? 3 : 1,
      readingMode: isAge9To10 ? 'ReadFirst' : 'ListenFirst',
      comprehensionGoal: '',
      favoriteTopics: const [],
      priorityFocusAreas: const [],
    );
  }

  LearningFormValue _dtoToFormValue(
    LearningProfileDto dto,
    String ageBand,
  ) {
    final isAge9To10 = ageBand == 'Age_9_10';
    final defaultReadingMode = isAge9To10 ? 'ReadFirst' : 'ListenFirst';

    final favoriteTopics = <String>[];
    final priorityFocusAreas = <String>[];

    for (final topic in dto.topics) {
      if (topic.relation == 'FavoriteTopic') {
        favoriteTopics.add(topic.topic);
      } else if (topic.relation == 'PriorityFocusArea') {
        priorityFocusAreas.add(topic.topic);
      }
    }

    return LearningFormValue(
      readingLevel: dto.readingLevel,
      readingMode: dto.readingMode ?? defaultReadingMode,
      comprehensionGoal: dto.comprehensionGoal ?? '',
      favoriteTopics: favoriteTopics,
      priorityFocusAreas: priorityFocusAreas,
    );
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      final childFuture = repo.fetchById(widget.childId);
      final learningFuture = repo.fetchLearning(widget.childId);

      final child = await childFuture;
      LearningProfileDto? learningDto;

      try {
        learningDto = await learningFuture;
      } on ApiException catch (e) {
        if (e.statusCode == 404) {
          learningDto = null;
        } else {
          rethrow;
        }
      }

      final initialValue = learningDto != null
          ? _dtoToFormValue(learningDto, child.ageBand)
          : _defaultFormValue(child.ageBand);

      if (!mounted) return;
      setState(() {
        _child = child;
        _saved = initialValue;
        _current = initialValue;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = ApiException.defaultFallbackMessage;
        _isLoading = false;
      });
    }
  }

  Future<void> _save() async {
    final current = _current;
    final child = _child;
    if (current == null || child == null || _saving) return;

    setState(() => _saving = true);

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      final goalTrimmed = current.comprehensionGoal.trim();

      final topics = <LearningTopicDto>[
        ...current.favoriteTopics.map(
          (t) => LearningTopicDto(topic: t, relation: 'FavoriteTopic'),
        ),
        ...current.priorityFocusAreas.map(
          (t) => LearningTopicDto(topic: t, relation: 'PriorityFocusArea'),
        ),
      ];

      await repo.setLearning(
        widget.childId,
        readingLevel: current.readingLevel,
        readingMode: current.readingMode,
        comprehensionGoal: goalTrimmed.isEmpty ? null : goalTrimmed,
        topics: topics,
      );

      if (!mounted) return;
      setState(() {
        _saved = current;
      });

      showTtToast(
        context,
        'Đã lưu hồ sơ học tập của ${child.nickname}',
        type: TtToastType.success,
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      showTtToast(
        context,
        ApiException.defaultFallbackMessage,
        type: TtToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final signedInUserId =
        authState is AuthSignedIn ? authState.user.id : null;
    final isOwner = _child != null &&
        _child!.ownerUserId != null &&
        _child!.ownerUserId == signedInUserId;

    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (_dirty) {
          final shouldPop = await showConfirmDialog(
            context,
            title: 'Bỏ thay đổi chưa lưu?',
            message: 'Các thay đổi về học tập chưa được lưu sẽ mất.',
            confirmLabel: 'Bỏ thay đổi',
            destructive: true,
          );
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Học tập'),
        ),
        // Màn rộng: giới hạn 720 như các màn Tài khoản.
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: _buildBody(isOwner),
          ),
        ),
        bottomNavigationBar: (_dirty && isOwner)
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TtButton(
                    label: 'Lưu',
                    expanded: true,
                    isLoading: _saving,
                    onPressed: _save,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBody(bool isOwner) {
    if (_isLoading) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TtSkeleton(height: 120),
            SizedBox(height: 16),
            TtSkeleton(height: 160),
            SizedBox(height: 16),
            TtSkeleton(height: 120),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return TtErrorState(
        message: _errorMessage!,
        onRetry: _load,
      );
    }

    final current = _current;
    if (current == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: LearningForm(
        value: current,
        enabled: isOwner && !_saving,
        onChanged: (v) => setState(() => _current = v),
      )
          .animate(key: const ValueKey('learning_form_animate'))
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.05, end: 0),
    );
  }
}
