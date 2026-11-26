import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/quiz/kid_quiz_step.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Repo extends Fake implements KidReadingRepository {
  @override
  Future<ChildQuiz> quiz(String sessionId) async => const ChildQuiz(
    sessionId: 1,
    totalQuestions: 2,
    questions: [
      ChildQuizItem(quizItemId: 1, question: 'Câu một?', choices: ['A', 'B']),
      ChildQuizItem(quizItemId: 2, question: 'Câu hai?', choices: ['C', 'D']),
    ],
  );
}

void main() {
  testWidgets(
    'Câu đố mở bằng màn "Em bắt đầu vào câu hỏi nhé", bấm Bắt đầu mới vào câu 1',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(_Repo())],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: KidQuizStep(sessionId: 1, onExpGained: (_) {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Em bắt đầu vào câu hỏi nhé'), findsOneWidget);
      expect(find.text('2 câu hỏi'), findsOneWidget);
      expect(find.text('Câu một?'), findsNothing);

      await tester.tap(find.text('Bắt đầu'));
      await tester.pumpAndSettle();

      expect(find.text('Em bắt đầu vào câu hỏi nhé'), findsNothing);
      expect(find.text('Câu một?'), findsOneWidget);
    },
  );
}
