import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/read_aloud_words.dart';
import 'package:ai_storytelling_mobile/models/read_aloud_dto.dart';

void main() {
  group('ReadAloudWordsView', () {
    testWidgets(
        'Hiển thị từ đọc đúng/thử lại/bỏ qua, kiểu chữ khác nhau và bấm Đọc lại',
        (tester) async {
      var retryCalled = false;

      const result = ReadAloudResultDto(
        sessionId: 1,
        segmentId: 2,
        words: [
          ReadAloudWordDto(index: 0, text: 'Ếch', status: 'good'),
          ReadAloudWordDto(
            index: 1,
            text: 'nhảy',
            status: 'retry',
            hint: 'tone',
          ),
          ReadAloudWordDto(index: 2, text: 'lá', status: 'skipped'),
        ],
        goodCount: 1,
        retryCount: 1,
        skippedCount: 1,
        totalCount: 3,
        message: 'Em đọc hay quá!',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: ReadAloudWordsView(
              result: result,
              onRetry: () {
                retryCalled = true;
              },
            ),
          ),
        ),
      );
      await tester.pump();

      // Kiểm tra sự xuất hiện của các chữ và nút 'Đọc lại'
      expect(find.text('Ếch'), findsOneWidget);
      expect(find.text('nhảy'), findsOneWidget);
      expect(find.text('lá'), findsOneWidget);
      expect(find.text('Đọc lại'), findsOneWidget);

      // Kiểm tra style màu và độ đậm
      final echText = tester.widget<Text>(find.text('Ếch'));
      final laText = tester.widget<Text>(find.text('lá'));

      expect(echText.style?.color, isNot(equals(laText.style?.color)));
      expect(echText.style?.fontWeight, FontWeight.bold);

      // Bấm nút 'Đọc lại' -> callback onRetry được gọi
      await tester.tap(find.text('Đọc lại'));
      await tester.pump();

      expect(retryCalled, isTrue);
    });
  });
}
