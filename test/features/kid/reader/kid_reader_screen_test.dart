import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/data/reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_screen.dart';
import 'package:ai_storytelling_mobile/models/reading_content_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_start_dto.dart';

class FakeReadingRepository implements ReadingRepository {
  const FakeReadingRepository({this.lastPage = 1});

  final int lastPage;

  @override
  Future<ReadingStartedDto> start({
    required String token,
    required int storyId,
  }) async {
    return ReadingStartedDto(
      sessionId: 5,
      storyId: 10,
      resumed: false,
      lastPage: lastPage,
    );
  }

  @override
  Future<ReadingContentDto> content({
    required String token,
    required int sessionId,
  }) async {
    return const ReadingContentDto(
      sessionId: 5,
      storyId: 10,
      title: 'Chú ếch và hoa sen',
      scenes: [
        ReadingSceneDto(
          sceneId: 1,
          sceneIndex: 0,
          text: 'Ếch nhảy lên lá sen.',
          illustrationUrl: null,
          segments: [],
        ),
        ReadingSceneDto(
          sceneId: 2,
          sceneIndex: 1,
          text: 'Cá bơi dưới ao.',
          segments: [],
        ),
        ReadingSceneDto(
          sceneId: 3,
          sceneIndex: 2,
          text: 'Trời đẹp quá.',
          segments: [],
        ),
      ],
      vocabulary: [],
    );
  }

  @override
  Future<ReadingProgressDto> saveProgress({
    required String token,
    required int sessionId,
    required int page,
    required String readingMode,
    required int addedSeconds,
  }) async {
    return ReadingProgressDto(
      sessionId: sessionId,
      page: page,
      readingMode: readingMode,
      timeSpentSeconds: addedSeconds,
    );
  }

  @override
  Future<ReadingCompletedDto> complete({
    required String token,
    required int sessionId,
  }) async {
    return const ReadingCompletedDto(
      sessionId: 5,
      storyId: 10,
    );
  }

  @override
  Future<ReadingFlagsDto> setBookmark({
    required String token,
    required int sessionId,
    required bool value,
  }) async {
    return ReadingFlagsDto(isBookmarked: value);
  }

  @override
  Future<ReadingFlagsDto> setFavorite({
    required String token,
    required int sessionId,
    required bool value,
  }) async {
    return ReadingFlagsDto(isFavorited: value);
  }

  @override
  Future<void> sendEvent({
    required String token,
    required int sessionId,
    required String eventType,
    String? payload,
  }) async {}

  @override
  Future<ReadingSignalDto> signal({
    required String token,
    required int sessionId,
  }) async {
    return const ReadingSignalDto(shouldExit: false);
  }

  @override
  Future<VocabularyDefinitionDto> definition({
    required String token,
    required int sessionId,
    required int vocabularyId,
  }) async {
    return const VocabularyDefinitionDto(
      vocabularyId: 1,
      term: 'từ vựng',
    );
  }
}

class FakeKidSessionController extends KidSessionController {
  @override
  KidSessionState build() {
    return const KidActive(
      StoredKidSession(
        childProfileId: 1,
        accessToken: 'test-token',
        expiresAtMs: 4102444800000,
        via: KidSessionVia.easyLogin,
        parentalGateEnabled: true,
      ),
    );
  }
}

Future<void> pumpReader(
  WidgetTester tester, {
  int storyId = 10,
  int lastPage = 1,
  Size physicalSize = const Size(390, 844),
}) async {
  tester.view.physicalSize = physicalSize;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        readingRepositoryProvider.overrideWithValue(
          FakeReadingRepository(lastPage: lastPage),
        ),
        kidSessionProvider.overrideWith(FakeKidSessionController.new),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        home: KidReaderScreen(storyId: storyId),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  group('Màn đọc của bé', () {
    testWidgets('Mở truyện: thấy chữ "Ếch nhảy lên lá sen." và chỉ số "1 / 3"',
        (tester) async {
      await pumpReader(tester);

      expect(find.text('Ếch nhảy lên lá sen.'), findsOneWidget);
      expect(find.text('1 / 3'), findsOneWidget);
    });

    testWidgets('Trang đầu: nút "Trang trước" bị vô hiệu', (tester) async {
      await pumpReader(tester);

      final prevInkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byTooltip('Trang trước'),
          matching: find.byType(InkWell),
        ),
      );
      expect(prevInkWell.onTap, isNull);

      await tester.tap(find.byTooltip('Trang trước'));
      await tester.pump();
      expect(find.text('1 / 3'), findsOneWidget);
    });

    testWidgets(
        'Bấm "Trang sau" -> thấy "Cá bơi dưới ao." và "2 / 3"', (tester) async {
      await pumpReader(tester);

      await tester.tap(find.byTooltip('Trang sau'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Cá bơi dưới ao.'), findsOneWidget);
      expect(find.text('2 / 3'), findsOneWidget);
    });

    testWidgets(
        'Đi tới trang cuối -> thấy nút "Em đọc xong rồi!" và "Trang sau" bị vô hiệu',
        (tester) async {
      await pumpReader(tester);

      // Chuyển sang trang 2
      await tester.tap(find.byTooltip('Trang sau'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Chuyển sang trang 3 (trang cuối)
      await tester.tap(find.byTooltip('Trang sau'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('3 / 3'), findsOneWidget);
      expect(find.text('Trời đẹp quá.'), findsOneWidget);
      expect(find.text('Em đọc xong rồi!'), findsOneWidget);

      final nextInkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byTooltip('Trang sau'),
          matching: find.byType(InkWell),
        ),
      );
      expect(nextInkWell.onTap, isNull);
    });

    testWidgets('Nút "Nghe đọc" tồn tại; nút "Sắp có" (mic) bị vô hiệu',
        (tester) async {
      await pumpReader(tester);

      expect(find.byTooltip('Nghe đọc'), findsOneWidget);
      final listenInkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byTooltip('Nghe đọc'),
          matching: find.byType(InkWell),
        ),
      );
      expect(listenInkWell.onTap, isNotNull);

      expect(find.byTooltip('Sắp có'), findsOneWidget);
      final micInkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byTooltip('Sắp có'),
          matching: find.byType(InkWell),
        ),
      );
      expect(micInkWell.onTap, isNull);
    });

    testWidgets('Mở lại truyện ở lastPage = 3', (tester) async {
      await pumpReader(tester, lastPage: 3);

      expect(find.text('Trời đẹp quá.'), findsOneWidget);
      expect(find.text('3 / 3'), findsOneWidget);
    });

    testWidgets('Màn ngang 844x390 không tràn', (tester) async {
      tester.view.physicalSize = const Size(844, 390);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await pumpReader(tester, physicalSize: const Size(844, 390));

      expect(tester.takeException(), isNull);
      final textFinder = find.text('Ếch nhảy lên lá sen.');
      expect(textFinder, findsOneWidget);

      final hasIllustration = find.byWidgetPredicate(
        (w) => w.runtimeType.toString() == 'AuthedAwareImage',
      ).evaluate().isNotEmpty;
      if (hasIllustration) {
        expect(tester.getTopLeft(textFinder).dx, greaterThan(844 / 2));
      }
    });
  });
}
