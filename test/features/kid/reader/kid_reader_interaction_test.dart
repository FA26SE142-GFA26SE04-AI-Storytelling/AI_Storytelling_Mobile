import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_controller.dart';
import 'package:ai_storytelling_mobile/models/child_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

class AttemptInteractionCall {
  final String sessionId;
  final int interactionId;
  final int? optionId;
  final String? answer;
  final List<int>? orderedOptionIds;

  AttemptInteractionCall({
    required this.sessionId,
    required this.interactionId,
    this.optionId,
    this.answer,
    this.orderedOptionIds,
  });
}

class FakeKidReadingRepository implements KidReadingRepository {
  final List<AttemptInteractionCall> attemptCalls = [];
  ListeningAttemptResult? attemptResult;

  @override
  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  }) async {
    return const ReadingStarted(
      sessionId: 100,
      storyId: 1,
      lastPage: 1,
    );
  }

  @override
  Future<ReadingContent> content(String sessionId) async {
    return const ReadingContent(
      sessionId: 100,
      storyId: 1,
      title: 'Truyen test',
      scenes: [],
    );
  }

  @override
  Future<ListeningAttemptResult> attemptInteraction(
    String sessionId,
    int interactionId, {
    int? optionId,
    String? answer,
    List<int>? orderedOptionIds,
  }) async {
    attemptCalls.add(
      AttemptInteractionCall(
        sessionId: sessionId,
        interactionId: interactionId,
        optionId: optionId,
        answer: answer,
        orderedOptionIds: orderedOptionIds,
      ),
    );
    return attemptResult ??
        ListeningAttemptResult(
          interactionId: interactionId,
          type: 'Checkpoint',
          matched: true,
        );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('KidReaderController Interaction Tests', () {
    test(
      'isInteractionPending: canh co interaction id 7 va attemptedInSession false tra true, khong co interaction tra false, attemptedInSession true tra false',
      () {
        final fakeRepo = FakeKidReadingRepository();
        final container = ProviderContainer(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          kidReaderControllerProvider('1').notifier,
        );

        const pendingScene = ReadingScene(
          sceneId: 1,
          sceneIndex: 0,
          text: 'Scene 1',
          interaction: ReadingInteraction(id: 7),
          attemptedInSession: false,
        );
        expect(controller.isInteractionPending(pendingScene), isTrue);

        const noInteractionScene = ReadingScene(
          sceneId: 2,
          sceneIndex: 1,
          text: 'Scene 2',
          interaction: null,
          attemptedInSession: false,
        );
        expect(controller.isInteractionPending(noInteractionScene), isFalse);

        const attemptedScene = ReadingScene(
          sceneId: 3,
          sceneIndex: 2,
          text: 'Scene 3',
          interaction: ReadingInteraction(id: 7),
          attemptedInSession: true,
        );
        expect(controller.isInteractionPending(attemptedScene), isFalse);
      },
    );

    test(
      'attemptInteraction: fake ghi nhan optionId 3, answer va orderedOptionIds null; state.answeredInteractionIds chua 7 va isInteractionPending false',
      () async {
        final fakeRepo = FakeKidReadingRepository();
        const expectedResult = ListeningAttemptResult(
          interactionId: 7,
          type: 'Checkpoint',
          matched: true,
        );
        fakeRepo.attemptResult = expectedResult;

        final container = ProviderContainer(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          kidReaderControllerProvider('1').notifier,
        );
        await controller.load();

        const scene = ReadingScene(
          sceneId: 1,
          sceneIndex: 0,
          text: 'Scene 1',
          interaction: ReadingInteraction(id: 7),
          attemptedInSession: false,
        );
        expect(controller.isInteractionPending(scene), isTrue);

        final result = await controller.attemptInteraction(
          interactionId: 7,
          optionId: 3,
        );

        expect(result, equals(expectedResult));
        expect(fakeRepo.attemptCalls.length, 1);
        final call = fakeRepo.attemptCalls.first;
        expect(call.optionId, 3);
        expect(call.answer, isNull);
        expect(call.orderedOptionIds, isNull);

        final state = container.read(kidReaderControllerProvider('1'));
        expect(state.answeredInteractionIds.contains(7), isTrue);
        expect(controller.isInteractionPending(scene), isFalse);
      },
    );
  });
}
