import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/widgets/kid_panel.dart';

/// Thay "nam châm" theo chuột của web: khi bé giữ nút, nút dịch và nghiêng nhẹ về phía ngón tay;
/// thả tay thì nảy về. [onDown] gọi ngay khi chạm xuống. Không tham gia tranh chấp cử chỉ.
class KidMagnet extends StatefulWidget {
  const KidMagnet({super.key, required this.child, this.onDown});

  final Widget child;
  final VoidCallback? onDown;

  @override
  State<KidMagnet> createState() => _KidMagnetState();
}

class _KidMagnetState extends State<KidMagnet> {
  Offset _n = Offset.zero;
  bool _down = false;

  void _track(Offset local) {
    final size = context.size;
    if (size == null || size.isEmpty) return;
    final n = Offset(
      ((local.dx - size.width / 2) / (size.width / 2)).clamp(-1, 1),
      ((local.dy - size.height / 2) / (size.height / 2)).clamp(-1, 1),
    );
    setState(() {
      _down = true;
      _n = n;
    });
  }

  void _release() {
    if (_down) setState(() => _down = false);
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    return Listener(
      onPointerDown: (e) {
        widget.onDown?.call();
        if (!reduce) _track(e.localPosition);
      },
      onPointerMove: reduce ? null : (e) => _track(e.localPosition),
      onPointerUp: (_) => _release(),
      onPointerCancel: (_) => _release(),
      child: reduce
          ? widget.child
          : TweenAnimationBuilder<Offset>(
              tween: Tween(end: _down ? _n : Offset.zero),
              duration: Duration(milliseconds: _down ? 120 : 350),
              curve: _down ? Curves.easeOut : kKidBounceCurve,
              builder: (context, o, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..translateByDouble(o.dx * 5, o.dy * 4, 0, 1)
                  ..rotateX(-o.dy * 0.22)
                  ..rotateY(o.dx * 0.22),
                child: child,
              ),
              child: widget.child,
            ),
    );
  }
}

/// Nhấp nhô lên xuống [amplitude] px theo chu kỳ [period] (kls-bob / kl-drift web).
/// [phase] 0..1 để các nút không nhún đồng loạt. Tắt khi giảm chuyển động.
class KidBob extends StatefulWidget {
  const KidBob({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 3200),
    this.phase = 0,
    this.amplitude = 5,
  });

  final Widget child;
  final Duration period;
  final double phase;
  final double amplitude;

  @override
  State<KidBob> createState() => _KidBobState();
}

class _KidBobState extends State<KidBob> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.period,
  )..value = widget.phase;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          0,
          -widget.amplitude * (1 - math.cos(2 * math.pi * _c.value)) / 2,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
