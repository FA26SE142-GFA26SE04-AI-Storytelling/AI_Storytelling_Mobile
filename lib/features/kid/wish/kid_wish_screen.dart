import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/story_wish_dto.dart';
import '../data/kid_wish_repository.dart';
import 'kid_wish_wizard.dart';

class KidWishScreen extends ConsumerStatefulWidget {
  const KidWishScreen({super.key});

  @override
  ConsumerState<KidWishScreen> createState() => _KidWishScreenState();
}

class _KidWishScreenState extends ConsumerState<KidWishScreen> {
  WishDraft? _draft;
  bool _isLoadingWishes = true;
  String? _wishesError;
  List<StoryWish> _wishes = const [];
  bool _isStartingDraft = false;

  @override
  void initState() {
    super.initState();
    _fetchWishes();
  }

  Future<void> _fetchWishes() async {
    setState(() {
      _isLoadingWishes = true;
      _wishesError = null;
    });

    try {
      final repo = ref.read(kidWishRepositoryProvider);
      final items = await repo.wishes();
      if (!mounted) return;
      setState(() {
        _wishes = items;
        _isLoadingWishes = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _wishesError = e.toString().replaceFirst('Exception: ', '');
        _isLoadingWishes = false;
      });
    }
  }

  Future<void> _handleStartDraft() async {
    if (_isStartingDraft) return;

    setState(() {
      _isStartingDraft = true;
    });

    try {
      final repo = ref.read(kidWishRepositoryProvider);
      final draft = await repo.startDraft();
      if (!mounted) return;
      setState(() {
        _draft = draft;
        _isStartingDraft = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isStartingDraft = false;
      });
      final message = e.toString().replaceFirst('Exception: ', '');
      showTtToast(
        context,
        message.isNotEmpty
            ? message
            : 'Không thể bắt đầu điều ước. Vui lòng thử lại!',
        type: TtToastType.error,
      );
    }
  }

  void _handleCloseWizard() {
    setState(() {
      _draft = null;
    });
  }

  void _handleDoneWizard() {
    setState(() {
      _draft = null;
    });
    _fetchWishes();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    // Khi có draft, hiển thị Wizard thay cho màn đầu
    if (_draft != null) {
      return KidWishWizard(
        draft: _draft!,
        onClose: _handleCloseWizard,
        onDone: _handleDoneWizard,
      );
    }

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Thanh trên có nút quay lại
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  TtIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Quay lại',
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Điều ước của em',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: tt.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Nội dung chính
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchWishes,
                color: tt.primaryStrong,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    // Màn đầu: Ếch happy + Lời mời + Nút ước
                    _buildInvitationSection(context),

                    const SizedBox(height: 28),

                    // Tiêu đề danh sách điều ước
                    Text(
                      'Điều ước đã gửi',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: tt.text,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Danh sách điều ước
                    _buildWishesSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvitationSection(BuildContext context) {
    final tt = context.tt;

    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: tt.panel.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(TtRadius.xl),
            border: Border.all(
              color: tt.gold.withValues(alpha: 0.35),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: tt.gold.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const TtFrog(mood: TtFrogMood.happy, size: 110),
              const SizedBox(height: 14),
              Text(
                'Em muốn nghe truyện gì?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: tt.text,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _isStartingDraft ? null : _handleStartDraft,
                  style: FilledButton.styleFrom(
                    backgroundColor: tt.primaryStrong,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: TtRadius.leaf,
                    ),
                    elevation: 3,
                    shadowColor: tt.primaryStrong.withValues(alpha: 0.3),
                  ),
                  child: _isStartingDraft
                      ? const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 28,
                              color: tt.gold,
                            ),
                            const SizedBox(width: 10),
                            const Flexible(
                              child: Text(
                                'Em ước một câu chuyện',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.05, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }

  Widget _buildWishesSection(BuildContext context) {
    final tt = context.tt;

    if (_isLoadingWishes) {
      return Column(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TtSkeleton(
              height: 100,
              radius: BorderRadius.circular(TtRadius.lg),
            ),
          ),
        ),
      );
    }

    if (_wishesError != null) {
      return TtErrorState(message: _wishesError!, onRetry: _fetchWishes);
    }

    if (_wishes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TtFrog(mood: TtFrogMood.idle, size: 90),
              const SizedBox(height: 16),
              Text(
                'Em chưa có điều ước nào, hãy ước một câu chuyện nhé',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: tt.muted,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _wishes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final wish = _wishes[index];
        return _buildWishCard(context, wish)
            .animate()
            .fadeIn(duration: 250.ms, delay: (index * 60).ms)
            .slideY(
              begin: 0.05,
              end: 0,
              duration: 250.ms,
              delay: (index * 60).ms,
            );
      },
    );
  }

  Widget _buildWishCard(BuildContext context, StoryWish wish) {
    final tt = context.tt;

    final cardLabels = wish.cards
        .map((c) => c.label)
        .where((l) => l.isNotEmpty)
        .join(' · ');
    final titleText = cardLabels.isNotEmpty ? cardLabels : 'Điều ước của bé';

    // Bỏ qua gợi ý chỉ có communitySubmissionId (backend chưa hỗ trợ)
    final validSuggestions = wish.suggestions
        .where((s) => s.storyId != null)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: tt.panel.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(color: tt.gold.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: tt.gold.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nhãn thẻ đã chọn
            Text(
              titleText,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: tt.text,
              ),
            ),
            const SizedBox(height: 6),

            // Dòng thông điệp trạng thái
            if (wish.message.isNotEmpty)
              Text(
                wish.message,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: tt.muted,
                ),
              ),

            // Nút "Đọc truyện" nếu đã fulfilled
            if (wish.fulfilledStoryId != null) ...[
              const SizedBox(height: 14),
              TtButton(
                label: 'Đọc truyện',
                icon: Icons.auto_stories_rounded,
                variant: TtButtonVariant.primary,
                onPressed: () {
                  context.push('/kid/read/${wish.fulfilledStoryId}');
                },
              ),
            ],

            // Danh sách gợi ý có storyId
            if (validSuggestions.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: validSuggestions.map((suggestion) {
                  return OutlinedButton.icon(
                    onPressed: () {
                      context.push('/kid/read/${suggestion.storyId}');
                    },
                    icon: Icon(
                      Icons.book_rounded,
                      size: 18,
                      color: tt.primaryStrong,
                    ),
                    label: Text(
                      suggestion.title,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: tt.text,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: tt.surface,
                      side: BorderSide(
                        color: tt.gold.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(TtRadius.md),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
