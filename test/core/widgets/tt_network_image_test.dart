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

  _cropTests();
}

void _cropTests() {
  test('splitCover tách đuôi #crop= và giữ vùng cắt trong ảnh', () {
    final r = splitCover('https://a.vn/b.jpg#crop=0.1,0.05,0.6,0.8');
    expect(r.src, 'https://a.vn/b.jpg');
    expect(r.crop, (x: 0.1, y: 0.05, w: 0.6, h: 0.8));

    // x vượt khỏi ảnh thì kéo về trong khoảng 0..1-w.
    expect(splitCover('u#crop=0.9,-1,0.5,0.5').crop, (
      x: 0.5,
      y: 0.0,
      w: 0.5,
      h: 0.5,
    ));
    // Vùng cắt sai thì bỏ, vẫn giữ link ảnh.
    expect(splitCover('u#crop=0,0,0,1'), (src: 'u', crop: null));
    expect(splitCover(' u '), (src: 'u', crop: null));
    expect(splitCover(null), (src: '', crop: null));
  });

  testWidgets('Ảnh có vùng cắt vẫn hiện ảnh mặc định khi ảnh lỗi', (
    tester,
  ) async {
    await _pump(tester, 'https://example.com/c.png#crop=0.1,0.1,0.5,0.5');
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate(_isPlaceholder), findsOneWidget);
  });
}
