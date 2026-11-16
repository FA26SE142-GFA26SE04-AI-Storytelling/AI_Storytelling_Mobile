import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_read_aloud_ranges.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_page.dart';
import 'package:ai_storytelling_mobile/models/child_read_aloud_dto.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const fullText = 'Bé Na đi học. Mèo ăn cá.';
  const seg1Text = 'Bé Na đi học.';
  const seg2Text = 'Mèo ăn cá.';

  final seg1Start = fullText.indexOf(seg1Text);
  final seg1End = seg1Start + seg1Text.length;
  final seg2Start = fullText.indexOf(seg2Text);
  final seg2End = seg2Start + seg2Text.length;

  final testScene = ReadingScene(
    sceneId: 10,
    sceneIndex: 0,
    text: fullText,
    segments: [
      ReadingSegment(
        segmentId: 1,
        segmentOrder: 0,
        startOffset: seg1Start,
        endOffset: seg1End,
        text: seg1Text,
      ),
      ReadingSegment(
        segmentId: 2,
        segmentOrder: 1,
        startOffset: seg2Start,
        endOffset: seg2End,
        text: seg2Text,
      ),
    ],
  );

  Widget buildTestWidget({
    required ReadingScene scene,
    int? aloudSegmentId,
    ReadAloudResult? aloudResult,
  }) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: KidReaderPage(
            scene: scene,
            vocabulary: const <ReadingVocabulary>[],
            isWide: false,
            aloudSegmentId: aloudSegmentId,
            aloudResult: aloudResult,
            onVocabTap: (_) {},
          ),
        ),
      ),
    );
  }

  List<TextSpan> collectTextSpans(InlineSpan root) {
    final result = <TextSpan>[];
    if (root is TextSpan) {
      if (root.text != null && root.text!.isNotEmpty) {
        result.add(root);
      }
      if (root.children != null) {
        for (final child in root.children!) {
          result.addAll(collectTextSpans(child));
        }
      }
    }
    return result;
  }

  group('KidReaderPage Read Aloud Tests', () {
    testWidgets(
      'Test 1: aloudResult segment 1 tô màu đúng status good, retry và không đổi style segment 2',
      (tester) async {
        const aloudResult = ReadAloudResult(
          sessionId: 100,
          segmentId: 1,
          words: [
            ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
            ReadAloudWord(index: 1, text: 'Na', status: 'retry'),
            ReadAloudWord(index: 2, text: 'đi', status: 'good'),
            ReadAloudWord(index: 3, text: 'học', status: 'skipped'),
          ],
        );

        await tester.pumpWidget(
          buildTestWidget(
            scene: testScene,
            aloudResult: aloudResult,
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(KidReaderPage));
        final tt = context.tt;

        final richTextFinder = find.descendant(
          of: find.byType(KidReaderPage),
          matching: find.byType(RichText),
        );
        final richText = tester.widget<RichText>(richTextFinder.first);
        final spans = collectTextSpans(richText.text);

        final beSpan = spans.firstWhere((s) => s.text!.contains('Bé'));
        final naSpan = spans.firstWhere((s) => s.text!.contains('Na'));
        final meoSpan = spans.firstWhere((s) => s.text!.contains('Mèo'));

        // 'Bé' có style.color == tt.primary (lấy từ TtColors của theme trong test, hoặc so với readAloudStyle('good', tt))
        expect(beSpan.style?.color, equals(tt.primary));
        expect(beSpan.style?.color, equals(readAloudStyle('good', tt).color));

        // 'Na' có backgroundColor != null
        expect(naSpan.style?.backgroundColor, isNotNull);
        expect(
          naSpan.style?.backgroundColor,
          equals(readAloudStyle('retry', tt).backgroundColor),
        );

        // Chữ thuộc segment 2 (ví dụ 'Mèo') không bị đổi color/backgroundColor so với mặc định (không phải good/retry)
        final goodStyle = readAloudStyle('good', tt);
        final retryStyle = readAloudStyle('retry', tt);
        expect(meoSpan.style?.color, isNot(equals(goodStyle.color)));
        expect(meoSpan.style?.color, isNull);
        expect(
          meoSpan.style?.backgroundColor,
          isNot(equals(retryStyle.backgroundColor)),
        );
        expect(meoSpan.style?.backgroundColor, isNull);
      },
    );

    testWidgets(
      'Test 2: aloudSegmentId = 2, aloudResult null -> ký tự thuộc segment 2 có nền vàng, segment 1 không có nền vàng',
      (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            scene: testScene,
            aloudSegmentId: 2,
            aloudResult: null,
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(KidReaderPage));
        final tt = context.tt;

        final richTextFinder = find.descendant(
          of: find.byType(KidReaderPage),
          matching: find.byType(RichText),
        );
        final richText = tester.widget<RichText>(richTextFinder.first);
        final spans = collectTextSpans(richText.text);

        final beSpan = spans.firstWhere((s) => s.text!.contains('Bé'));
        final meoSpan = spans.firstWhere((s) => s.text!.contains('Mèo'));

        final expectedGoldBg = tt.gold.withValues(alpha: 0.25);

        // ký tự thuộc segment 2 có backgroundColor == tt.gold.withValues(alpha: 0.25)
        expect(meoSpan.style?.backgroundColor, equals(expectedGoldBg));

        // ký tự segment 1 không có nền vàng
        expect(beSpan.style?.backgroundColor, isNot(equals(expectedGoldBg)));
        expect(beSpan.style?.backgroundColor, isNull);
      },
    );

    testWidgets(
      'Test 3: aloudResult có segmentId không tồn tại trong scene -> không crash, không có chữ nào bị đổi style theo status',
      (tester) async {
        const aloudResult = ReadAloudResult(
          sessionId: 100,
          segmentId: 999,
          words: [
            ReadAloudWord(index: 0, text: 'Bé', status: 'good'),
            ReadAloudWord(index: 1, text: 'Na', status: 'retry'),
          ],
        );

        await tester.pumpWidget(
          buildTestWidget(
            scene: testScene,
            aloudResult: aloudResult,
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(find.byType(KidReaderPage));
        final tt = context.tt;

        final richTextFinder = find.descendant(
          of: find.byType(KidReaderPage),
          matching: find.byType(RichText),
        );
        final richText = tester.widget<RichText>(richTextFinder.first);
        final spans = collectTextSpans(richText.text);

        final goodStyle = readAloudStyle('good', tt);
        final retryStyle = readAloudStyle('retry', tt);

        for (final span in spans) {
          expect(span.style?.color, isNot(equals(goodStyle.color)));
          expect(span.style?.color, isNull);
          expect(
            span.style?.backgroundColor,
            isNot(equals(retryStyle.backgroundColor)),
          );
          expect(span.style?.backgroundColor, isNull);
        }
      },
    );
  });
}
