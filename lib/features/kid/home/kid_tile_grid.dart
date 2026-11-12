import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';

class KidTileGrid extends StatelessWidget {
  const KidTileGrid({
    super.key,
    required this.onOpen,
    this.crossAxisCount = 2,
  });

  final void Function(String title) onOpen;
  final int crossAxisCount;

  static const List<({String title, IconData icon})> _tiles = [
    (title: 'Truyện', icon: Icons.menu_book_rounded),
    (title: 'Sổ tay', icon: Icons.edit_note_rounded),
    (title: 'Điều ước', icon: Icons.auto_awesome_rounded),
    (title: 'Phần thưởng', icon: Icons.emoji_events_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final borderRadius = BorderRadius.circular(TtRadius.xl);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: _tiles.map((tile) {
        return Container(
          constraints: const BoxConstraints(minHeight: 120),
          decoration: BoxDecoration(
            color: tt.panel,
            borderRadius: borderRadius,
            border: Border.all(
              color: tt.line2,
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: tt.shadow.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onOpen(tile.title),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tile.icon,
                      size: 44,
                      color: tt.goldDeep,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tile.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: tt.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
