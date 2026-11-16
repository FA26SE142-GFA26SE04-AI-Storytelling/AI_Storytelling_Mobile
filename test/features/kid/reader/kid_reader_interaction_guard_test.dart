import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/interaction/kid_interaction_screen.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_screen.dart';
import 'package:ai_storytelling_mobile/models/child_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';

class _FakeRepo extends Fake implements KidReadingRepository {
  _FakeRepo({
    required this.storyId,
    required this.scene0Text,
    required this.scene1Text,
  });

  final int storyId;
  final String scene0Text;
  final String scene1Text;

  @override
  Future<ReadingStarted> start({
    String? storyId,
    String? communitySubmissionId,
  }) async {
    return ReadingStarted(
      sessionId: 100,
      storyId: this.storyId,
      lastPage: 1, // 1-based index tương ứng currentPage = 0
      lastReadingMode: 'ReadFirst', // Chế độ thủ công (manual)
    );
  }

  @override
  Future<ReadingContent> content(String sessionId) async {
    return ReadingContent(
      sessionId: 100,
      storyId: storyId,
      title: 'Truyện kiểm thử tương tác',
      scenes: [
        ReadingScene(
          sceneId: 1,
          sceneIndex: 0,
          text: scene0Text,
          interaction: const ReadingInteraction(
            id: 5,
            type: 'FillBlank',
            maskedSentence: 'Mẹ ___ cơm',
            hint: 'nấu',
            prompt: 'Điền từ thích hợp vào chỗ trống',
          ),
          segments: const [], // Không có audio để không kích hoạt just_audio
        ),
        ReadingScene(
          sceneId: 2,
          sceneIndex: 1,
          text: scene1Text,
          interaction: null,
          segments: const [],
        ),
      ],
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
    return const ListeningAttemptResult(
      interactionId: 5,
      type: 'FillBlank',
      matched: true,
      feedback: 'Đúng rồi!',
    );
  }

  @override
  Future<ReadingProgress> progress(
    String sessionId, {
    required int page,
    required String readingMode,
    required int addedSeconds,
  }) async {
    return ReadingProgress(
      sessionId: 100,
      page: page,
      readingMode: readingMode,
      timeSpentSeconds: addedSeconds,
    );
  }

  @override
  Future<void> event(
    String sessionId, {
    required String eventType,
    String? payload,
  }) async {}

  @override
  Future<ReadingSignal> signal(String sessionId) async {
    return const ReadingSignal(shouldExit: false, sessionStatus: 'Active');
  }

  @override
  Future<ReadingFlags> bookmark(String sessionId, {required bool value}) async {
    return ReadingFlags(isBookmarked: value);
  }

  @override
  Future<ReadingFlags> favorite(String sessionId, {required bool value}) async {
    return ReadingFlags(isFavorited: value);
  }

  @override
  Future<ReadingCompleted> complete(String sessionId) async {
    return const ReadingCompleted(sessionId: 100, storyId: 1);
  }
}

Future<void> _pumpFrames(WidgetTester tester, {int count = 5}) async {
  for (var i = 0; i < count; i++) {
    await tester.pump(const Duration(milliseconds: 500));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.ryanheise.just_audio.methods'),
      (MethodCall methodCall) async => null,
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.ryanheise.just_audio.methods'),
      null,
    );
  });

  group('KidReader Interaction Guard', () {
    testWidgets('chặn lật bằng nút ▶ khi chưa trả lời', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeRepo = _FakeRepo(
        storyId: 1,
        scene0Text: 'Cảnh 0: Bé đi học',
        scene1Text: 'Cảnh 1: Bé về nhà',
      );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const KidReaderScreen(storyId: '1'),
          ),
        ),
      );

      await _pumpFrames(tester);

      // Trang 0 đang hiển thị
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

      // Bấm nút chuyển sang trang sau (icon Icons.arrow_forward_ios_rounded trong bottom bar)
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
      await _pumpFrames(tester);

      // Expect: Có KidInteractionScreen trên màn hình
      expect(find.byType(KidInteractionScreen), findsOneWidget);

      // Expect: Trang hiện tại vẫn là cảnh 0 (không phải cảnh 1)
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(minutes: 1));
      container.dispose();
    });

    testWidgets('chặn vuốt', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeRepo = _FakeRepo(
        storyId: 1,
        scene0Text: 'Cảnh 0: Bé đi học',
        scene1Text: 'Cảnh 1: Bé về nhà',
      );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const KidReaderScreen(storyId: '1'),
          ),
        ),
      );

      await _pumpFrames(tester);

      // Trang 0 đang hiển thị
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

      // Vuốt sang trái trên PageView
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await _pumpFrames(tester);

      // Expect: Vẫn mở KidInteractionScreen và vẫn ở cảnh 0
      expect(find.byType(KidInteractionScreen), findsOneWidget);
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(minutes: 1));
      container.dispose();
    });

    testWidgets('trả lời rồi bấm Đọc tiếp thì lật', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeRepo = _FakeRepo(
        storyId: 1,
        scene0Text: 'Cảnh 0: Bé đi học',
        scene1Text: 'Cảnh 1: Bé về nhà',
      );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const KidReaderScreen(storyId: '1'),
          ),
        ),
      );

      await _pumpFrames(tester);

      // Mở tương tác
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
      await _pumpFrames(tester);
      expect(find.byType(KidInteractionScreen), findsOneWidget);

      // Nhập đáp án 'cơm' vào TextField của FillBlank
      await tester.enterText(find.byType(TextField), 'cơm');
      await tester.pump(const Duration(milliseconds: 100));

      // Bấm nút 'Xong'
      await tester.tap(find.text('Xong'));
      await _pumpFrames(tester);

      // Bấm 'Đọc tiếp' trong feedback bar
      expect(find.text('Đọc tiếp'), findsOneWidget);
      await tester.tap(find.text('Đọc tiếp'));
      await tester.pump(const Duration(milliseconds: 500));
      await _pumpFrames(tester);
      await tester.pump(const Duration(milliseconds: 500));

      // Expect: Màn tương tác đóng, trang hiện tại chuyển sang cảnh 1
      expect(find.byType(KidInteractionScreen), findsNothing);
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 1);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(minutes: 1));
      container.dispose();
    });

    testWidgets('Để sau (✕) sau khi bấm ▶ thì lật sang cảnh 1', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final fakeRepo = _FakeRepo(
        storyId: 1,
        scene0Text: 'Cảnh 0: Bé đi học',
        scene1Text: 'Cảnh 1: Bé về nhà',
      );

      final container = ProviderContainer(
        overrides: [
          kidReadingRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const KidReaderScreen(storyId: '1'),
          ),
        ),
      );

      await _pumpFrames(tester);

      // Trang 0 đang hiển thị
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 0);

      // Bấm ▶
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
      await _pumpFrames(tester);

      // Expect: Có KidInteractionScreen trên màn hình
      expect(find.byType(KidInteractionScreen), findsOneWidget);

      // Bấm Icons.close_rounded (tooltip 'Để sau')
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump(const Duration(milliseconds: 500));
      await _pumpFrames(tester);
      await tester.pump(const Duration(milliseconds: 500));

      // Expect: Màn tương tác đóng và chữ cảnh 1 hiện
      expect(find.byType(KidInteractionScreen), findsNothing);
      expect(container.read(kidReaderControllerProvider('1')).currentPage, 1);

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(minutes: 1));
      container.dispose();
    });
  });
}
