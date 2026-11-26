import 'package:ai_storytelling_mobile/core/widgets/tt_adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, double width) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: TtContentWidth(
          child: TtAdaptiveColumns(
            left: [SizedBox(key: Key('a'), height: 50)],
            right: [SizedBox(key: Key('b'), height: 50)],
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('hẹp hơn 900: xếp dọc, nội dung tối đa 720', (tester) async {
    await _pump(tester, 834);
    final a = tester.getRect(find.byKey(const Key('a')));
    final b = tester.getRect(find.byKey(const Key('b')));
    expect(b.top, greaterThan(a.bottom));
    expect(a.width, 720);
  });

  testWidgets('từ 900: hai cột cạnh nhau, tổng tối đa 1200', (tester) async {
    await _pump(tester, 1366);
    final a = tester.getRect(find.byKey(const Key('a')));
    final b = tester.getRect(find.byKey(const Key('b')));
    expect(a.top, b.top);
    expect(b.left, greaterThan(a.right));
    expect(b.right - a.left, 1200);
  });
}
