import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_read_aloud_practice_page.dart';
import 'package:ai_storytelling_mobile/models/child_read_aloud_dto.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

const _practice = ReadAloudPractice(
  interactionId: 5,
  text: 'Mèo ngồi',
  praiseFeedback: 'Em cố thêm chút nữa nhé!',
);

ReadAloudResult _result(int good) => ReadAloudResult(
  sessionId: 1,
  interactionId: 5,
  words: [
    const ReadAloudWord(index: 0, text: 'Mèo', status: 'good'),
    ReadAloudWord(index: 1, text: 'ngồi', status: good == 2 ? 'good' : 'retry'),
  ],
  goodCount: good,
  totalCount: 2,
);

Future<void> _pump(
  WidgetTester tester, {
  ReadAloudResult? result,
  bool recording = false,
  VoidCallback? onPlaySample,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: KidReadAloudPracticePage(
          practice: _practice,
          result: result,
          recording: recording,
          sending: false,
          onMic: () {},
          onRetry: () {},
          onPlaySample: onPlaySample,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'hiện tiêu đề, câu và nút Đọc to; không có Nghe mẫu khi thiếu audio',
    (tester) async {
      await _pump(tester);

      expect(find.text('Luyện đọc to'), findsOneWidget);
      expect(
        find.textContaining('Mèo ngồi', findRichText: true),
        findsOneWidget,
      );
      expect(find.text('Đọc to'), findsOneWidget);
      expect(find.text('Nghe mẫu'), findsNothing);
      expect(find.byTooltip('Đọc lại'), findsNothing);
    },
  );

  testWidgets('có audio mẫu thì hiện Nghe mẫu; đang ghi thì nút là Dừng', (
    tester,
  ) async {
    await _pump(tester, recording: true, onPlaySample: () {});

    expect(find.text('Nghe mẫu'), findsOneWidget);
    expect(find.text('Dừng'), findsOneWidget);
  });

  testWidgets('đọc chưa đúng hết thì hiện lời khích lệ và nút Đọc lại', (
    tester,
  ) async {
    await _pump(tester, result: _result(1));

    expect(find.text('Em cố thêm chút nữa nhé!'), findsOneWidget);
    expect(find.byTooltip('Đọc lại'), findsOneWidget);
  });

  testWidgets('đọc đúng hết thì không hiện lời khích lệ', (tester) async {
    await _pump(tester, result: _result(2));

    expect(find.text('Em cố thêm chút nữa nhé!'), findsNothing);
  });
}
