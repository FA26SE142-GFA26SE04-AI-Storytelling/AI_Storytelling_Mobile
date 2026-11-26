import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_frog.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_network_image.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_page.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import '../../../support/ipad_sizes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testScene = ReadingScene(
    sceneId: 101,
    sceneIndex: 0,
    text: 'Bé Na đi dạo trong vườn hoa. Bé thấy chú ếch nhỏ tinh nghịch.',
    segments: [
      ReadingSegment(
        segmentId: 1,
        segmentOrder: 0,
        startOffset: 0,
        endOffset: 26,
        text: 'Bé Na đi dạo trong vườn hoa.',
      ),
      ReadingSegment(
        segmentId: 2,
        segmentOrder: 1,
        startOffset: 27,
        endOffset: 59,
        text: 'Bé thấy chú ếch nhỏ tinh nghịch.',
      ),
    ],
  );

  Future<void> pumpAt(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: KidReaderPage(
            scene: testScene,
            vocabulary: const [],
            layout: kidReaderLayoutFor(size, preferCaption: false),
            onVocabTap: (_) {},
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }

  group('Test 1: kidReaderLayoutFor breakpoint logic', () {
    test('resolves correct KidReaderLayout based on screen dimensions', () {
      expect(
        kidReaderLayoutFor(const Size(360, 740)),
        KidReaderLayout.stacked,
      );
      expect(
        kidReaderLayoutFor(const Size(740, 360), preferCaption: false),
        KidReaderLayout.sideBySide,
      );
      expect(
        kidReaderLayoutFor(const Size(1280, 800), preferCaption: false),
        KidReaderLayout.book,
      );
      expect(
        kidReaderLayoutFor(const Size(800, 1280)),
        KidReaderLayout.stacked,
      );
    });

    test('resolves caption layout when preferCaption is default (true)', () {
      expect(
        kidReaderLayoutFor(const Size(740, 360)),
        KidReaderLayout.caption,
      );
      expect(
        kidReaderLayoutFor(const Size(1280, 800)),
        KidReaderLayout.caption,
      );
      expect(
        kidReaderLayoutFor(const Size(360, 740)),
        KidReaderLayout.stacked,
      );
    });
  });

  group('Test 2: Layout rendering without overflow across 4 sizes', () {
    testWidgets('renders without overflow across iPad sizes', (tester) async {
      for (final size in kIpadSizes.values) {
        await pumpAt(tester, size);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('renders without overflow at 360x740 (stacked)', (tester) async {
      await pumpAt(tester, const Size(360, 740));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow at 740x360 (sideBySide)', (tester) async {
      await pumpAt(tester, const Size(740, 360));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow at 1280x800 (book)', (tester) async {
      await pumpAt(tester, const Size(1280, 800));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow at 800x1280 (stacked)', (tester) async {
      await pumpAt(tester, const Size(800, 1280));
      expect(tester.takeException(), isNull);
    });
  });

  group('Test 3: TtFrog presence in book layout', () {
    testWidgets('layout book (1280x800) displays TtFrog mascot', (tester) async {
      await pumpAt(tester, const Size(1280, 800));
      expect(find.byType(TtFrog), findsOneWidget);
    });
  });

  group('Test 4: Top distance from KidReaderPage to TtWholeImage', () {
    testWidgets('layout sideBySide (740x360) distance is less than 40 px', (tester) async {
      await pumpAt(tester, const Size(740, 360));
      final pageTop = tester.getTopLeft(find.byType(KidReaderPage)).dy;
      final imageTop = tester.getTopLeft(find.byType(TtWholeImage)).dy;
      final distance = imageTop - pageTop;
      expect(distance, lessThan(40));
    });

    testWidgets('layout book (1280x800) distance is less than 48 px (padding 24 + border)', (tester) async {
      await pumpAt(tester, const Size(1280, 800));
      final pageTop = tester.getTopLeft(find.byType(KidReaderPage)).dy;
      final imageTop = tester.getTopLeft(find.byType(TtWholeImage)).dy;
      final distance = imageTop - pageTop;
      // Ghi chú: Layout book có Padding 24 kèm viền trang trí nên nới ngưỡng tối đa lên 48 px
      expect(distance, lessThan(48));
    });
  });

  group('Test 5: TtFrog absence in stacked layout', () {
    testWidgets('layout stacked (360x740) does not display TtFrog', (tester) async {
      await pumpAt(tester, const Size(360, 740));
      expect(find.byType(TtFrog), findsNothing);
    });
  });
}
