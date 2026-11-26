import 'package:flutter/material.dart';

import 'package:ai_storytelling_mobile/features/kid/kid_responsive.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../models/child_reading_dto.dart';

/// Ô biểu diễn một hình minh hoạ cảnh truyện cho bé chọn.
class KidSceneTile {
  const KidSceneTile({
    required this.sceneId,
    this.beatOrder,
    required this.number,
    this.imageUrl,
  });

  final int sceneId;
  final int? beatOrder;
  final int number;
  final String? imageUrl;

  String get key => '$sceneId-${beatOrder ?? ''}';
  String get label => 'Tranh $number';
}

/// Tạo danh sách các ô tranh từ danh sách cảnh truyện theo đúng thứ tự.
List<KidSceneTile> buildKidSceneTiles(List<ReadingScene> scenes) {
  final sortedScenes = List<ReadingScene>.from(scenes)
    ..sort((a, b) => a.sceneIndex.compareTo(b.sceneIndex));
  final tiles = <KidSceneTile>[];
  var counter = 1;

  for (final scene in sortedScenes) {
    final validIllustrations =
        (scene.illustrations ?? const <SceneIllustration>[])
            .where((ill) => ill.url != null && ill.url!.trim().isNotEmpty)
            .toList()
          ..sort((a, b) => a.beatOrder.compareTo(b.beatOrder));

    if (validIllustrations.isNotEmpty) {
      for (final ill in validIllustrations) {
        tiles.add(
          KidSceneTile(
            sceneId: scene.sceneId,
            beatOrder: ill.beatOrder,
            number: counter++,
            imageUrl: ill.url,
          ),
        );
      }
    } else {
      tiles.add(
        KidSceneTile(
          sceneId: scene.sceneId,
          beatOrder: null,
          number: counter++,
          imageUrl: scene.illustrationUrl,
        ),
      );
    }
  }

  return tiles;
}

/// Lưới ô tranh dùng chung cho các bước tương tác truyện của trẻ em.
class KidSceneGrid extends StatelessWidget {
  const KidSceneGrid({
    super.key,
    required this.tiles,
    this.pickedKey,
    this.doneKeys = const {},
    this.disabled = false,
    required this.onPick,
  });

  final List<KidSceneTile> tiles;
  final String? pickedKey;
  final Set<String> doneKeys;
  final bool disabled;
  final ValueChanged<KidSceneTile> onPick;

  Widget _buildTile(BuildContext context, KidSceneTile tile, TtColors tt) {
    final isPicked = pickedKey == tile.key;
    final isDone = doneKeys.contains(tile.key);
    final isClickable = !disabled && !isDone;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isClickable ? () => onPick(tile) : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isPicked ? tt.gold.withValues(alpha: 0.25) : tt.panel,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isPicked ? tt.gold : tt.line2,
              width: isPicked ? 3.0 : 1.5,
            ),
            boxShadow: isPicked
                ? [
                    BoxShadow(
                      color: tt.goldDeep.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              fit: StackFit.expand,
              children: [
                TtNetworkImage(
                  url: tile.imageUrl,
                  fit: BoxFit.cover,
                  radius: BorderRadius.zero,
                ),
                if (isDone) Container(color: tt.panel.withValues(alpha: 0.4)),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tt.panel.withValues(alpha: 0.88),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        tile.label,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isPicked ? tt.warnInk : tt.text,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                if (isDone)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: tt.panel,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: tt.primary,
                        size: 22,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return GridView.count(
      crossAxisCount:
          kidGridColumns(MediaQuery.sizeOf(context).width, phone: 3),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.85,
      children: tiles.map((tile) => _buildTile(context, tile, tt)).toList(),
    );
  }
}
