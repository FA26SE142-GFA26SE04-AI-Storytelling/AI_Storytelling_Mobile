import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import 'frog.dart';

/// Hộp thông báo ngắn trong form: thành công (mint) hoặc lỗi (đỏ nhạt).
class Notice extends StatelessWidget {
  const Notice({super.key, required this.message, this.ok = false});

  final String message;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final fg = ok ? c.okInk : c.danger;
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: (ok ? c.mint : c.danger).withValues(alpha: ok ? 0.14 : 0.12),
          borderRadius: BorderRadius.circular(TtRadius.sm),
        ),
        child: Text(
          message,
          style: TextStyle(color: fg, fontSize: 13.5, fontWeight: FontWeight.w600, height: 1.4),
        ),
      ),
    );
  }
}

enum PillTone { ok, wait, draft, flag, ai }

/// Nhãn trạng thái truyện (DESIGN.md › StatusPill).
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.tone});

  final String label;
  final PillTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    final (bg, fg) = switch (tone) {
      PillTone.ok => (c.mint.withValues(alpha: 0.12), c.okInk),
      PillTone.wait => (c.gold.withValues(alpha: 0.14), c.warnInk),
      PillTone.draft => (c.surface2, c.muted),
      PillTone.flag => (c.danger.withValues(alpha: 0.12), c.danger),
      PillTone.ai => (c.primary.withValues(alpha: 0.14), c.primary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 11.5, fontWeight: FontWeight.w700, height: 1.5),
      ),
    );
  }
}

/// Trạng thái rỗng / lỗi / đã xong: ếch, tiêu đề, một dòng giải thích, tối đa 2 nút.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, this.message, this.mood = FrogMood.idle, this.actions = const []});

  final String title;
  final String? message;
  final FrogMood mood;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Frog(size: 110, mood: mood),
            const SizedBox(height: 12),
            Text(title, style: text.headlineSmall, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Text(
                  message!,
                  style: text.bodyMedium?.copyWith(color: context.tt.muted),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (actions.isNotEmpty) ...[const SizedBox(height: 16), Wrap(spacing: 10, runSpacing: 10, alignment: WrapAlignment.center, children: actions)],
          ],
        ),
      ),
    );
  }
}
