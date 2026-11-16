import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_child_avatar.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import '../../auth/application/auth_controller.dart';
import '../../children/presentation/children_providers.dart';
import '../../kid/data/handover_action.dart';
import 'home_providers.dart';

String _errorText(Object error) => error is ApiException
    ? error.message
    : 'Có lỗi xảy ra. Vui lòng thử lại.';

/// Trang chủ phụ huynh: lời chào và một thẻ tóm tắt cho mỗi bé đang hoạt động.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static String greeting(DateTime now) {
    if (now.hour < 12) return 'Chào buổi sáng';
    if (now.hour < 18) return 'Chào buổi chiều';
    return 'Chào buổi tối';
  }

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(childrenListProvider);
    ref.invalidate(childHomeSummaryProvider);
    try {
      await ref.read(childrenListProvider.future);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final auth = ref.watch(authControllerProvider);
    final name = auth is AuthSignedIn
        ? (auth.user.fullName.trim().isNotEmpty
            ? auth.user.fullName.trim()
            : auth.user.username)
        : '';
    final hello = greeting(DateTime.now());
    final childrenAsync = ref.watch(childrenListProvider);

    final header = Row(
      children: [
        Expanded(
          child: Text(
            name.isEmpty ? hello : '$hello, $name',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 12),
        const TtFrog(mood: TtFrogMood.happy, size: 56)
            .animate()
            .scale(
              begin: const Offset(0.8, 0.8),
              duration: 400.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(duration: 300.ms),
      ],
    ).animate().fadeIn(duration: 280.ms);

    final List<Widget> body = childrenAsync.when(
      loading: () => [
        for (var i = 0; i < 2; i++) ...[
          const TtSkeleton(
            height: 200,
            radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
          ),
          const SizedBox(height: 16),
        ],
      ],
      error: (error, _) => [
        TtErrorState(
          title: 'Chưa tải được danh sách bé',
          message: _errorText(error),
          onRetry: () => ref.invalidate(childrenListProvider),
        ),
      ],
      data: (children) {
        final active = children.where((c) => c.status == 'Active').toList();
        if (active.isEmpty) {
          return [
            TtEmptyState(
              icon: Icons.child_care_rounded,
              title: 'Chưa có bé nào sẵn sàng đọc',
              actionLabel: 'Mở tab Bé',
              onAction: () => context.go('/kids'),
            ),
          ];
        }
        return [
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
              final twoCols = constraints.maxWidth >= 840 - 32;
              final cardWidth = twoCols
                  ? (constraints.maxWidth - gap) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < active.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: _ChildHomeCard(
                        key: ValueKey('home-child-${active[i].id}'),
                        child: active[i],
                      ),
                    )
                        .animate(delay: (60 * i).ms)
                        .fadeIn(duration: 320.ms)
                        .slideY(
                          begin: 0.05,
                          end: 0,
                          duration: 320.ms,
                          curve: Curves.easeOut,
                        ),
                ],
              );
            },
          ),
        ];
      },
    );

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      header,
                      const SizedBox(height: 20),
                      ...body,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildHomeCard extends ConsumerStatefulWidget {
  const _ChildHomeCard({super.key, required this.child});

  final ChildProfileDto child;

  @override
  ConsumerState<_ChildHomeCard> createState() => _ChildHomeCardState();
}

class _ChildHomeCardState extends ConsumerState<_ChildHomeCard> {
  bool _handoverLoading = false;

  Future<void> _handover() async {
    if (_handoverLoading) return;
    setState(() => _handoverLoading = true);
    try {
      await handoverChildToKid(context, ref, widget.child);
    } finally {
      if (mounted) setState(() => _handoverLoading = false);
    }
  }

  void _openInKidsTab() {
    ref.read(selectedChildIdProvider.notifier).select(widget.child.id);
    context.go('/kids');
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final child = widget.child;
    final summaryAsync = ref.watch(childHomeSummaryProvider(child.id));
    final summary = summaryAsync.value;
    // Kiểm tra lỗi trước: khi Riverpod tự thử lại, trạng thái vẫn mang lỗi.
    final error = summaryAsync.hasError && !summaryAsync.hasValue
        ? summaryAsync.error
        : null;

    final muted = textTheme.bodyMedium?.copyWith(color: tt.muted);
    final strong = textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700);

    Widget line(String label, String title) => Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$label: ', style: muted),
              TextSpan(text: title, style: strong),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );

    final List<Widget> details;
    if (error != null) {
      details = [
        Row(
          children: [
            Icon(Icons.error_outline_rounded, size: 18, color: tt.danger),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _errorText(error),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(color: tt.danger),
              ),
            ),
            const SizedBox(width: 8),
            TtIconButton(
              icon: Icons.refresh_rounded,
              tooltip: 'Thử lại',
              size: 40,
              onPressed: () =>
                  ref.invalidate(childHomeSummaryProvider(child.id)),
            ),
          ],
        ),
      ];
    } else if (summary == null) {
      details = const [
        TtSkeleton(height: 16, width: 220),
        SizedBox(height: 8),
        TtSkeleton(height: 16, width: 160),
      ];
    } else {
      final latest = summary.latest;
      final next = summary.next;
      details = [
        if (latest != null) ...[
          line('Gần nhất', latest.title),
          if (latest.feelingLabel != null ||
              latest.quizBestPercent != null) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (latest.feelingLabel != null)
                  _Chip(label: latest.feelingLabel!, color: tt.rose),
                if (latest.quizBestPercent != null)
                  _Chip(
                    label: 'Quiz ${latest.quizBestPercent!.round()}%',
                    color: tt.sky,
                  ),
              ],
            ),
          ],
        ],
        if (latest != null && next != null) const SizedBox(height: 10),
        if (next != null)
          line('Tiếp theo', next.title ?? 'Truyện không còn khả dụng'),
      ];
    }

    return TtCard(
      onTap: _openInKidsTab,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              TtChildAvatar(avatarId: child.avatarId, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  child.nickname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
              ),
              if (summary != null) ...[
                const SizedBox(width: 8),
                _Chip(
                  label: '📖 ${summary.readOn(DateTime.now())} hôm nay',
                  color: tt.goldDeep,
                  fill: tt.gold,
                ),
              ],
            ],
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...details,
          ],
          const SizedBox(height: 16),
          TtButton(
            label: 'Cho bé đọc',
            icon: Icons.auto_stories_rounded,
            expanded: true,
            isLoading: _handoverLoading,
            onPressed: _handover,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, this.fill});

  final String label;
  final Color color;

  /// Màu nền đậm (chip vàng honey); mặc định là màu chữ pha nhạt.
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    final base = fill ?? color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: base.withValues(alpha: fill != null ? 0.35 : 0.14),
        borderRadius: BorderRadius.circular(TtRadius.sm),
        border: Border.all(color: base.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fill != null ? context.tt.text : color,
        ),
      ),
    );
  }
}
