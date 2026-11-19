import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import 'kid_frog_cue.dart';
import 'kid_frog_painter.dart';
import 'kid_pond_painter.dart';

/// Chuyển động cả thân khi bé chạm ếch (kls-poke trên web).
enum _Motion { hop, spin, squash, dance }

/// Bé chạm ếch: lần lượt các cặp (chuyển động thân, động tác) như POKE_ACTIONS web.
const _pokes = [
  (_Motion.hop, KidFrogAction.wave),
  (_Motion.spin, KidFrogAction.spin),
  (_Motion.squash, KidFrogAction.tongue),
  (_Motion.dance, KidFrogAction.dance),
  (_Motion.squash, KidFrogAction.wink),
];

/// Không ai chạm chừng này thì ếch về cười mỉm.
const _restAfter = Duration(seconds: 8);

/// Ếch hoạt hình trên sảnh, đứng trên bục lá sen giữa hai lá sen nhỏ.
/// Rộng [size], cao 1.08 × [size]; lá sen, quầng sáng và cú nhảy có thể vẽ tràn ra ngoài khung.
class KidLobbyFrog extends StatefulWidget {
  const KidLobbyFrog({super.key, required this.size, required this.cue});

  final double size;
  final KidFrogCue cue;

  @override
  State<KidLobbyFrog> createState() => _KidLobbyFrogState();
}

class _KidLobbyFrogState extends State<KidLobbyFrog>
    with SingleTickerProviderStateMixin {
  final PondFrame _f = PondFrame();
  late final Ticker _ticker = createTicker(_tick);
  Timer? _restTimer;
  bool _reduce = false;
  int _pokeCount = 0;
  double _now = 0, _last = 0;
  double _actAt = -10, _motionAt = -10;
  KidFrogAction? _action;
  _Motion? _motion;
  Offset _pupilTarget = Offset.zero, _parTarget = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.cue.addListener(_onCue);
    widget.cue.pointer.addListener(_onPointer);
    _rest();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduce = MediaQuery.disableAnimationsOf(context);
    if (_reduce) {
      _ticker.stop();
      _resetMotion();
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  @override
  void didUpdateWidget(KidLobbyFrog old) {
    super.didUpdateWidget(old);
    if (old.cue != widget.cue) {
      old.cue.removeListener(_onCue);
      old.cue.pointer.removeListener(_onPointer);
      widget.cue.addListener(_onCue);
      widget.cue.pointer.addListener(_onPointer);
    }
  }

  @override
  void dispose() {
    widget.cue.removeListener(_onCue);
    widget.cue.pointer.removeListener(_onPointer);
    _restTimer?.cancel();
    _ticker.dispose();
    _f.dispose();
    super.dispose();
  }

  /// Đứng yên [_restAfter] thì cười mỉm; mỗi lần có động tác thì vui lại và đếm lại.
  void _rest() {
    _restTimer?.cancel();
    if (_f.pose.smile) {
      _f.pose.smile = false;
      _f.changed();
    }
    _restTimer = Timer(_restAfter, () {
      _f.pose.smile = true;
      _f.changed();
    });
  }

  void _onCue() {
    _rest();
    _action = widget.cue.action;
    _actAt = _now;
  }

  void _poke() {
    HapticFeedback.lightImpact();
    final (motion, action) = _pokes[_pokeCount % _pokes.length];
    _pokeCount++;
    _motion = motion;
    _motionAt = _now;
    widget.cue.act(action);
  }

  void _onPointer() {
    final p = widget.cue.pointer.value;
    final box = context.findRenderObject() as RenderBox?;
    if (p == null || box == null || !box.hasSize || _reduce) {
      _pupilTarget = Offset.zero;
      _parTarget = Offset.zero;
      return;
    }
    // Hướng nhìn: từ giữa hai mắt tới ngón tay, càng xa càng liếc hết cỡ.
    final k = widget.size / kFrogViewW;
    final eyes = box.localToGlobal(Offset(203 * k, 64 * k));
    final v = p - eyes;
    final d = v.distance;
    _pupilTarget = d < 1
        ? Offset.zero
        : v / d * (math.min(1, d / 160) * kFrogPupilMax);
    final screen = MediaQuery.sizeOf(context);
    _parTarget = Offset(
      ((p.dx - screen.width / 2) / (screen.width / 2)).clamp(-1, 1),
      ((p.dy - screen.height / 2) / (screen.height / 2)).clamp(-1, 1),
    );
  }

  void _resetMotion() {
    final p = _f.pose;
    p
      ..breathe = 0
      ..lid = 0
      ..winkLid = 0
      ..pupil = Offset.zero
      ..laugh = 0
      ..wow = 0
      ..blush = 0
      ..tongue = 0
      ..mouthOpen = 0
      ..armDeg = 0;
    _f.idle.reset();
    _f.poke.reset();
    _f.pad.reset();
    _f
      ..ripple = 0
      ..glow = 0.75
      ..glowScale = 1
      ..bobL = 0
      ..bobR = 0
      ..parallax = Offset.zero;
    _f.changed();
  }

  void _tick(Duration elapsed) {
    _now = elapsed.inMicroseconds / 1e6;
    final dt = (_now - _last).clamp(0.0, 0.1);
    _last = _now;
    final p = _f.pose;
    final px =
        widget.size / 300; // các mốc px của CSS web tính cho ếch rộng 300px

    // Nhìn theo ngón tay và lệch theo ngón tay, mượt dần về đích.
    p.pupil = Offset.lerp(p.pupil, _pupilTarget, 1 - math.exp(-dt * 14))!;
    _f.parallax = Offset.lerp(_f.parallax, _parTarget, 1 - math.exp(-dt * 5))!;

    // Thở, chớp mắt (3.42s), thỉnh thoảng lè lưỡi (8.94s).
    p.breathe = 2 * (1 - math.cos(2 * math.pi * _now / 3));
    p.lid = kf(const [0, 1, 0], (_now % 3.42) / 0.22);
    final idleTongue = _now < 2.5 ? -1.0 : ((_now - 2.5) % 8.94) / 0.64;
    var tongue = kf(const [0, 0, 1, 1, 0, 0], idleTongue);
    var mouthOpen = kf(const [0, 1, 1, 1, 1, 0], idleTongue);

    // Hoạt cảnh chờ 7 giây của cả thân + bục lá lún khi đáp.
    final i = (_now % 7) / 7;
    const st = [0, .08, .16, .24, .32, .42, .5, .58, .66, .73, .79, .85, 1.0];
    _f.idle
      ..ty = kfp(st, const [0, 0, 0, 0, 0, 0, 0, 0, -18, 0, 0, 0, 0], i) * px
      ..rot = kfp(st, const [0, 0, 0, 0, -4, 4, 0, 0, 0, 0, 0, 0, 0], i)
      ..sx = kfp(st, const [
        1,
        1.025,
        .99,
        1.025,
        1,
        1,
        1,
        1.08,
        .96,
        1.1,
        .97,
        1,
        1,
      ], i)
      ..sy = kfp(st, const [
        1,
        .975,
        1.015,
        .975,
        1,
        1,
        1,
        .9,
        1.04,
        .88,
        1.04,
        1,
        1,
      ], i);
    const ps = [0, .70, .74, .80, .86, 1.0];
    _f.pad
      ..ty = kfp(ps, const [0, 0, 3, -1, 0, 0], i)
      ..sx = kfp(ps, const [1, 1, 1.04, .99, 1, 1], i)
      ..sy = kfp(ps, const [1, 1, .86, 1.03, 1, 1], i);
    const rs = [0, .72, .74, .92, 1.0];
    _f
      ..ripple = kfp(rs, const [0, 0, .9, 0, 0], i)
      ..rippleSx = kfp(rs, const [1, 1, 1, 1.45, 1.45], i)
      ..rippleSy = kfp(rs, const [1, 1, 1, 1.7, 1.7], i)
      ..glow = kf(const [.55, 1, .55], (_now % 2.6) / 2.6)
      ..glowScale = kf(const [.94, 1.04, .94], (_now % 2.6) / 2.6)
      ..bobL = kf(const [0, -3, 0], (_now % 4) / 4)
      ..bobR = kf(const [0, -3, 0], ((_now + 2) % 4) / 4);

    // Động tác do nút hoặc chạm ếch gọi.
    final a = _now - _actAt;
    final act = _action;
    p
      ..blush = kf(const [0, .85, .85, 0], a / 1.8)
      ..laugh = (act == KidFrogAction.wave || act == KidFrogAction.dance)
          ? kf(const [0, 1, 1, 0], a / 1.4)
          : 0
      ..armDeg = act == KidFrogAction.wave
          ? kf(const [0, -155, -132, -162, -136, -155, 0], a / 1.5)
          : 0
      ..wow = act == KidFrogAction.spin ? kf(const [0, 1, 1, 0], a / 1.2) : 0
      ..winkLid = act == KidFrogAction.wink
          ? kf(const [0, 1, 1, 0], a / .7)
          : 0;
    if (act == KidFrogAction.tongue && a < 0.86) {
      final u = (a - 0.1) / 0.76;
      tongue = math.max(tongue, kf(const [0, 0, 1, 1, 0, 0], u));
      mouthOpen = math.max(mouthOpen, kf(const [0, 1, 1, 1, 1, 0], u));
    }
    p
      ..tongue = tongue
      ..mouthOpen = mouthOpen;

    _applyMotion(_now - _motionAt, px);
    _f.changed();
  }

  /// Các mốc chuyển động cả thân lấy đúng từ kid-lobby.css (kls-poke/spin/squash/dance).
  void _applyMotion(double t, double px) {
    final x = _f.poke..reset();
    _f.pokeAroundCenter = false;
    switch (_motion) {
      case _Motion.hop when t < .75:
        const s = [0, .15, .45, .70, .85, 1.0];
        final u = t / .75;
        x
          ..ty = kfp(s, const [0, 0, -26, 0, 0, 0], u) * px
          ..rot = kfp(s, const [0, 0, -8, 4, 0, 0], u)
          ..sx = kfp(s, const [1, 1.1, .95, 1.08, .98, 1], u)
          ..sy = kfp(s, const [1, .86, 1.07, .9, 1.03, 1], u);
      case _Motion.spin when t < .9:
        const s = [0, .15, .55, .80, 1.0];
        final u = t / .9;
        _f.pokeAroundCenter = true;
        x
          ..ty = kfp(s, const [0, 0, -30, 0, 0], u) * px
          ..rot = kfp(s, const [0, 0, 200, 360, 360], u)
          ..sx = kfp(s, const [1, 1.1, .95, 1.08, 1], u)
          ..sy = kfp(s, const [1, .86, 1.05, .9, 1], u);
      case _Motion.squash when t < .6:
        const s = [0, .30, .60, 1.0];
        x
          ..sx = kfp(s, const [1, 1.08, .97, 1], t / .6)
          ..sy = kfp(s, const [1, .9, 1.04, 1], t / .6);
      case _Motion.dance when t < 1.2:
        const s = [0, .15, .35, .55, .75, 1.0];
        final u = t / 1.2;
        x
          ..tx = kfp(s, const [0, -8, 8, -8, 8, 0], u) * px
          ..ty = kfp(s, const [0, 0, -6, 0, -6, 0], u) * px
          ..rot = kfp(s, const [0, -8, 8, -8, 8, 0], u);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    final VoidCallback onTap = _reduce
        ? () => widget.cue.act(_pokes[_pokeCount++ % _pokes.length].$2)
        : _poke;
    return Semantics(
      button: true,
      label: 'Chạm vào bạn ếch',
      excludeSemantics: true,
      // excludeSemantics bỏ cả hành động bấm của con, nên gắn lại để TalkBack/VoiceOver bấm được.
      onTap: onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // SizedBox cố định: sảnh đo chiều cao nội tại (CustomPaint không có con báo 0).
        child: SizedBox(
          width: s,
          height: s * 1.08,
          child: RepaintBoundary(
            child: CustomPaint(painter: PondPainter(_f, context.tt)),
          ),
        ),
      ),
    );
  }
}
