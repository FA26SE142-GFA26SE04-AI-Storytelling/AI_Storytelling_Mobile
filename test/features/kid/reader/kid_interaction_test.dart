import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_session_controller.dart';
import 'package:ai_storytelling_mobile/features/kid/data/stored_kid_session.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/data/reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/reader/kid_reader_screen.dart';
import 'package:ai_storytelling_mobile/models/listening_dto.dart';
import 'package:ai_storytelling_mobile/models/read_aloud_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_content_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_interaction_dto.dart';
import 'package:ai_storytelling_mobile/models/reading_start_dto.dart';

class FakeReadingRepository implements ReadingRepository {
  FakeReadingRepository({this.lastPage = 1});

  final int lastPage;
  ListeningAttemptRequestDto? lastBody;
  int? lastInteractionId;

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
    return ReadingContentDto(
      sessionId: 5,
      storyId: 10,
      title: 'Chú ếch và hoa sen',
      scenes: [
        ReadingSceneDto(
          sceneId: 1,
          sceneIndex: 0,
          text: 'Ếch nhảy lên lá sen.',
          illustrationUrl: null,
          segments: const [],
          interaction: ReadingInteractionDto.fromJson(const {
            'id': 77,
            'type': 'Checkpoint',
            'prompt': 'Ếch nhảy vào đâu?',
            'options': [
              {'id': 1, 'text': 'Hồ nước'},
              {'id': 2, 'text': 'Trên cây'},
            ],
          }),
        ),
        const ReadingSceneDto(
          sceneId: 2,
          sceneIndex: 1,
          text: 'Cá bơi dưới ao.',
          segments: [],
        ),
      ],
      vocabulary: const [],
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

  @override
  Future<ListeningAttemptResultDto> attemptInteraction({
    required String token,
    required int sessionId,
    required int interactionId,
    required ListeningAttemptRequestDto body,
  }) async {
    lastBody = body;
    lastInteractionId = interactionId;
    return const ListeningAttemptResultDto(
      interactionId: 77,
      type: 'Checkpoint',
      matched: true,
      feedback: 'Đúng rồi, em giỏi quá!',
    );
  }

  @override
  Future<ReadAloudResultDto> readAloud({
    required String token,
    required int sessionId,
    required int segmentId,
    required Uint8List wavBytes,
  }) async {
    return const ReadAloudResultDto(
      sessionId: 5,
      segmentId: 1,
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
  required FakeReadingRepository fakeRepo,
  int storyId = 10,
  Size physicalSize = const Size(390, 844),
}) async {
  tester.view.physicalSize = physicalSize;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        readingRepositoryProvider.overrideWithValue(fakeRepo),
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
  group('Tương tác trong khi đọc của bé', () {
    testWidgets('Hiện hộp thoại checkpoint khi qua trang và chấm điểm lựa chọn',
        (tester) async {
      final fakeRepo = FakeReadingRepository();
      await pumpReader(tester, fakeRepo: fakeRepo);

      // Bấm "Trang sau" -> đến checkpoint của cảnh 0
      await tester.tap(find.byTooltip('Trang sau'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Hộp thoại checkpoint hiển thị câu hỏi
      expect(find.text('Ếch nhảy vào đâu?'), findsOneWidget);

      // Chạm lựa chọn 'Hồ nước'
      await tester.tap(find.text('Hồ nước'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Kiểm tra fake đã lưu thông tin attempt
      expect(fakeRepo.lastBody?.optionId, 1);
      expect(fakeRepo.lastInteractionId, 77);

      // Phản hồi đúng được hiển thị
      expect(find.text('Đúng rồi, em giỏi quá!'), findsOneWidget);

      // Sau khi trả lời: đáp án ẩn đi, phản hồi và nút "Đọc tiếp" nằm trong khung
      // màn 390x844 và bấm được (không bị đẩy xuống dưới mép hộp thoại).
      expect(find.text('Hồ nước'), findsNothing);
      expect(find.text('Đúng rồi, em giỏi quá!').hitTestable(), findsOneWidget);
      expect(find.text('Đọc tiếp').hitTestable(), findsOneWidget);
    });
  });
}
