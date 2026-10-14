import 'dart:math' as math;

import '../../core/api/api_result.dart';
import '../auth/mock_auth_repository.dart';
import '../models/ai_story_models.dart';
import '../models/child_models.dart';
import '../models/story_models.dart';
import '../repositories/ai_story_repository.dart';
import '../repositories/child_repository.dart';
import '../repositories/story_repository.dart';
import 'mock_db.dart';

// Các repository dữ liệu mẫu, port từ mocks/mockServices.ts và mocks/mockAiStory.ts.
// Không gọi máy chủ: trạng thái truyện tự chuyển theo thời gian để mô phỏng AI đang làm việc.

/// Thời gian mỗi bước của "AI" mẫu (ms).
abstract final class MockTiming {
  static const accept = 1200; // kiểm tra an toàn ý tưởng
  static const outline = 2200; // viết dàn ý
  static const regenerate = 2000; // viết lại dàn ý
  static const content = 1800; // nội dung ổn định
  static const learning = 4000; // học liệu xong
  static const review = 5000; // chuyển sang chờ duyệt
  static const media = 6000; // tranh + giọng đọc
}

final _blockedTopic = RegExp('ma quỷ|kinh dị|bạo lực|giết|máu', caseSensitive: false);

ApiResult<T> _missing<T>() => const ApiResult.fail('Không tìm thấy truyện (dữ liệu mẫu).');

/// Áp dụng thay đổi đến hạn (dàn ý viết lại xong) rồi trả về trạng thái hiện tại của truyện.
String mockStoryStatus(MockDb db, MockStory s) {
  final now = db.nowMs;
  if (s.pendingRegenAt != null && now >= s.pendingRegenAt!) {
    final prev = s.outlineVersions.last;
    s.outlineVersions = [for (final v in s.outlineVersions) v.copyWith(isCurrent: false), makeOutlineVersion(s.id, prev.versionNo + 1, s, db.now())];
    s.pendingRegenAt = null;
    db.save();
  }
  if (s.archived) return 'archived';
  if (s.mediaStartedAt != null) return now - s.mediaStartedAt! >= MockTiming.media ? 'ready' : 'media_processing';
  if (s.outlineApprovedAt != null) return now - s.outlineApprovedAt! >= MockTiming.review ? 'content_review' : 'outline_review';
  return now - s.acceptedAt >= MockTiming.outline ? 'outline_review' : 'input_accepted';
}

class _Latency {
  const _Latency(this.duration);
  final Duration duration;
  Future<void> call([Duration? d]) => Future<void>.delayed(d ?? duration);
}

class MockChildRepository implements ChildRepository {
  MockChildRepository(this._db, {Duration latency = const Duration(milliseconds: 220)}) : _wait = _Latency(latency);
  final MockDb _db;
  final _Latency _wait;

  @override
  Future<ApiResult<List<ChildProfile>>> getMyChildren() async {
    await _wait();
    return ApiResult.ok(mockChildren);
  }

  @override
  Future<ApiResult<List<ContentCategory>>> getContentCategories() async {
    await _wait();
    return const ApiResult.ok(mockCategories);
  }

  @override
  Future<ApiResult<SafetyPolicy>> getSafetyPolicy(int childId) async {
    await _wait();
    return ApiResult.ok(_db.policies[childId] ?? defaultMockPolicy(childId));
  }

  @override
  Future<ApiResult<void>> setSafetyPolicy(SafetyPolicy policy) async {
    await _wait();
    _db.policies[policy.childProfileId] = policy;
    _db.save();
    return const ApiResult.ok(null, message: 'Đã lưu quy tắc an toàn (dữ liệu mẫu).');
  }
}

class MockStoryRepository implements StoryRepository {
  MockStoryRepository(this._db, {Duration latency = const Duration(milliseconds: 220)}) : _wait = _Latency(latency);
  final MockDb _db;
  final _Latency _wait;

  Story _toStory(MockStory s) {
    final status = mockStoryStatus(_db, s);
    final paragraphs = s.content.split(RegExp(r'\n\s*\n'));
    return Story(
      id: s.id,
      title: s.title,
      synopsis: paragraphs.first,
      content: s.content,
      genre: s.genre,
      moralLesson: s.lesson,
      ageBand: mockChildren.where((c) => c.id == s.childId).firstOrNull?.ageBand ?? 'Age_6_8',
      language: 'vi',
      source: 'AI',
      status: status,
      isPublished: status == 'ready',
      authorName: mockUser.fullName,
      createdAt: s.createdAt,
      childProfileId: s.childId,
      categoryName: s.genre,
      pages: [for (final (i, p) in paragraphs.indexed) StoryPage(id: s.id * 100 + i, pageNumber: i + 1, content: p)],
    );
  }

  @override
  Future<ApiResult<PagedResult<Story>>> getStories(StoryFilter filter) async {
    await _wait();
    final q = filter.search?.trim().toLowerCase() ?? '';
    final items =
        _db.stories
            .where((s) => !s.archived && mockStoryStatus(_db, s) != 'input_accepted')
            .where((s) => filter.childProfileId == null || s.childId == filter.childProfileId)
            .map(_toStory)
            .where((s) => (filter.status == null || s.status == filter.status) && (q.isEmpty || s.title.toLowerCase().contains(q)))
            .where((s) => filter.ageBand == null || s.ageBand == filter.ageBand)
            .toList()
          ..sort((a, b) => filter.sortDescending ? b.createdAt.compareTo(a.createdAt) : a.createdAt.compareTo(b.createdAt));
    return ApiResult.ok(PagedResult(items: items, totalCount: items.length, pageNumber: 1, pageSize: items.length, hasNextPage: false));
  }

  @override
  Future<ApiResult<Story>> getStory(int id) async {
    await _wait();
    final s = _db.find(id);
    return s == null ? _missing() : ApiResult.ok(_toStory(s));
  }
}

class MockAiStoryRepository implements AiStoryRepository {
  MockAiStoryRepository(this._db, {Duration latency = const Duration(milliseconds: 220)}) : _wait = _Latency(latency);
  final MockDb _db;
  final _Latency _wait;

  /// Đọc tiến trình nhanh hơn thao tác ghi, giống web (120ms).
  Duration get _poll => Duration(milliseconds: math.min(120, _wait.duration.inMilliseconds));

  String _status(MockStory s) => mockStoryStatus(_db, s);

  InputProgress _input(MockStory s) {
    final elapsed = _db.nowMs - s.acceptedAt;
    final status = elapsed < MockTiming.accept
        ? InputStatus.checkingInput
        : s.blocked
        ? InputStatus.inputBlocked
        : InputStatus.inputAccepted;
    final blocked = status == InputStatus.inputBlocked;
    return InputProgress(
      requestId: s.requestId,
      storyId: s.id,
      status: status,
      canRetry: false,
      attemptCount: 1,
      maxAttempts: 3,
      reasonCode: blocked ? 'blocked_topic' : null,
      fallbackMessage: blocked ? 'Chủ đề này chưa phù hợp để kể đâu nè. Mình cùng nghe chuyện về các bạn động vật hoặc chuyến phiêu lưu trên mây nhé!' : null,
    );
  }

  OutlineProgress _outline(MockStory s) {
    final status = _status(s);
    final regen = s.pendingRegenAt != null;
    return OutlineProgress(
      storyId: s.id,
      storyStatus: status,
      currentVersion: status == 'input_accepted' ? null : s.outlineVersions.last,
      activeOperation: regen ? 'regenerate' : null,
    );
  }

  GenerationProgress _generation(MockStory s) {
    final status = _status(s);
    final e = s.outlineApprovedAt == null ? -1 : _db.nowMs - s.outlineApprovedAt!;
    final done = const {'content_review', 'approved', 'media_processing', 'ready'}.contains(status);
    final stable = done || e >= MockTiming.content;
    String art(int at) => e < 0
        ? 'pending'
        : done || e >= at
        ? 'completed'
        : e >= MockTiming.content
        ? 'running'
        : 'pending';
    return GenerationProgress(
      storyId: s.id,
      storyStatus: status,
      currentStep: e < 0
          ? 'not_started'
          : done
          ? 'completed'
          : stable
          ? 'learning_materials'
          : 'content',
      content: e < 0
          ? 'pending'
          : stable
          ? 'stable'
          : 'running',
      vocabulary: art(MockTiming.content + 800),
      quiz: art(MockTiming.content + 1600),
      discussion: art(MockTiming.learning),
      isComplete: done,
      stableStoryVersionId: stable ? s.reviewVersionId : null,
    );
  }

  MediaProgress _media(MockStory s) {
    final required = math.max(3, s.content.split(RegExp(r'\n\s*\n')).length);
    final e = s.mediaStartedAt == null ? 0 : _db.nowMs - s.mediaStartedAt!;
    final ready = e >= MockTiming.media;
    final step = math.min(required, (e / MockTiming.media * required).floor());
    return MediaProgress(
      storyId: s.id,
      storyStatus: _status(s),
      sceneCount: required,
      requiredIllustrations: required,
      readyIllustrations: ready ? required : step,
      readyAudio: ready ? required : step,
      isReady: ready,
    );
  }

  Future<ApiResult<T>> _with<T>(int id, T Function(MockStory s) f, {Duration? delay}) async {
    await _wait(delay);
    final s = _db.find(id);
    return s == null ? _missing() : ApiResult.ok(f(s));
  }

  @override
  Future<ApiResult<StoryCreationContext>> getCreationContext(int childId) async {
    await _wait();
    final c = mockChildren.where((x) => x.id == childId).firstOrNull;
    if (c == null) return const ApiResult.fail('Không tìm thấy hồ sơ bé.');
    final older = c.ageBand == 'Age_9_12';
    final policy = _db.policies[childId] ?? defaultMockPolicy(childId);
    String code(int id) => mockCategories.firstWhere((x) => x.id == id).code;
    final byRule = {for (final r in CategoryRule.values) r: <String>[]};
    for (final cat in mockCategories) {
      byRule[policy.ruleOf(cat.id)]!.add(code(cat.id));
    }
    return ApiResult.ok(
      StoryCreationContext(
        childProfileId: c.id,
        childNickname: c.nickname,
        ageBand: c.ageBand,
        readingLevel: older ? 3 : 2,
        defaultVocabularyLevel: older ? 'level_3' : 'level_2',
        availableVocabularyLevels: const ['level_1', 'level_2', 'level_3', 'level_4', 'level_5'],
        defaultLanguage: 'vi',
        availableLanguages: const ['vi', 'en'],
        maximumLength: policy.maxStoryLength,
        requiredApprovalMode: policy.approvalMode.apiValue,
        parentalGateEnabled: policy.parentalGateEnabled,
        safetyScoreThreshold: 0.8,
        interests: mockInterests[c.id] ?? const [],
        allowedCategoryCodes: byRule[CategoryRule.allowed]!,
        restrictedCategoryCodes: byRule[CategoryRule.restricted]!,
        blockedCategoryCodes: byRule[CategoryRule.blocked]!,
      ),
    );
  }

  @override
  Future<ApiResult<InputProgress>> submitInput(int childId, CreativeInput input, {required String idempotencyKey, int? existingStoryId}) async {
    await _wait();
    final existing = existingStoryId == null ? null : _db.find(existingStoryId);
    if (existing != null) return ApiResult.ok(_input(existing));
    final id = _db.nextStoryId++;
    final c = composeStory(input.topic, input.characters, input.lesson);
    final s = MockStory(
      id: id,
      childId: childId,
      requestId: id,
      topic: input.topic,
      genre: input.genre ?? 'Phiêu lưu',
      lesson: input.lesson,
      characters: input.characters,
      createdAt: _db.now(),
      acceptedAt: _db.nowMs,
      blocked: _blockedTopic.hasMatch('${input.topic} ${input.lesson}'),
      outlineVersions: const [],
      reviewVersionId: id * 10 + 1,
      title: c.title,
      content: c.content,
      vocabulary: c.vocabulary,
      quiz: c.quiz,
      discussion: c.discussion,
    );
    s.outlineVersions = [makeOutlineVersion(id, 1, s, _db.now())];
    _db.stories.insert(0, s);
    _db.save();
    return ApiResult.ok(_input(s));
  }

  @override
  Future<ApiResult<InputProgress>> getInputProgress(int storyId, int requestId) => _with(storyId, _input, delay: _poll);

  @override
  Future<ApiResult<InputProgress>> retryInput(int storyId, int requestId, CreativeInput input, {required String retryKey}) => _with(storyId, (s) {
    s
      ..acceptedAt = _db.nowMs
      ..blocked = _blockedTopic.hasMatch('${input.topic} ${input.lesson}');
    _db.save();
    return _input(s);
  });

  @override
  Future<ApiResult<OutlineProgress>> getOutline(int storyId) => _with(storyId, _outline, delay: _poll);

  @override
  Future<ApiResult<OutlineVersion>> editOutline(
    int storyId,
    int versionNo, {
    required String title,
    required String opening,
    required String development,
    required String ending,
  }) => _with(storyId, (s) {
    final prev = s.outlineVersions.last;
    final next = OutlineVersion(
      id: storyId * 100 + prev.versionNo + 1,
      versionNo: prev.versionNo + 1,
      editType: 'manual',
      title: title,
      opening: opening,
      development: development,
      ending: ending,
      isCurrent: true,
      createdAt: _db.now(),
    );
    s.outlineVersions = [for (final v in s.outlineVersions) v.copyWith(isCurrent: false), next];
    s.title = title;
    _db.save();
    return next;
  });

  @override
  Future<ApiResult<OutlineProgress>> regenerateOutline(int storyId, int versionNo, {required String operationKey}) => _with(storyId, (s) {
    s.pendingRegenAt = _db.nowMs + MockTiming.regenerate;
    _db.save();
    return _outline(s);
  });

  @override
  Future<ApiResult<OutlineProgress>> approveOutline(int storyId, int versionNo, {required String approvalKey}) => _with(storyId, (s) {
    s.outlineApprovedAt = _db.nowMs;
    final last = s.outlineVersions.last.copyWith(outlineApprovedAt: _db.now());
    s.outlineVersions = [...s.outlineVersions.sublist(0, s.outlineVersions.length - 1), last];
    _db.save();
    return _outline(s);
  });

  @override
  Future<ApiResult<OutlineProgress>> rejectOutline(int storyId, int versionNo, {required String reason}) => _with(storyId, (s) {
    s.archived = true;
    _db.save();
    return _outline(s);
  });

  @override
  Future<ApiResult<GenerationProgress>> getGenerationProgress(int storyId) => _with(storyId, _generation, delay: _poll);

  @override
  Future<ApiResult<ReviewPackage>> getReviewPackage(int storyId) => _with(storyId, (s) {
    final status = _status(s);
    final can = status == 'content_review';
    return ReviewPackage(
      storyId: s.id,
      storyVersionId: s.reviewVersionId,
      storyStatus: status,
      title: s.title,
      content: s.content,
      lesson: s.lesson,
      readabilityFkgl: 2.4,
      vocabularyCount: s.vocabulary.length,
      quizCount: s.quiz.length,
      discussionCount: s.discussion.length,
      canEdit: can,
      canApprove: can,
      canArchive: !s.archived,
    );
  });

  @override
  Future<ApiResult<List<VocabularyItem>>> getVocabulary(int storyId) => _with(storyId, (s) => s.vocabulary, delay: _poll);

  @override
  Future<ApiResult<List<QuizQuestion>>> getQuiz(int storyId) => _with(storyId, (s) => s.quiz, delay: _poll);

  @override
  Future<ApiResult<List<DiscussionPrompt>>> getDiscussion(int storyId) => _with(storyId, (s) => s.discussion, delay: _poll);

  @override
  Future<ApiResult<int>> updateStoryReview(int storyId, {required int versionId, required String title, required String content, required String lesson}) =>
      _with(storyId, (s) {
        s
          ..title = title
          ..content = content
          ..lesson = lesson
          ..reviewVersionId += 1;
        _db.save();
        return s.reviewVersionId;
      });

  @override
  Future<ApiResult<void>> generateMissingLearning(int storyId, ReviewPackage package) => _with(storyId, (s) {
    final c = composeStory(s.topic, s.characters, s.lesson);
    if (s.vocabulary.isEmpty) s.vocabulary = c.vocabulary;
    if (s.quiz.isEmpty) s.quiz = c.quiz;
    if (s.discussion.isEmpty) s.discussion = c.discussion;
    _db.save();
  });

  @override
  Future<ApiResult<ValidationResult>> validateReview(int storyId) => _with(
    storyId,
    (s) => const ValidationResult(
      canApprove: true,
      checks: [
        ValidationCheck(name: 'An toàn nội dung', passed: true, message: 'Đạt'),
        ValidationCheck(name: 'Độ khó phù hợp', passed: true, message: 'Mức 2'),
        ValidationCheck(name: 'Đủ học liệu', passed: true, message: 'Đủ'),
      ],
    ),
  );

  @override
  Future<ApiResult<void>> approveStory(int storyId) => _with(storyId, (s) {
    s.mediaStartedAt = _db.nowMs;
    _db.save();
  });

  @override
  Future<ApiResult<void>> archiveStory(int storyId, {String reason = 'Lưu trữ từ Taletale'}) => _with(storyId, (s) {
    s.archived = true;
    _db.save();
  });

  @override
  Future<ApiResult<MediaProgress>> getMediaProgress(int storyId) => _with(storyId, _media, delay: _poll);

  @override
  Future<ApiResult<MediaProgress>> retryMedia(int storyId) => _with(storyId, (s) {
    s.mediaStartedAt = _db.nowMs;
    _db.save();
    return _media(s);
  });
}
