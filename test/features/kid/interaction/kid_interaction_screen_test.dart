import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/interaction/kid_interaction_screen.dart';
import 'package:ai_storytelling_mobile/models/child_interaction_dto.dart';

Widget _buildApp({required Widget home}) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.light(),
      home: home,
    ),
  );
}

Future<void> _pumpScreen(WidgetTester tester, Widget screen) async {
  await tester.pumpWidget(_buildApp(home: screen));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> _pumpAction(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> _settleFeedback(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> _usePhoneSize(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

void main() {
  group('Nhóm 1 — gửi đúng body (đếm tham số của onAttempt)', () {
    testWidgets('a) Checkpoint: tap option id=2 calls onAttempt with optionId == 2, answer == null, orderedOptionIds == null', (tester) async {
      await _usePhoneSize(tester);
      int? capturedOptionId;
      String? capturedAnswer;
      List<int>? capturedOrderedOptionIds;

      final interaction = ReadingInteraction(
        id: 101,
        type: 'Checkpoint',
        prompt: 'Câu hỏi kiểm tra?',
        options: const [
          InteractionOption(id: 1, text: 'Đáp án 1'),
          InteractionOption(id: 2, text: 'Đáp án 2'),
          InteractionOption(id: 3, text: 'Đáp án 3'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOptionId = optionId;
            capturedAnswer = answer;
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 101,
                type: 'Checkpoint',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final optionFinder = find.text('Đáp án 2');
      await tester.ensureVisible(optionFinder);
      await tester.tap(optionFinder);
      await _pumpAction(tester);

      expect(capturedOptionId, 2);
      expect(capturedAnswer, isNull);
      expect(capturedOrderedOptionIds, isNull);
    });

    testWidgets('b) PicturePrediction: tap a card calls onAttempt with correct optionId and null answer', (tester) async {
      await _usePhoneSize(tester);
      int? capturedOptionId;
      String? capturedAnswer;
      List<int>? capturedOrderedOptionIds;

      final interaction = ReadingInteraction(
        id: 102,
        type: 'PicturePrediction',
        prompt: 'Đoán tranh tiếp theo?',
        options: const [
          InteractionOption(id: 10, text: 'Bức tranh A'),
          InteractionOption(id: 20, text: 'Bức tranh B'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOptionId = optionId;
            capturedAnswer = answer;
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 102,
                type: 'PicturePrediction',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final cardFinder = find.text('Bức tranh B');
      await tester.ensureVisible(cardFinder);
      await tester.tap(cardFinder);
      await _pumpAction(tester);

      expect(capturedOptionId, 20);
      expect(capturedAnswer, isNull);
      expect(capturedOrderedOptionIds, isNull);
    });

    testWidgets('c) RolePlay: tap "Em nói xong rồi" calls onAttempt with all null parameters', (tester) async {
      await _usePhoneSize(tester);
      int? capturedOptionId = -1;
      String? capturedAnswer = 'init';
      List<int>? capturedOrderedOptionIds = [-1];

      final interaction = const ReadingInteraction(
        id: 103,
        type: 'RolePlay',
        prompt: 'Hãy nói theo nhân vật',
        characterName: 'Thỏ Trắng',
        modelSentence: 'Xin chào các bạn!',
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOptionId = optionId;
            capturedAnswer = answer;
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 103,
                type: 'RolePlay',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final doneBtnFinder = find.text('Em nói xong rồi');
      await tester.ensureVisible(doneBtnFinder);
      await tester.tap(doneBtnFinder);
      await _pumpAction(tester);

      expect(capturedOptionId, isNull);
      expect(capturedAnswer, isNull);
      expect(capturedOrderedOptionIds, isNull);
    });

    testWidgets('d) FillBlank: input "cây" into TextField and tap "Xong" calls onAttempt with answer == "cây"', (tester) async {
      await _usePhoneSize(tester);
      int? capturedOptionId = -1;
      String? capturedAnswer;
      List<int>? capturedOrderedOptionIds = [-1];

      final interaction = const ReadingInteraction(
        id: 104,
        type: 'FillBlank',
        prompt: 'Điền từ còn thiếu',
        maskedSentence: 'Con chim hót trên ___ cao.',
        hint: 'Loài thực vật thân gỗ',
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOptionId = optionId;
            capturedAnswer = answer;
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 104,
                type: 'FillBlank',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final textFieldFinder = find.byType(TextField);
      await tester.ensureVisible(textFieldFinder);
      await tester.enterText(textFieldFinder, 'cây');
      await tester.pump();

      final doneBtnFinder = find.text('Xong');
      await tester.ensureVisible(doneBtnFinder);
      await tester.tap(doneBtnFinder);
      await _pumpAction(tester);

      expect(capturedAnswer, 'cây');
      expect(capturedOptionId, isNull);
      expect(capturedOrderedOptionIds, isNull);
      // Không có audio câu thì không hiện nút "Nghe câu".
      expect(find.text('Nghe câu'), findsNothing);
    });

    testWidgets('d) FillBlank: "Nghe câu" plays audioUrls[text]', (tester) async {
      await _usePhoneSize(tester);
      final played = <String>[];
      const interaction = ReadingInteraction(
        id: 105,
        type: 'FillBlank',
        prompt: 'Điền từ còn thiếu',
        maskedSentence: 'Con chim hót trên ___ cao.',
        audioUrls: {'text': 'https://cdn.test/sentence.mp3', 'hint': 'https://cdn.test/hint.mp3'},
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) => Future.value(
            const ListeningAttemptResult(interactionId: 105, type: 'FillBlank', matched: true),
          ),
          onPlayAudio: played.add,
        ),
      );

      final listenFinder = find.text('Nghe câu');
      await tester.ensureVisible(listenFinder);
      await tester.tap(listenFinder);
      await tester.pump();

      expect(played, contains('https://cdn.test/sentence.mp3'));
    });

    testWidgets('e) EventOrdering: tap cards in order 3, 1, 2 and tap "Xong" calls onAttempt with orderedOptionIds == [3, 1, 2]', (tester) async {
      await _usePhoneSize(tester);
      List<int>? capturedOrderedOptionIds;

      final interaction = ReadingInteraction(
        id: 105,
        type: 'EventOrdering',
        prompt: 'Xếp theo thứ tự xảy ra',
        options: const [
          InteractionOption(id: 1, text: 'Sự kiện 1'),
          InteractionOption(id: 2, text: 'Sự kiện 2'),
          InteractionOption(id: 3, text: 'Sự kiện 3'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 105,
                type: 'EventOrdering',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final card3 = find.text('Sự kiện 3');
      await tester.ensureVisible(card3);
      await tester.tap(card3);
      await tester.pump();

      final card1 = find.text('Sự kiện 1');
      await tester.ensureVisible(card1);
      await tester.tap(card1);
      await tester.pump();

      final card2 = find.text('Sự kiện 2');
      await tester.ensureVisible(card2);
      await tester.tap(card2);
      await tester.pump();

      final doneBtnFinder = find.text('Xong');
      await tester.ensureVisible(doneBtnFinder);
      await tester.tap(doneBtnFinder);
      await _pumpAction(tester);

      expect(capturedOrderedOptionIds, [3, 1, 2]);
    });

    testWidgets('e) EventOrdering: deselecting an item shifts remaining item orders', (tester) async {
      await _usePhoneSize(tester);
      List<int>? capturedOrderedOptionIds;

      final interaction = ReadingInteraction(
        id: 105,
        type: 'EventOrdering',
        prompt: 'Xếp theo thứ tự xảy ra',
        options: const [
          InteractionOption(id: 1, text: 'Sự kiện 1'),
          InteractionOption(id: 2, text: 'Sự kiện 2'),
          InteractionOption(id: 3, text: 'Sự kiện 3'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            capturedOrderedOptionIds = orderedOptionIds;
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 105,
                type: 'EventOrdering',
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final card3 = find.text('Sự kiện 3');
      final card1 = find.text('Sự kiện 1');
      final card2 = find.text('Sự kiện 2');
      final doneBtnFinder = find.text('Xong');

      // Select 3, 1, 2
      await tester.ensureVisible(card3);
      await tester.tap(card3);
      await tester.pump();

      await tester.ensureVisible(card1);
      await tester.tap(card1);
      await tester.pump();

      await tester.ensureVisible(card2);
      await tester.tap(card2);
      await tester.pump();

      // Deselect 1 -> remaining list collapses: 3 is #1, 2 becomes #2
      await tester.ensureVisible(card1);
      await tester.tap(card1);
      await tester.pump();

      // Number badge '3' should be gone because only 2 items are selected
      expect(find.text('3'), findsNothing);

      // Reselect 1 -> 1 becomes #3
      await tester.ensureVisible(card1);
      await tester.tap(card1);
      await tester.pump();

      await tester.ensureVisible(doneBtnFinder);
      await tester.tap(doneBtnFinder);
      await _pumpAction(tester);

      expect(capturedOrderedOptionIds, [3, 2, 1]);
    });
  });

  group('Nhóm 2 — kết quả hiển thị', () {
    testWidgets('f) matched == true displays check_circle_rounded icon in feedback bar', (tester) async {
      await _usePhoneSize(tester);
      final interaction = ReadingInteraction(
        id: 201,
        type: 'Checkpoint',
        prompt: 'Câu hỏi?',
        options: const [
          InteractionOption(id: 1, text: 'Đáp án A'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 201,
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final optFinder = find.text('Đáp án A');
      await tester.ensureVisible(optFinder);
      await tester.tap(optFinder);
      await _pumpAction(tester);

      expect(find.byIcon(Icons.check_circle_rounded), findsWidgets);
    });

    testWidgets('f) matched == false displays cancel_rounded icon in feedback bar', (tester) async {
      await _usePhoneSize(tester);
      final interaction = ReadingInteraction(
        id: 202,
        type: 'Checkpoint',
        prompt: 'Câu hỏi?',
        options: const [
          InteractionOption(id: 1, text: 'Đáp án A'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 202,
                matched: false,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final optFinder = find.text('Đáp án A');
      await tester.ensureVisible(optFinder);
      await tester.tap(optFinder);
      await _pumpAction(tester);

      expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
    });

    testWidgets('f) matched == null displays star_rounded icon in feedback bar', (tester) async {
      await _usePhoneSize(tester);
      final interaction = const ReadingInteraction(
        id: 203,
        type: 'RolePlay',
        prompt: 'Đóng vai nhân vật',
        characterName: 'Gấu',
        modelSentence: 'Chào bạn!',
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 203,
                matched: null,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final doneBtnFinder = find.text('Em nói xong rồi');
      await tester.ensureVisible(doneBtnFinder);
      await tester.tap(doneBtnFinder);
      await _pumpAction(tester);

      expect(find.byIcon(Icons.star_rounded), findsWidgets);
    });

    testWidgets('g) After result, feedback bar has "Đọc tiếp" and tapping it pops with resume == true', (tester) async {
      await _usePhoneSize(tester);
      KidInteractionResult? popResult;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      popResult = await Navigator.of(context).push<KidInteractionResult>(
                        MaterialPageRoute(
                          builder: (_) => KidInteractionScreen(
                            interaction: const ReadingInteraction(
                              id: 204,
                              type: 'Checkpoint',
                              options: [
                                InteractionOption(id: 1, text: 'Chọn tôi'),
                              ],
                            ),
                            onAttempt: ({optionId, answer, orderedOptionIds}) {
                              return Future.value(
                                const ListeningAttemptResult(
                                  interactionId: 204,
                                  matched: true,
                                ),
                              );
                            },
                            onPlayAudio: (_) {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Mở tương tác'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final openBtn = find.text('Mở tương tác');
      await tester.ensureVisible(openBtn);
      await tester.tap(openBtn);
      await _pumpAction(tester);

      final optFinder = find.text('Chọn tôi');
      await tester.ensureVisible(optFinder);
      await tester.tap(optFinder);
      await _pumpAction(tester);
      await _settleFeedback(tester);

      final continueBtn = find.text('Đọc tiếp');
      await tester.ensureVisible(continueBtn);
      expect(continueBtn, findsOneWidget);
      await tester.tap(continueBtn);
      await _pumpAction(tester);

      expect(popResult, isNotNull);
      expect(popResult?.resume, isTrue);
    });

    testWidgets('h) Close button (Icons.close_rounded, tooltip "Để sau") pops with resume == true', (tester) async {
      await _usePhoneSize(tester);
      KidInteractionResult? popResult;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      popResult = await Navigator.of(context).push<KidInteractionResult>(
                        MaterialPageRoute(
                          builder: (_) => KidInteractionScreen(
                            interaction: const ReadingInteraction(
                              id: 205,
                              type: 'Checkpoint',
                              options: [
                                InteractionOption(id: 1, text: 'Lựa chọn'),
                              ],
                            ),
                            onAttempt: ({optionId, answer, orderedOptionIds}) {
                              return Future.value(
                                const ListeningAttemptResult(interactionId: 205),
                              );
                            },
                            onPlayAudio: (_) {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Mở tương tác'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final openBtn = find.text('Mở tương tác');
      await tester.ensureVisible(openBtn);
      await tester.tap(openBtn);
      await _pumpAction(tester);

      expect(find.byTooltip('Để sau'), findsOneWidget);
      final closeBtn = find.byIcon(Icons.close_rounded);
      await tester.ensureVisible(closeBtn);
      await tester.tap(closeBtn);
      await _pumpAction(tester);

      expect(popResult, isNotNull);
      expect(popResult?.resume, isTrue);
    });

    testWidgets('i2) Back gesture pops with resume == true', (tester) async {
      await _usePhoneSize(tester);
      KidInteractionResult? popResult;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      popResult = await Navigator.of(context).push<KidInteractionResult>(
                        MaterialPageRoute(
                          builder: (_) => KidInteractionScreen(
                            interaction: const ReadingInteraction(
                              id: 205,
                              type: 'Checkpoint',
                              options: [
                                InteractionOption(id: 1, text: 'Lựa chọn'),
                              ],
                            ),
                            onAttempt: ({optionId, answer, orderedOptionIds}) {
                              return Future.value(
                                const ListeningAttemptResult(interactionId: 205),
                              );
                            },
                            onPlayAudio: (_) {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Mở tương tác'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final openBtn = find.text('Mở tương tác');
      await tester.ensureVisible(openBtn);
      await tester.tap(openBtn);
      await _pumpAction(tester);

      await tester.binding.handlePopRoute();
      await _pumpAction(tester);

      expect(popResult, isNotNull);
      expect(popResult?.resume, isTrue);
    });

    testWidgets('i) EventOrdering matched: false, revealed: false, replaySceneIndexes: [1] shows "Nghe lại cảnh 2" and "Xếp lại", tapping replay pops with replaySceneIndex == 1', (tester) async {
      await _usePhoneSize(tester);
      KidInteractionResult? popResult;

      final interaction = ReadingInteraction(
        id: 206,
        type: 'EventOrdering',
        options: const [
          InteractionOption(id: 1, text: 'Cảnh A'),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      popResult = await Navigator.of(context).push<KidInteractionResult>(
                        MaterialPageRoute(
                          builder: (_) => KidInteractionScreen(
                            interaction: interaction,
                            onAttempt: ({optionId, answer, orderedOptionIds}) {
                              return Future.value(
                                const ListeningAttemptResult(
                                  interactionId: 206,
                                  type: 'EventOrdering',
                                  matched: false,
                                  revealed: false,
                                  replaySceneIndexes: [1],
                                ),
                              );
                            },
                            onPlayAudio: (_) {},
                          ),
                        ),
                      );
                    },
                    child: const Text('Mở tương tác'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final openBtn = find.text('Mở tương tác');
      await tester.ensureVisible(openBtn);
      await tester.tap(openBtn);
      await _pumpAction(tester);

      final cardA = find.text('Cảnh A');
      await tester.ensureVisible(cardA);
      await tester.tap(cardA);
      await tester.pump();

      final doneBtn = find.text('Xong');
      await tester.ensureVisible(doneBtn);
      await tester.tap(doneBtn);
      await _pumpAction(tester);
      await _settleFeedback(tester);

      final replayBtn = find.text('Nghe lại cảnh 2');
      final retryBtn = find.text('Xếp lại');
      await tester.ensureVisible(replayBtn);
      expect(replayBtn, findsOneWidget);
      await tester.ensureVisible(retryBtn);
      expect(retryBtn, findsOneWidget);

      await tester.tap(replayBtn);
      await _pumpAction(tester);

      expect(popResult, isNotNull);
      expect(popResult?.replaySceneIndex, 1);
    });

    testWidgets('j) EventOrdering matched: false, revealed: true, correctOrderOptionIds: [2, 1, 3] shows order "1. <text of option 2>"', (tester) async {
      await _usePhoneSize(tester);
      final interaction = ReadingInteraction(
        id: 207,
        type: 'EventOrdering',
        prompt: 'Xếp thứ tự',
        options: const [
          InteractionOption(id: 1, text: 'Sự việc đầu'),
          InteractionOption(id: 2, text: 'Sự việc giữa'),
          InteractionOption(id: 3, text: 'Sự việc cuối'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 207,
                type: 'EventOrdering',
                matched: false,
                revealed: true,
                correctOrderOptionIds: [2, 1, 3],
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      final card1 = find.text('Sự việc đầu');
      await tester.ensureVisible(card1);
      await tester.tap(card1);
      await tester.pump();

      final card2 = find.text('Sự việc giữa');
      await tester.ensureVisible(card2);
      await tester.tap(card2);
      await tester.pump();

      final card3 = find.text('Sự việc cuối');
      await tester.ensureVisible(card3);
      await tester.tap(card3);
      await tester.pump();

      final doneBtn = find.text('Xong');
      await tester.ensureVisible(doneBtn);
      await tester.tap(doneBtn);
      await _pumpAction(tester);

      expect(find.text('1. Sự việc giữa'), findsOneWidget);
      expect(find.text('2. Sự việc đầu'), findsOneWidget);
      expect(find.text('3. Sự việc cuối'), findsOneWidget);
    });

    testWidgets('k) onAttempt throws error -> does not crash, tester.takeException() is null, and option can be tapped again', (tester) async {
      await _usePhoneSize(tester);
      var callCount = 0;

      final interaction = ReadingInteraction(
        id: 208,
        type: 'Checkpoint',
        prompt: 'Thử lại khi có lỗi',
        options: const [
          InteractionOption(id: 1, text: 'Thử chạm'),
        ],
      );

      await _pumpScreen(
        tester,
        KidInteractionScreen(
          interaction: interaction,
          onAttempt: ({optionId, answer, orderedOptionIds}) {
            callCount++;
            if (callCount == 1) {
              return Future.error(Exception('Mạng bị ngắt'));
            }
            return Future.value(
              const ListeningAttemptResult(
                interactionId: 208,
                matched: true,
              ),
            );
          },
          onPlayAudio: (_) {},
        ),
      );

      // First attempt fails with error
      final optFinder = find.text('Thử chạm');
      await tester.ensureVisible(optFinder);
      await tester.tap(optFinder);
      await _pumpAction(tester);

      expect(tester.takeException(), isNull);
      expect(callCount, 1);

      // Button is still clickable again
      await tester.ensureVisible(optFinder);
      await tester.tap(optFinder);
      await _pumpAction(tester);

      expect(tester.takeException(), isNull);
      expect(callCount, 2);
    });
  });

  group('Nhóm 3 — không tràn màn hình', () {
    const surfaceSizes = <String, Size>{
      '320x640': Size(320, 640),
      '390x844': Size(390, 844),
      '1024x768': Size(1024, 768),
    };

    final interactions = <String, ReadingInteraction>{
      'Checkpoint_nhieu_option_text_dai': ReadingInteraction(
        id: 301,
        type: 'Checkpoint',
        prompt: 'Theo em, tại sao Chú Thỏ Trắng lại quyết định giúp đỡ bạn Rùa qua suối vào một ngày trời mưa bão lớn?',
        options: const [
          InteractionOption(
            id: 1,
            text: 'Vì Chú Thỏ Trắng rất tốt bụng và luôn sẵn lòng giúp đỡ tất cả muôn loài trong khu rừng sâu thẳm.',
          ),
          InteractionOption(
            id: 2,
            text: 'Vì Chú Thỏ muốn bạn Rùa chỉ cho mình con đường ngắn nhất và an toàn nhất để trở về hang.',
          ),
          InteractionOption(
            id: 3,
            text: 'Vì Thỏ muốn cùng bạn Rùa thi xem ai bơi qua suối nhanh hơn trong lúc nước chảy xiết.',
          ),
          InteractionOption(
            id: 4,
            text: 'Một câu trả lời rất dài khác nhằm kiểm tra bố cục hiển thị văn bản không bị lỗi giao diện.',
          ),
        ],
      ),
      'PicturePrediction_4_option': ReadingInteraction(
        id: 302,
        type: 'PicturePrediction',
        prompt: 'Em hãy quan sát và đoán xem sự việc tiếp theo là gì?',
        options: const [
          InteractionOption(id: 1, text: 'Tranh 1: Thỏ và Rùa gặp nhau'),
          InteractionOption(id: 2, text: 'Tranh 2: Cùng nhau bắc cầu gỗ'),
          InteractionOption(id: 3, text: 'Tranh 3: Qua suối an toàn'),
          InteractionOption(id: 4, text: 'Tranh 4: Vui vẻ chia sẻ cà rốt'),
        ],
      ),
      'EventOrdering_4_option': ReadingInteraction(
        id: 303,
        type: 'EventOrdering',
        prompt: 'Em hãy sắp xếp các sự việc sau theo đúng thứ tự xảy ra trong câu chuyện nhé:',
        options: const [
          InteractionOption(id: 1, text: 'Thỏ và Rùa thức dậy thật sớm bên bờ suối xanh mát'),
          InteractionOption(id: 2, text: 'Hai bạn cùng nhau tìm kiếm cành cây khô để dựng cầu'),
          InteractionOption(id: 3, text: 'Cẩn thận từng bước bước qua dòng nước đang chảy róc rách'),
          InteractionOption(id: 4, text: 'Đến được bờ bên kia an toàn và tiếp tục hành trình'),
        ],
      ),
      'FillBlank_co_hint': const ReadingInteraction(
        id: 304,
        type: 'FillBlank',
        prompt: 'Bé hãy điền từ ngữ còn thiếu vào chỗ trống để hoàn thành câu văn:',
        maskedSentence: 'Mùa thu về, những chiếc lá bàng chuyển sang màu đỏ rực rỡ và rơi rụng đầy trên khắp các con đường làng quê.',
        hint: 'Gợi ý: Từ này bắt đầu bằng chữ L, nói về một bộ phận của cây cối.',
      ),
    };

    for (final sizeEntry in surfaceSizes.entries) {
      for (final interEntry in interactions.entries) {
        testWidgets('Responsive ${sizeEntry.key} - ${interEntry.key}', (tester) async {
          await tester.binding.setSurfaceSize(sizeEntry.value);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() async {
            await tester.binding.setSurfaceSize(null);
            tester.view.resetDevicePixelRatio();
          });

          await _pumpScreen(
            tester,
            KidInteractionScreen(
              interaction: interEntry.value,
              onAttempt: ({optionId, answer, orderedOptionIds}) {
                return Future.value(
                  ListeningAttemptResult(interactionId: interEntry.value.id),
                );
              },
              onPlayAudio: (_) {},
            ),
          );

          expect(tester.takeException(), isNull);
        });
      }
    }
  });
}
