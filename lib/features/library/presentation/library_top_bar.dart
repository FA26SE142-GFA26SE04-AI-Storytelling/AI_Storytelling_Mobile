import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';

/// Nền thanh dính đầu: hơi trong suốt + làm mờ nội dung cuộn phía sau.
class LibraryFrostedBar extends StatelessWidget {
  const LibraryFrostedBar({super.key, required this.child, this.side = 16});

  final Widget child;
  final double side;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: context.tt.bg.withValues(alpha: 0.86),
          padding: EdgeInsets.fromLTRB(side, 8, side, 8),
          child: child,
        ),
      ),
    );
  }
}

/// Thanh trên dính đầu của Trang chủ: tên app + nút tìm (sang tab Tìm kiếm)
/// + [trailing].
class LibraryTopBar extends StatelessWidget {
  const LibraryTopBar({
    super.key,
    required this.onOpenSearch,
    this.side = 16,
    this.trailing = const [],
  });

  final VoidCallback onOpenSearch;
  final double side;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return LibraryFrostedBar(
      side: side,
      child: Row(
        children: [
          Expanded(
            // Màn hẹp thì thu nhỏ chữ cho vừa thay vì cắt "...".
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'TaleTale',
                maxLines: 1,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: context.tt.primaryStrong),
              ),
            ),
          ),
          TtIconButton(
            icon: Icons.search_rounded,
            tooltip: 'Tìm truyện',
            size: 40,
            onPressed: onOpenSearch,
          ),
          for (final w in trailing) ...[const SizedBox(width: 8), w],
        ],
      ),
    );
  }
}
