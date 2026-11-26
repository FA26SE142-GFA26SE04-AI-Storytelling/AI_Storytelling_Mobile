import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_caption_view.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testSegments = [
    ReadingSegment(
      segmentId: 1,
      segmentOrder: 0,
      text:
          'Mặt trời buổi sáng chiếu những tia nắng ấm áp xuống khu rừng rực rỡ sắc màu, chim muông trên các cành cây hót líu lo chào đón một ngày mới ngập tràn niềm vui và những cuộc phiêu lưu đầy thú vị của các bạn nhỏ.',
    ),
    ReadingSegment(
      segmentId: 2,
      segmentOrder: 1,
      text:
          'Chú thỏ trắng tinh nhanh nhẹn nhảy chân sáo qua từng thảm cỏ xanh mướt, vui vẻ nhặt nhạnh từng quả sồi thơm ngon để mang về tặng cho người bà kính yêu đang ngồi chờ đợi trong ngôi nhà gỗ ấm cúng ven suối.',
    ),
  ];

  Future<void> pumpCaptionView(
    WidgetTester tester, {
    required Size size,
    required List<ReadingSegment> segments,
    VoidCallback? onAdvancePage,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: KidCaptionView(
            imageUrl: null,
            segments: segments,
            vocabulary: const [],
            onVocabTap: (_) {},
            activeSegmentId: null,
            isPlaying: false,
            positionStream: const Stream.empty(),
            durationStream: Stream.value(null),
            hasAudio: false,
            topBar: Container(height: 56),
            bottomBarBuilder: (onAdvance) => SizedBox(
              height: 64,
              child: TextButton(
                onPressed: onAdvance,
                child: const Text('Tiếp'),
              ),
            ),
            onAdvancePage: onAdvancePage ?? () {},
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
  }

  group('KidCaptionView layout overflow tests', () {
    testWidgets('renders without overflow at 844x390', (tester) async {
      await pumpCaptionView(
        tester,
        size: const Size(844, 390),
        segments: testSegments,
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(KidCaptionView), findsOneWidget);
    });

    testWidgets('renders without overflow at 1280x800', (tester) async {
      await pumpCaptionView(
        tester,
        size: const Size(1280, 800),
        segments: testSegments,
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(KidCaptionView), findsOneWidget);
    });

    testWidgets(
      'chạm vào phụ đề khi hasAudio: false sẽ gọi onAdvancePage khi chỉ có 1 khúc',
      (tester) async {
        var advanced = false;
        const singleShortSegment = [
          ReadingSegment(
            segmentId: 1,
            segmentOrder: 0,
            text: 'Bé Na đi dạo trong vườn hoa buổi sớm mai.',
          ),
        ];

        await pumpCaptionView(
          tester,
          size: const Size(844, 390),
          segments: singleShortSegment,
          onAdvancePage: () {
            advanced = true;
          },
        );

        final captionTextFinder = find.byWidgetPredicate((widget) {
          if (widget is! Text) return false;
          final content =
              widget.data ?? widget.textSpan?.toPlainText() ?? '';
          return content.contains('Bé Na đi dạo');
        });

        expect(captionTextFinder, findsWidgets);
        await tester.tap(captionTextFinder.first);
        await tester.pump();
        expect(advanced, isTrue);
      },
    );
  });
}
