import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/story_wish_dto.dart';
import '../data/kid_wish_repository.dart';

/// Đại diện cho một bước trong hành trình chọn điều ước của bé.
class _WizardStepInfo {
  const _WizardStepInfo({
    required this.group,
    required this.label,
    required this.icon,
    required this.isOptional,
  });

  final String group;
  final String label;
  final IconData icon;
  final bool isOptional;
}

const _kWizardSteps = <_WizardStepInfo>[
  _WizardStepInfo(
    group: 'Character',
    label: 'Nhân vật',
    icon: Icons.person_rounded,
    isOptional: false,
  ),
  _WizardStepInfo(
    group: 'Place',
    label: 'Nơi chốn',
    icon: Icons.place_rounded,
    isOptional: false,
  ),
  _WizardStepInfo(
    group: 'Challenge',
    label: 'Thử thách',
    icon: Icons.landscape_rounded,
    isOptional: true,
  ),
  _WizardStepInfo(
    group: 'Lesson',
    label: 'Bài học',
    icon: Icons.lightbulb_rounded,
    isOptional: true,
  ),
];

/// Widget Wizard Điều ước câu chuyện dành cho bé.
class KidWishWizard extends ConsumerStatefulWidget {
  const KidWishWizard({
    super.key,
    required this.draft,
    required this.onClose,
    required this.onDone,
  });

  /// Bản nháp mong ước hiện tại.
  final WishDraft draft;

  /// Callback khi nhấn "Để sau" để quay về màn trước.
  final VoidCallback onClose;

  /// Callback sau khi gửi điều ước thành công.
  final VoidCallback onDone;

  @override
  ConsumerState<KidWishWizard> createState() => _KidWishWizardState();
}

class _KidWishWizardState extends ConsumerState<KidWishWizard> {
  late WishDraft _draft;
  int _currentStepIndex = 0;

  /// Cache danh sách thẻ theo nhóm để tránh gọi API nhiều lần khi bé chuyển qua lại.
  final Map<String, List<ChildWishCard>> _cardsByGroup = {};
  bool _isLoadingCards = false;
  String? _cardsError;

  bool _isSavingCard = false;
  bool _isSubmitting = false;

  _WizardStepInfo get _currentStep => _kWizardSteps[_currentStepIndex];

  @override
  void initState() {
    super.initState();
    _draft = widget.draft;
    _loadCardsForGroup(_currentStep.group);
  }

  /// Tải danh sách thẻ cho một nhóm gợi ý.
  Future<void> _loadCardsForGroup(String group) async {
    if (_cardsByGroup.containsKey(group)) {
      setState(() {
        _isLoadingCards = false;
        _cardsError = null;
      });
      return;
    }

    setState(() {
      _isLoadingCards = true;
      _cardsError = null;
    });

    try {
      final repository = ref.read(kidWishRepositoryProvider);
      final cards = await repository.wishCards(group);
      if (!mounted) return;
      setState(() {
        _cardsByGroup[group] = cards;
        _isLoadingCards = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _cardsError = 'Không thể tải danh sách thẻ. Bé hãy thử lại nhé!';
        _isLoadingCards = false;
      });
    }
  }

  /// Chuyển tới bước chỉ định.
  void _goToStep(int index) {
    if (index < 0 ||
        index >= _kWizardSteps.length ||
        index == _currentStepIndex) {
      return;
    }
    setState(() {
      _currentStepIndex = index;
    });
    _loadCardsForGroup(_kWizardSteps[index].group);
  }

  /// Kiểm tra thẻ đã được chọn trong bản nháp hay chưa.
  bool _isCardSelected(ChildWishCard card) {
    return _draft.cards.any((c) => c.group == card.group && c.id == card.id);
  }

  /// Khi bé chạm vào một thẻ để chọn.
  Future<void> _handleSelectCard(ChildWishCard card) async {
    if (_isSavingCard || _isSubmitting) return;

    final group = _currentStep.group;
    setState(() {
      _isSavingCard = true;
    });

    try {
      final repository = ref.read(kidWishRepositoryProvider);
      final updatedDraft = await repository.saveDraftCard(
        group: group,
        cardId: card.id,
        leaveToParent: false,
      );
      if (!mounted) return;
      setState(() {
        _draft = updatedDraft;
        _isSavingCard = false;
      });

      // Nếu chưa phải bước cuối thì tự động chuyển sang bước sau
      if (_currentStepIndex < _kWizardSteps.length - 1) {
        _goToStep(_currentStepIndex + 1);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSavingCard = false;
      });
      showTtToast(
        context,
        'Không thể lưu thẻ này, bé thử lại nhé!',
        type: TtToastType.error,
      );
    }
  }

  /// Hành động "Để bố mẹ chọn" chỉ có ở bước Lesson.
  Future<void> _handleLeaveLessonToParent() async {
    if (_isSavingCard || _isSubmitting) return;

    setState(() {
      _isSavingCard = true;
    });

    try {
      final repository = ref.read(kidWishRepositoryProvider);
      final updatedDraft = await repository.saveDraftCard(
        group: 'Lesson',
        cardId: null,
        leaveToParent: true,
      );
      if (!mounted) return;
      setState(() {
        _draft = updatedDraft;
        _isSavingCard = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSavingCard = false;
      });
      showTtToast(
        context,
        'Không thể lưu lựa chọn, bé thử lại nhé!',
        type: TtToastType.error,
      );
    }
  }

  /// Gửi bản nháp hoàn tất điều ước.
  Future<void> _handleSubmitDraft() async {
    if (_isSubmitting || !_draft.canSubmit) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repository = ref.read(kidWishRepositoryProvider);
      final storyWish = await repository.submitDraft();
      if (!mounted) return;

      final message = storyWish.message.trim().isNotEmpty
          ? storyWish.message
          : 'Bố mẹ sẽ xem điều ước của em nhé!';

      showTtToast(context, message, type: TtToastType.success);
      widget.onDone();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
      showTtToast(
        context,
        'Gửi điều ước chưa thành công, bé thử lại nhé!',
        type: TtToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildStepSelector(context),
            const Divider(height: 1),
            Expanded(child: _buildCardsBody(context)),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  /// Thanh tiêu đề phía trên gồm nút "Để sau" và tên wizard.
  Widget _buildTopBar(BuildContext context) {
    final tt = context.tt;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Điều ước của em',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: tt.text,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(
            height: 64,
            child: OutlinedButton.icon(
              onPressed: widget.onClose,
              icon: Icon(Icons.close_rounded, size: 28, color: tt.muted),
              label: Text(
                'Để sau',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: tt.muted,
                  fontFamily: 'Nunito',
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: tt.line2, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hàng icon bước ở trên, chạm để nhảy bước, bước đang chọn nổi bật.
  Widget _buildStepSelector(BuildContext context) {
    final tt = context.tt;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_kWizardSteps.length, (index) {
          final step = _kWizardSteps[index];
          final isSelected = index == _currentStepIndex;

          // Kiểm tra xem bước này đã có card nào được chọn chưa
          final hasSelection =
              _draft.cards.any((c) => c.group == step.group) ||
              (step.group == 'Lesson' && _draft.lessonLeftToParent);

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _goToStep(index),
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 64),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? tt.surface2
                          : (hasSelection ? tt.surface : tt.panel),
                      borderRadius: BorderRadius.circular(TtRadius.lg),
                      border: Border.all(
                        color: isSelected
                            ? tt.primaryStrong
                            : (hasSelection ? tt.primary : tt.line2),
                        width: isSelected ? 3 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: tt.primary.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          step.icon,
                          size: 32,
                          color: isSelected
                              ? tt.primaryStrong
                              : (hasSelection ? tt.primary : tt.muted),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            step.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected ? tt.primaryStrong : tt.text,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Thân nội dung: lưới thẻ hoặc trạng thái đang tải/rỗng/lỗi.
  Widget _buildCardsBody(BuildContext context) {
    if (_isLoadingCards) {
      return _buildSkeletonGrid(context);
    }

    if (_cardsError != null) {
      return TtErrorState(
        message: _cardsError!,
        onRetry: () => _loadCardsForGroup(_currentStep.group),
      );
    }

    final cards = _cardsByGroup[_currentStep.group] ?? const <ChildWishCard>[];
    if (cards.isEmpty) {
      return const TtEmptyState(
        icon: Icons.auto_stories_rounded,
        title: 'Chưa có thẻ nào',
        message: 'Các bạn nhỏ hãy quay lại sau nhé!',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          final isSelected = _isCardSelected(card);
          return _buildCardItem(context, card, isSelected);
        },
      ),
    );
  }

  /// Skeleton dạng lưới 2 cột khi đang tải thẻ.
  Widget _buildSkeletonGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => const TtSkeleton(
          radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
        ),
      ),
    );
  }

  /// Mỗi thẻ trong lưới: TtNetworkImage + label, viền vàng nếu được chọn.
  Widget _buildCardItem(
    BuildContext context,
    ChildWishCard card,
    bool isSelected,
  ) {
    final tt = context.tt;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleSelectCard(card),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: tt.panel,
            borderRadius: BorderRadius.circular(TtRadius.lg),
            border: Border.all(
              color: isSelected ? tt.gold : tt.line,
              width: isSelected ? 4.0 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? tt.gold.withValues(alpha: 0.45)
                    : tt.shadow.withValues(alpha: 0.08),
                blurRadius: isSelected ? 12 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TtNetworkImage(
                  url: card.imageUrl,
                  fit: BoxFit.cover,
                  radius: const BorderRadius.vertical(
                    top: Radius.circular(TtRadius.lg - 2),
                  ),
                ),
              ),
              // Ô chữ cố định đủ 2 dòng để các thẻ cùng chiều cao, ảnh thẳng hàng.
              Container(
                height: 76,
                alignment: Alignment.center,
                color: isSelected ? tt.surface : tt.panel,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  card.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                    color: isSelected ? tt.primaryStrong : tt.text,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Thanh đáy chứa nút quay lại, bỏ qua / để bố mẹ chọn, và nút gửi.
  Widget _buildBottomBar(BuildContext context) {
    final tt = context.tt;
    final isFirstStep = _currentStepIndex == 0;
    final isChallengeStep = _currentStep.group == 'Challenge';
    final isLessonStep = _currentStep.group == 'Lesson';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: tt.panel,
        border: Border(top: BorderSide(color: tt.line, width: 1.5)),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Nút quay lại bước trước (bước đầu disable)
          SizedBox(
            width: 64,
            height: 64,
            child: IconButton(
              onPressed: isFirstStep
                  ? null
                  : () => _goToStep(_currentStepIndex - 1),
              icon: const Icon(Icons.arrow_back_rounded, size: 30),
              style: IconButton.styleFrom(
                backgroundColor: tt.panel,
                foregroundColor: tt.text,
                disabledBackgroundColor: tt.panel.withValues(alpha: 0.5),
                disabledForegroundColor: tt.text.withValues(alpha: 0.3),
                side: BorderSide(color: tt.line2, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TtRadius.lg),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Nút "Bỏ qua" ở bước Challenge
          if (isChallengeStep) ...[
            Expanded(
              child: SizedBox(
                height: 64,
                child: OutlinedButton(
                  onPressed: () => _goToStep(_currentStepIndex + 1),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: tt.line2, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TtRadius.lg),
                    ),
                  ),
                  child: Text(
                    'Bỏ qua',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: tt.text,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Nút "Để bố mẹ chọn" ở bước Lesson
          if (isLessonStep) ...[
            Expanded(
              child: SizedBox(
                height: 64,
                child: OutlinedButton(
                  onPressed: _isSavingCard ? null : _handleLeaveLessonToParent,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _draft.lessonLeftToParent
                        ? tt.surface2
                        : tt.panel,
                    side: BorderSide(
                      color: _draft.lessonLeftToParent
                          ? tt.primaryStrong
                          : tt.line2,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TtRadius.lg),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Để bố mẹ chọn',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _draft.lessonLeftToParent
                            ? tt.primaryStrong
                            : tt.text,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Nút "Gửi" điều ước (chỉ bấm được khi canSubmit == true)
          Expanded(
            child: SizedBox(
              height: 64,
              child: TtButton(
                label: 'Gửi',
                isLoading: _isSubmitting,
                onPressed: (_draft.canSubmit && !_isSubmitting)
                    ? _handleSubmitDraft
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
