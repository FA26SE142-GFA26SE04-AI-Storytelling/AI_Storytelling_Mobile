import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

bool _isPlaceholder(Widget w) =>
    w is Image &&
    w.image is AssetImage &&
    (w.image as AssetImage).assetName == 'assets/images/placeholder.png';

Future<void> _pump(WidgetTester tester, String? url) => tester.pumpWidget(
  MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      body: SizedBox(width: 200, height: 150, child: TtNetworkImage(url: url)),
    ),
  ),
);

void main() {
  testWidgets('Không có url thì hiện ảnh mặc định', (tester) async {
    await _pump(tester, null);
    expect(find.byWidgetPredicate(_isPlaceholder), findsOneWidget);
  });

  testWidgets(
    'Ảnh mạng lỗi (HTTP 400 trong môi trường test) thì hiện ảnh mặc định',
    (tester) async {
      await _pump(tester, 'https://example.com/covers/story1.png');
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate(_isPlaceholder), findsOneWidget);
    },
  );
}
