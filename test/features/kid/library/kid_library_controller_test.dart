import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/library/kid_library_screen.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

class StoryPageCall {
  final String? search;
  final int pageIndex;
  final int pageSize;

  StoryPageCall({
    this.search,
    required this.pageIndex,
    required this.pageSize,
  });
}

class FakeKidReadingRepository implements KidReadingRepository {
  final List<StoryPageCall> storyPageCalls = [];
  ChildStoryPage Function(StoryPageCall call)? onStoryPage;
  ApiException? storyPageError;

  @override
  Future<ChildStoryPage> storyPage({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    final call = StoryPageCall(
      search: search,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );
    storyPageCalls.add(call);

    if (storyPageError != null) {
      throw storyPageError!;
    }
    if (onStoryPage != null) {
      return onStoryPage!(call);
    }
    return const ChildStoryPage();
  }

  @override
  Future<List<ChildStory>> stories({
    String? search,
    int pageIndex = 1,
    int pageSize = 20,
  }) =>
      throw UnimplementedError();

  @override
  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  }) =>
      throw UnimplementedError();

  @override
  Future<ReadingContent> content(String sessionId) =>
      throw UnimplementedError();

  @override
  Future<ReadingProgress> progress(
    String sessionId, {
    required int page,
    required String readingMode,
    required int addedSeconds,
  }) =>
      throw UnimplementedError();

  @override
  Future<ReadingCompleted> complete(String sessionId) =>
      throw UnimplementedError();

  @override
  Future<ReadingFlags> bookmark(
    String sessionId, {
    required bool value,
  }) =>
      throw UnimplementedError();

  @override
  Future<ReadingFlags> favorite(
    String sessionId, {
    required bool value,
  }) =>
      throw UnimplementedError();

  @override
  Future<ReadingSignal> signal(String sessionId) =>
      throw UnimplementedError();

  @override
  Future<void> event(
    String sessionId, {
    required String eventType,
    String? payload,
  }) =>
      throw UnimplementedError();

  @override
  Future<VocabularyDefinition> definition(
    String sessionId, {
    required int vocabularyId,
  }) =>
      throw UnimplementedError();

  @override
  Future<NotebookEntry> collectWord(
    String sessionId, {
    required int vocabularyId,
  }) =>
      throw UnimplementedError();
}

List<ChildStory> makeStories(int count, {int startId = 1}) {
  return List.generate(
    count,
    (index) => ChildStory(
      storyId: startId + index,
      title: 'Truyen ${startId + index}',
      source: 'editorial',
    ),
  );
}

Future<ProviderSubscription<KidLibraryState>> settle(
    ProviderContainer container) async {
  final subscription =
      container.listen(kidLibraryControllerProvider, (_, _) {});
  for (var i = 0; i < 15; i++) {
    await Future<void>.delayed(Duration.zero);
    if (i >= 2 &&
        !container.read(kidLibraryControllerProvider).isLoadingInitial) {
      break;
    }
  }
  return subscription;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('KidLibraryController', () {
    test('loadInitial goi storyPage voi pageIndex == 1 va state.pageIndex == 1', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.onStoryPage = (call) => ChildStoryPage(
            items: makeStories(10),
            pageIndex: call.pageIndex,
            pageSize: call.pageSize,
            totalCount: 10,
          );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);
      final subscription =
          container.listen(kidLibraryControllerProvider, (_, _) {});
      addTearDown(subscription.close);

      await settle(container);
      fakeRepo.storyPageCalls.clear();

      await container
          .read(kidLibraryControllerProvider.notifier)
          .loadInitial();

      expect(fakeRepo.storyPageCalls.isNotEmpty, isTrue);
      final lastCall = fakeRepo.storyPageCalls.last;
      expect(lastCall.pageIndex, 1);

      final state = container.read(kidLibraryControllerProvider);
      expect(state.pageIndex, 1);
      expect(state.isLoadingInitial, isFalse);
      expect(state.stories.length, 10);
    });

    test('Tra du 20 truyen -> hasMore true; loadMore goi pageIndex == 2, noi 40 phan tu khong trung', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.onStoryPage = (call) {
        if (call.pageIndex == 1) {
          return ChildStoryPage(
            items: makeStories(20, startId: 1),
            pageIndex: 1,
            pageSize: 20,
            totalCount: 40,
          );
        } else if (call.pageIndex == 2) {
          return ChildStoryPage(
            items: makeStories(20, startId: 21),
            pageIndex: 2,
            pageSize: 20,
            totalCount: 40,
          );
        }
        return const ChildStoryPage();
      };

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);
      final subscription =
          container.listen(kidLibraryControllerProvider, (_, _) {});
      addTearDown(subscription.close);

      await settle(container);
      fakeRepo.storyPageCalls.clear();

      await container
          .read(kidLibraryControllerProvider.notifier)
          .loadInitial();

      expect(container.read(kidLibraryControllerProvider).hasMore, isTrue);
      expect(container.read(kidLibraryControllerProvider).stories.length, 20);

      await container.read(kidLibraryControllerProvider.notifier).loadMore();

      final state = container.read(kidLibraryControllerProvider);
      expect(fakeRepo.storyPageCalls.last.pageIndex, 2);
      expect(state.pageIndex, 2);
      expect(state.stories.length, 40);

      final uniqueIds = state.stories.map((s) => s.storyId).toSet();
      final uniqueTitles = state.stories.map((s) => s.title).toSet();
      expect(uniqueIds.length, 40);
      expect(uniqueTitles.length, 40);
    });

    test('Tra < 20 -> hasMore false; loadMore khong goi repo them', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.onStoryPage = (call) => ChildStoryPage(
            items: makeStories(10),
            pageIndex: 1,
            pageSize: 20,
            totalCount: 10,
          );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);
      final subscription =
          container.listen(kidLibraryControllerProvider, (_, _) {});
      addTearDown(subscription.close);

      await settle(container);
      fakeRepo.storyPageCalls.clear();

      await container
          .read(kidLibraryControllerProvider.notifier)
          .loadInitial();

      final stateAfterInitial = container.read(kidLibraryControllerProvider);
      expect(stateAfterInitial.hasMore, isFalse);

      final callsCountBeforeLoadMore = fakeRepo.storyPageCalls.length;
      await container.read(kidLibraryControllerProvider.notifier).loadMore();

      expect(fakeRepo.storyPageCalls.length, callsCountBeforeLoadMore);
    });

    test('Repo nem ApiException -> errorMessage bang message cua loi, isLoadingInitial false', () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.storyPageError = ApiException(
        statusCode: 500,
        message: 'Khong the ket noi toi may chu',
      );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);
      final subscription =
          container.listen(kidLibraryControllerProvider, (_, _) {});
      addTearDown(subscription.close);

      await settle(container);
      fakeRepo.storyPageCalls.clear();

      await container
          .read(kidLibraryControllerProvider.notifier)
          .loadInitial();

      final state = container.read(kidLibraryControllerProvider);
      expect(state.isLoadingInitial, isFalse);
      expect(state.errorMessage, 'Khong the ket noi toi may chu');
    });

    test("loadInitial(search: 'x') -> reset ve pageIndex 1, truyen search 'x' cho repo", () async {
      final fakeRepo = FakeKidReadingRepository();
      fakeRepo.onStoryPage = (call) => ChildStoryPage(
            items: makeStories(5),
            pageIndex: call.pageIndex,
            pageSize: 20,
            totalCount: 5,
          );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);
      final subscription =
          container.listen(kidLibraryControllerProvider, (_, _) {});
      addTearDown(subscription.close);

      await settle(container);
      fakeRepo.storyPageCalls.clear();

      await container
          .read(kidLibraryControllerProvider.notifier)
          .loadInitial(search: 'doraemon');
      await settle(container);

      final lastCall = fakeRepo.storyPageCalls.last;
      expect(lastCall.search, 'doraemon');
      expect(lastCall.pageIndex, 1);

      final state = container.read(kidLibraryControllerProvider);
      expect(state.pageIndex, 1);
      expect(state.searchQuery, 'doraemon');
    });
  });
}
