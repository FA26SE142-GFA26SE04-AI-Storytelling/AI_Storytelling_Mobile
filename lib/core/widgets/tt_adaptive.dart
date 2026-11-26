import 'package:flutter/material.dart';

/// Rộng từ mức này (iPad ngang, máy tính bảng lớn) thì màn phụ huynh chia 2 cột thẻ.
const double kTwoColumnMinWidth = 900;

/// Bề rộng tối đa của nội dung: điện thoại / iPad dọc một cột, iPad ngang hai cột.
const double kContentMaxWidth = 720;
const double kWideContentMaxWidth = 1200;

/// Khung nội dung của một màn: căn giữa trên cùng, giới hạn bề rộng theo khổ màn
/// (≥ [kTwoColumnMinWidth] thì nới tới [kWideContentMaxWidth] để vừa 2 cột, ít khoảng trắng).
class TtContentWidth extends StatelessWidget {
  const TtContentWidth({super.key, required this.child, this.maxWidth});

  final Widget child;

  /// Ép một bề rộng tối đa riêng (vd. màn chỉ có một cột hẹp như đăng nhập).
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final limit = maxWidth ??
        (width >= kTwoColumnMinWidth ? kWideContentMaxWidth : kContentMaxWidth);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: limit),
        child: child,
      ),
    );
  }
}

/// Xếp các thẻ của màn phụ huynh: khung rộng ≥ [kTwoColumnMinWidth] thì [left] và [right]
/// thành 2 cột cạnh nhau (mỗi cột tự xếp dọc), hẹp hơn thì xếp dọc [left] rồi [right].
class TtAdaptiveColumns extends StatelessWidget {
  const TtAdaptiveColumns({
    super.key,
    required this.left,
    required this.right,
    this.spacing = 16,
  });

  final List<Widget> left;
  final List<Widget> right;
  final double spacing;

  List<Widget> _gapped(List<Widget> items) => [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          items[i],
        ],
      ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < kTwoColumnMinWidth) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _gapped([...left, ...right]),
          );
        }
        Widget column(List<Widget> items) => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _gapped(items),
              ),
            );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [column(left), SizedBox(width: spacing), column(right)],
        );
      },
    );
  }
}
