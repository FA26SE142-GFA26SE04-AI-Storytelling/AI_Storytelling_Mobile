import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Trạng thái cảm xúc của linh vật ếch Đầm Sen.
enum TtFrogMood {
  idle,
  happy,
  think,
}

/// Widget hiển thị linh vật ếch Đầm Sen với hiệu ứng nhún nhẹ khi xuất hiện.
class TtFrog extends StatelessWidget {
  const TtFrog({
    super.key,
    this.mood = TtFrogMood.idle,
    this.size = 120,
    this.faceOnly = false,
  });

  /// Cảm xúc hiện tại của ếch.
  final TtFrogMood mood;

  /// Kích thước chiều rộng cơ bản của linh vật.
  final double size;

  /// Chỉ hiển thị phần đầu (khoảng 40-60% phía trên).
  final bool faceOnly;

  String get _assetPath {
    switch (mood) {
      case TtFrogMood.idle:
        return 'assets/images/frog_idle.svg';
      case TtFrogMood.happy:
        return 'assets/images/frog_happy.svg';
      case TtFrogMood.think:
        return 'assets/images/frog_think.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget hình ảnh ếch kèm hiệu ứng nhún 1 lần khi xuất hiện
    final Widget frogImage = SvgPicture.asset(
      _assetPath,
      width: size,
      height: size * 1.135,
      semanticsLabel: 'Linh vật ếch Đầm Sen',
    )
        .animate()
        .moveY(begin: 0, end: -8, duration: 400.ms, curve: Curves.easeOut)
        .then()
        .moveY(begin: -8, end: 0, duration: 300.ms, curve: Curves.easeIn);

    if (faceOnly) {
      return SizedBox(
        width: size,
        height: size * 0.6,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            child: frogImage,
          ),
        ),
      );
    }

    return frogImage;
  }
}
