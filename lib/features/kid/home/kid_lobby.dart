import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_rewards_dto.dart';
import '../../../models/my_roadmap_dto.dart';
import '../time/kid_status_provider.dart';
import 'kid_frog_cue.dart';
import 'kid_lobby_frog.dart';
import 'kid_lobby_layout.dart';
import 'kid_lobby_motion.dart';
import 'kid_stage_button.dart';

/// Thông báo khi bé bấm vào truyện bố mẹ chưa mở.
const String kKidLockedStoryMessage = 'Truyện này chưa mở, em chờ bố mẹ nhé.';

/// Sảnh của bé kiểu "hai cột kẹp ếch": ba nút + cúp huy hiệu ở bốn góc quanh bạn ếch,
/// hàng dưới là ĐỌC (chưa có truyện thì mở Kho truyện) | Cây. Màn thấp thì cuộn.
class KidLobby extends StatefulWidget {
  const KidLobby({
    super.key,
    required this.roadmap,
    required this.rewards,
    required this.onRead,
    required this.onLibrary,
    required this.onJourney,
    required this.onNotebook,
    required this.onWish,
    required this.onRewards,
    this.disabledFeatures = const <String>[],
  });

  final MyRoadmapDto roadmap;

  /// Mã chức năng bố mẹ đang tắt (kKidFeature*): nút tương ứng mờ đi, bấm thì báo nhẹ nhàng.
  final List<String> disabledFeatures;

  /// Null khi chưa tải được phần thưởng: khi đó không hiện badge.
  final ChildRewards? rewards;
  final void Function(int storyId) onRead;
  final VoidCallback onLibrary;
  final VoidCallback onJourney;
  final VoidCallback onNotebook;
  final VoidCallback onWish;
  final VoidCallback onRewards;

  @override
  State<KidLobby> createState() => _KidLobbyState();
}

class _KidLobbyState extends State<KidLobby> {
  static const double _button = kKidLobbyButton;

  final KidFrogCue _cue = KidFrogCue();
  Timer? _navLock;

  @override
  void dispose() {
    _navLock?.cancel();
    _cue.dispose();
    super.dispose();
  }

  /// Chặn bấm đúp: mỗi lần chỉ mở một màn.
  void _go(VoidCallback open) {
    if (_navLock?.isActive ?? false) return;
    _navLock = Timer(const Duration(milliseconds: 700), () {});
    open();
  }

  bool _off(String code) => widget.disabledFeatures.contains(code);

  /// Chức năng bị tắt thì chỉ báo, không mở màn (tránh gọi API rồi nhận 403).
  VoidCallback _gate(String code, VoidCallback open) =>
      _off(code) ? () => showTtToast(context, kKidFeatureOffMessage) : open;

  void _onGo() {
    final open = widget.roadmap.open;
    if (open == null) return _go(_gate(kKidFeatureLibrary, widget.onLibrary));
    if (open.isLocked) return showTtToast(context, kKidLockedStoryMessage);
    _go(() => widget.onRead(open.storyId));
  }

  /// Xuất hiện lần lượt (kl-pop web): phóng .85 → 1 và trồi lên 6px.
  Widget _pop(Widget child, int order) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    const curve = Cubic(0.2, 0.9, 0.3, 1.3);
    return child
        .animate(delay: (70 * order).ms)
        .fadeIn(duration: 300.ms)
        .scaleXY(begin: 0.85, end: 1, duration: 450.ms, curve: curve)
        .moveY(begin: 6, end: 0, duration: 450.ms, curve: curve);
  }

  /// Nút tròn: chạm xuống là ếch làm [action]; nhấp nhô lệch nhịp theo [period]/[phase].
  Widget _btn(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
    KidFrogAction action, {
    required int order,
    int periodMs = 3200,
    double phase = 0,
    Color iconColor = Colors.white,
    int? badge,
    String? badgeLabel,
    String? feature,
  }) {
    final off = feature != null && _off(feature);
    return _pop(
      KidBob(
        period: Duration(milliseconds: periodMs),
        phase: phase,
        child: Opacity(
          opacity: off ? 0.45 : 1,
          child: KidStageButton(
            label: label,
            icon: icon,
            color: color,
            iconColor: iconColor,
            onTap: () => _go(feature == null ? onTap : _gate(feature, onTap)),
            onDown: () => _cue.act(action),
            badge: off ? null : badge,
            badgeLabel: badgeLabel,
            diameter: _button,
          ),
        ),
      ),
      order,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final w = widget;
    final reduce = MediaQuery.disableAnimationsOf(context);
    final earned = w.rewards?.badges.where((b) => b.earned).length;
    final water = w.rewards?.knowledgeTree.expToWater;
    final hasOpen = w.roadmap.open != null;

    Widget go = KidBtn3D(
      label: hasOpen ? 'Đọc ngay' : 'Chọn truyện',
      // Giống web: "Chọn truyện" không kèm icon để chữ đủ to trên màn hẹp.
      icon: hasOpen ? Icons.play_arrow_rounded : null,
      color: tt.gold,
      foregroundColor: kKidInkOnBright,
      big: true,
      expand: true,
      onPressed: _onGo,
    );
    if (!reduce) {
      go = go
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(
            begin: 1,
            end: 1.04,
            duration: 1200.ms,
            curve: Curves.easeInOut,
          );
    }
    go = KidBob(
      period: const Duration(milliseconds: 3500),
      phase: 0.25,
      child: KidMagnet(onDown: () => _cue.act(KidFrogAction.wave), child: go),
    );

    final parts = KidLobbyParts(
      frog: (size) => _pop(KidLobbyFrog(size: size, cue: _cue), 2),
      journey: _btn(
        'Hành trình',
        Icons.map_rounded,
        tt.sky,
        w.onJourney,
        KidFrogAction.wave,
        order: 1,
      ),
      notebook: _btn(
        'Sổ tay',
        Icons.edit_note_rounded,
        tt.mint,
        w.onNotebook,
        KidFrogAction.wink,
        order: 3,
        periodMs: 3800,
        feature: kKidFeatureNotebook,
      ),
      wish: _btn(
        'Điều ước',
        Icons.auto_awesome_rounded,
        tt.lotus,
        w.onWish,
        KidFrogAction.wave,
        order: 1,
        phase: 0.5,
        iconColor: kKidInkOnBright,
        feature: kKidFeatureWishes,
      ),
      // Cúp chỉ để xem (không bấm): số huy hiệu bé đã đạt.
      badges: _pop(
        KidBob(
          period: const Duration(milliseconds: 3800),
          phase: 0.5,
          child: KidTrophyMedal(count: earned, diameter: _button),
        ),
        3,
      ),
      bottom: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _pop(go, 5)),
          const SizedBox(width: 6),
          _btn(
            'Cây',
            Icons.eco_rounded,
            tt.primary,
            w.onRewards,
            KidFrogAction.tongue,
            order: 4,
            phase: 0.5,
            badge: water,
            badgeLabel: '$water giọt nước chờ tưới',
            feature: kKidFeatureRewards,
          ),
        ],
      ),
    );

    // Theo dõi ngón tay trên cả sảnh (không chặn cử chỉ) để ếch nhìn theo và sân khấu lệch theo.
    return Listener(
      onPointerDown: (e) => _cue.pointer.value = e.position,
      onPointerMove: (e) => _cue.pointer.value = e.position,
      onPointerUp: (_) => _cue.pointer.value = null,
      onPointerCancel: (_) => _cue.pointer.value = null,
      child: LayoutBuilder(
        builder: (context, c) {
          final body = kidLobbyLayout(c, parts);
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [SliverFillRemaining(hasScrollBody: false, child: body)],
          );
        },
      ),
    );
  }
}
