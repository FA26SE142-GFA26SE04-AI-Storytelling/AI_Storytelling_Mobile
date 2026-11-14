import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_controller.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

class ProgressCall {
  final String sessionId;
  final int page;
  final String readingMode;
  final int addedSeconds;

  ProgressCall({
    required this.sessionId,
    required this.page,
    required this.readingMode,
    required this.addedSeconds,
  });
}

class EventCall {
  final String sessionId;
  final String eventType;
  final String? payload;

  EventCall({required this.sessionId, required this.eventType, this.payload});
}

class BookmarkCall {
  final String sessionId;
  final bool value;

  BookmarkCall({required this.sessionId, required this.value});
}

class FakeKidReadingRepository implements KidReadingRepository {
  final List<String?> startCalls = [];
  final List<String> contentCalls = [];
  final List<ProgressCall> progressCalls = [];
  final List<String> completeCalls = [];
  final List<BookmarkCall> bookmarkCalls = [];
  final List<EventCall> eventCalls = [];
  final List<String> callOrder = [];

  ReadingStarted? startResult;
  ApiException? startError;

  ReadingContent? contentResult;
  ApiException? contentError;

  ReadingProgress? progressResult;
  ReadingCompleted? completeResult;
  ReadingFlags? bookmarkResult;

  @override
  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  }) async {
    callOrder.add('start');
    startCalls.add(storyId);
    if (startError != null) throw startError!;
    return startResult ??
        ReadingStarted(
          sessionId: 100,
          storyId: int.tryParse(storyId ?? '1') ?? 1,
          lastPage: 1,
        );
  }

  @override
  Future<ReadingContent> content(String sessionId) async {
    callOrder.add('content');
    contentCalls.add(sessionId);
    if (contentError != null) throw contentError!;
    return contentResult ??
        ReadingContent(
          sessionId: int.tryParse(sessionId) ?? 100,
          storyId: 1,
          title: 'Truyen test',
          scenes: const [],
        );
  }

  @override
  Future<ReadingProgress> progress(
    String sessionId, {
    required int page,
    required String readingMode,
    required int addedSeconds,
  }) async {
    callOrder.add('progress');
    final call = ProgressCall(
      sessionId: sessionId,
      page: page,
      readingMode: readingMode,
      addedSeconds: addedSeconds,
    );
    progressCalls.add(call);
    return progressResult ??
        ReadingProgress(
          sessionId: int.tryParse(sessionId) ?? 100,
          page: page,
          readingMode: readingMode,
          timeSpentSeconds: addedSeconds,
        );
  }

  @override
  Future<ReadingCompleted> complete(String sessionId) async {
    callOrder.add('complete');
    completeCalls.add(sessionId);
    return completeResult ??
        ReadingCompleted(sessionId: int.tryParse(sessionId) ?? 100, storyId: 1);
  }

  @override
  Future<ReadingFlags> bookmark(String sessionId, {required bool value}) async {
    callOrder.add('bookmark');
    bookmarkCalls.add(BookmarkCall(sessionId: sessionId, value: value));
    return bookmarkResult ?? ReadingFlags(isBookmarked: value);
  }

  @override
  Future<ReadingFlags> favorite(String sessionId, {required bool value}) async {
    callOrder.add('favorite');
    return ReadingFlags(isFavorited: value);
  }

  @override
  Future<ReadingSignal> signal(String sessionId) async {
    callOrder.add('signal');
    return const ReadingSignal(shouldExit: false, sessionStatus: 'Active');
  }

  @override
  Future<void> event(
    String sessionId, {
    required String eventType,
    String? payload,
  }) async {
    callOrder.add('event');
    eventCalls.add(
      EventCall(sessionId: sessionId, eventType: eventType, payload: payload),
    );
  }

  @override
  Future<VocabularyDefinition> definition(
    String sessionId, {
    required int vocabularyId,
  }) => throw UnimplementedError();

  @override
  Future<NotebookEntry> collectWord(
    String sessionId, {
    required int vocabularyId,
  }) => throw UnimplementedError();

  @override
  Future<List<ChildStory>> stories({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) => throw UnimplementedError();

  @override
  Future<ChildStoryPage> storyPage({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) => throw UnimplementedError();
}

List<ReadingScene> makeScenes(int count) {
  return List.generate(
    count,
    (index) => ReadingScene(
      sceneId: index + 1,
      sceneIndex: index,
      text: 'Noi dung canh ${index + 1}',
    ),
  );
}

ReadingContent makeContent({
  required int sessionId,
  required int storyId,
  int sceneCount = 5,
}) {
  return ReadingContent(
    sessionId: sessionId,
    storyId: storyId,
    title: 'Cau chuyen thu nghiem',
    scenes: makeScenes(sceneCount),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('KidReaderController', () {
    test('load(): start tra lastPage 3 (1-based), 5 scenes -> currentPage == 2, status ready, readingMode theo lastReadingMode ListenFirst', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.startResult = const ReadingStarted(
        sessionId: 101,
        storyId: 1,
        lastPage: 3,
        lastReadingMode: 'ListenFirst',
        isBookmarked: false,
        isFavorited: false,
      );
      fakeRepo.contentResult = makeContent(
        sessionId: 101,
        storyId: 1,
        sceneCount: 5,
      );

      final container = ProviderContainer(
        overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        kidReaderControllerProvider('1').notifier,
      );
      await notifier.load();

      final state = container.read(kidReaderControllerProvider('1'));
      expect(state.status, KidReaderStatus.ready);
      expect(state.currentPage, 2);
      expect(state.readingMode, KidReadingMode.listenFirst);
      expect(state.totalPages, 5);
      expect(state.sessionId, 101);
    });

    test(
      'lastPage ngoai pham vi (0, hoac > so scenes) -> currentPage 0',
      () async {
        // Truong hop 1: lastPage == 0
        final fakeRepo1 = FakeKidReadingRepository();
        fakeRepo1.startResult = const ReadingStarted(
          sessionId: 101,
          storyId: 1,
          lastPage: 0,
        );
        fakeRepo1.contentResult = makeContent(
          sessionId: 101,
          storyId: 1,
          sceneCount: 5,
        );

        final container1 = ProviderContainer(
          overrides: [
            kidReadingRepositoryProvider.overrideWithValue(fakeRepo1),
          ],
        );
        addTearDown(container1.dispose);

        final notifier1 = container1.read(
          kidReaderControllerProvider('1').notifier,
        );
        await notifier1.load();

        expect(
          container1.read(kidReaderControllerProvider('1')).currentPage,
          0,
        );

        // Truong hop 2: lastPage == 10 (> 5 scenes)
        final fakeRepo2 = FakeKidReadingRepository();
        fakeRepo2.startResult = const ReadingStarted(
          sessionId: 102,
          storyId: 1,
          lastPage: 10,
        );
        fakeRepo2.contentResult = makeContent(
          sessionId: 102,
          storyId: 1,
          sceneCount: 5,
        );

        final container2 = ProviderContainer(
          overrides: [
            kidReadingRepositoryProvider.overrideWithValue(fakeRepo2),
          ],
        );
        addTearDown(container2.dispose);

        final notifier2 = container2.read(
          kidReaderControllerProvider('1').notifier,
        );
        await notifier2.load();

        expect(
          container2.read(kidReaderControllerProvider('1')).currentPage,
          0,
        );
      },
    );

    test('storyId tra ve khac storyId yeu cau -> status error', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.startResult = const ReadingStarted(
        sessionId: 101,
        storyId: 999,
        lastPage: 1,
      );

      final container = ProviderContainer(
        overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        kidReaderControllerProvider('1').notifier,
      );
      await notifier.load();

      final state = container.read(kidReaderControllerProvider('1'));
      expect(state.status, KidReaderStatus.error);
    });

    test('start nem ApiException (status 404) -> status error va exitReason khac null', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.startError = ApiException(
        statusCode: 404,
        message: 'Khong tim thay truyen',
      );

      final container = ProviderContainer(
        overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        kidReaderControllerProvider('1').notifier,
      );
      await notifier.load();

      final state = container.read(kidReaderControllerProvider('1'));
      expect(state.status, KidReaderStatus.error);
      expect(state.exitReason, isNotNull);
      expect(state.exitReason, 'Khong tim thay truyen');
    });

    test(
      'nextPage/prevPage khong vuot bien (khong am, khong qua so trang cuoi)',
      () async {
        final fakeRepo = FakeKidReadingRepository();
        fakeRepo.startResult = const ReadingStarted(
          sessionId: 101,
          storyId: 1,
          lastPage: 1,
        );
        fakeRepo.contentResult = makeContent(
          sessionId: 101,
          storyId: 1,
          sceneCount: 5,
        );

        final container = ProviderContainer(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
        );
        addTearDown(container.dispose);

        final notifier = container.read(
          kidReaderControllerProvider('1').notifier,
        );
        await notifier.load();

        // Dang o trang 0, goi prevPage khong duoc am
        notifier.prevPage();
        expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

        // Chuyen toi trang cuoi (index 4)
        notifier.goToPage(4);
        expect(container.read(kidReaderControllerProvider('1')).currentPage, 4);

        // Goi nextPage khong duoc vuot qua trang 4
        notifier.nextPage();
        expect(container.read(kidReaderControllerProvider('1')).currentPage, 4);
      },
    );

    test("markPageCompleted / markTtsStarted / markTtsCompleted gui eventType dung 'PageCompleted' / 'TtsStarted' / 'TtsCompleted'", () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.startResult = const ReadingStarted(
        sessionId: 101,
        storyId: 1,
        lastPage: 1,
      );
      fakeRepo.contentResult = makeContent(
        sessionId: 101,
        storyId: 1,
        sceneCount: 3,
      );

      final container = ProviderContainer(
        overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        kidReaderControllerProvider('1').notifier,
      );
      await notifier.load();

      await notifier.markPageCompleted();
      await notifier.markTtsStarted();
      await notifier.markTtsCompleted();

      expect(fakeRepo.eventCalls.length, 3);
      expect(fakeRepo.eventCalls[0].eventType, 'PageCompleted');
      expect(fakeRepo.eventCalls[1].eventType, 'TtsStarted');
      expect(fakeRepo.eventCalls[2].eventType, 'TtsCompleted');
    });

    test('complete(): goi progress truoc roi complete; isFinished true; goi complete lan 2 tra null va KHONG goi repo them', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.startResult = const ReadingStarted(
        sessionId: 101,
        storyId: 1,
        lastPage: 1,
      );
      fakeRepo.contentResult = makeContent(
        sessionId: 101,
        storyId: 1,
        sceneCount: 3,
      );
      fakeRepo.completeResult = const ReadingCompleted(
        sessionId: 101,
        storyId: 1,
        expGained: 10,
      );

      final container = ProviderContainer(
        overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(
        kidReaderControllerProvider('1').notifier,
      );
      await notifier.load();

      fakeRepo.callOrder.clear();
      fakeRepo.progressCalls.clear();
      fakeRepo.completeCalls.clear();

      final result1 = await notifier.complete();
      expect(result1, isNotNull);
      expect(result1?.sessionId, 101);

      final stateAfterComplete = container.read(
        kidReaderControllerProvider('1'),
      );
      expect(stateAfterComplete.isFinished, isTrue);

      final progressIndex = fakeRepo.callOrder.indexOf('progress');
      final completeIndex = fakeRepo.callOrder.indexOf('complete');
      expect(progressIndex, isNot(-1));
      expect(completeIndex, isNot(-1));
      expect(progressIndex < completeIndex, isTrue);

      // Goi complete lan 2
      final result2 = await notifier.complete();
      expect(result2, isNull);
      expect(fakeRepo.completeCalls.length, 1);
      expect(fakeRepo.progressCalls.length, 1);
    });

    test(
      'toggleBookmark cap nhat isBookmarked theo flags tra ve tu repo',
      () async {
        final fakeRepo = FakeKidReadingRepository();
        fakeRepo.startResult = const ReadingStarted(
          sessionId: 101,
          storyId: 1,
          lastPage: 1,
          isBookmarked: false,
        );
        fakeRepo.contentResult = makeContent(
          sessionId: 101,
          storyId: 1,
          sceneCount: 3,
        );

        final container = ProviderContainer(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(fakeRepo)],
        );
        addTearDown(container.dispose);

        final notifier = container.read(
          kidReaderControllerProvider('1').notifier,
        );
        await notifier.load();

        expect(
          container.read(kidReaderControllerProvider('1')).isBookmarked,
          isFalse,
        );

        fakeRepo.bookmarkResult = const ReadingFlags(isBookmarked: true);
        await notifier.toggleBookmark();

        expect(
          container.read(kidReaderControllerProvider('1')).isBookmarked,
          isTrue,
        );
        expect(fakeRepo.bookmarkCalls.last.value, isTrue);

        fakeRepo.bookmarkResult = const ReadingFlags(isBookmarked: false);
        await notifier.toggleBookmark();

        expect(
          container.read(kidReaderControllerProvider('1')).isBookmarked,
          isFalse,
        );
        expect(fakeRepo.bookmarkCalls.last.value, isFalse);
      },
    );
  });
}
