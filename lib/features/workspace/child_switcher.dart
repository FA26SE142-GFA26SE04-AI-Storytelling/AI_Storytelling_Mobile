import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../data/models/child_models.dart';
import '../../domain/story_view.dart';
import 'workspace_providers.dart';

/// Nút chọn bé trên AppBar: tên bé đang chọn, chạm để mở danh sách các bé.
class ChildSwitcher extends ConsumerWidget {
  const ChildSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.tt;
    final kids = ref.watch(childrenProvider).value ?? const <ChildProfile>[];
    final child = ref.watch(selectedChildProvider).value;
    if (child == null) return const SizedBox.shrink();
    final many = kids.length > 1;

    return Semantics(
      button: many,
      label: many ? 'Đang xem ${child.nickname}. Chạm để chọn bé khác' : 'Bé ${child.nickname}',
      excludeSemantics: true,
      child: Material(
        color: c.panel,
        shape: StadiumBorder(side: BorderSide(color: c.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: many ? () => _pick(context, ref, kids, child.id) : null,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 4, many ? 6 : 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChildAvatar(child, size: 30),
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 110),
                    child: Text(
                      child.nickname,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: TtFonts.ui, fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ),
                  if (many) Icon(Icons.expand_more_rounded, color: c.muted, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context, WidgetRef ref, List<ChildProfile> kids, int current) async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      builder: (ctx) {
        final text = Theme.of(ctx).textTheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text('Chọn bé', style: text.headlineSmall),
                ),
                for (final k in kids)
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TtRadius.md)),
                    selected: k.id == current,
                    selectedTileColor: ctx.tt.primary.withValues(alpha: 0.12),
                    leading: ChildAvatar(k, size: 40),
                    title: Text(k.nickname, style: text.titleMedium),
                    subtitle: Text(ageLabel(k.ageBand), style: text.bodySmall),
                    trailing: k.id == current ? Icon(Icons.check_rounded, color: ctx.tt.primaryStrong) : null,
                    onTap: () => Navigator.pop(ctx, k.id),
                  ),
              ],
            ),
          ),
        );
      },
    );
    if (picked != null && picked != current) ref.read(selectedChildIdProvider.notifier).select(picked);
  }
}

/// Avatar chữ cái đầu của bé, màu theo id.
class ChildAvatar extends StatelessWidget {
  const ChildAvatar(this.child, {super.key, this.size = 36});
  final ChildProfile child;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = coverColors(child.id + 1);
    final name = child.nickname.replaceFirst(RegExp(r'^Bé\s+', caseSensitive: false), '');
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [colors[0], colors[1]]),
      ),
      child: Text(
        name.isEmpty ? '?' : String.fromCharCode(name.runes.first).toUpperCase(),
        style: TextStyle(fontFamily: TtFonts.display, fontWeight: FontWeight.w800, fontSize: size * 0.45, color: Colors.white, height: 1.1),
      ),
    );
  }
}
