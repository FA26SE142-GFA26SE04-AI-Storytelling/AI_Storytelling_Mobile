import '../../core/api/api_client.dart';
import '../../core/api/api_result.dart';
import '../json.dart';
import '../models/ai_story_models.dart';

/// Quy trình tạo truyện AI (xem thứ tự các bước ở ai_story_models.dart).
/// Các khoá idempotency/operation do phía gọi tạo để gửi lại an toàn khi mạng chập chờn.
abstract interface class AiStoryRepository {
  Future<ApiResult<StoryCreationContext>> getCreationContext(int childId);

  Future<ApiResult<InputProgress>> submitInput(int childId, CreativeInput input, {required String idempotencyKey, int? existingStoryId});

  Future<ApiResult<InputProgress>> getInputProgress(int storyId, int requestId);

  Future<ApiResult<InputProgress>> retryInput(int storyId, int requestId, CreativeInput input, {required String retryKey});

  Future<ApiResult<OutlineProgress>> getOutline(int storyId);

  Future<ApiResult<OutlineVersion>> editOutline(
    int storyId,
    int versionNo, {
    required String title,
    required String opening,
    required String development,
    required String ending,
  });

  Future<ApiResult<OutlineProgress>> regenerateOutline(int storyId, int versionNo, {required String operationKey});

  Future<ApiResult<OutlineProgress>> approveOutline(int storyId, int versionNo, {required String approvalKey});

  Future<ApiResult<OutlineProgress>> rejectOutline(int storyId, int versionNo, {required String reason});

  Future<ApiResult<GenerationProgress>> getGenerationProgress(int storyId);

  Future<ApiResult<ReviewPackage>> getReviewPackage(int storyId);

  Future<ApiResult<List<VocabularyItem>>> getVocabulary(int storyId);

  Future<ApiResult<List<QuizQuestion>>> getQuiz(int storyId);

  Future<ApiResult<List<DiscussionPrompt>>> getDiscussion(int storyId);

  /// Lưu chỉnh sửa bản thảo. Trả về id phiên bản mới.
  Future<ApiResult<int>> updateStoryReview(int storyId, {required int versionId, required String title, required String content, required String lesson});

  /// Tạo học liệu còn thiếu (từ vựng, câu hỏi, gợi ý thảo luận).
  Future<ApiResult<void>> generateMissingLearning(int storyId, ReviewPackage package);

  Future<ApiResult<ValidationResult>> validateReview(int storyId);

  /// Duyệt nội dung: hệ thống bắt đầu tạo minh hoạ và giọng đọc.
  Future<ApiResult<void>> approveStory(int storyId);

  Future<ApiResult<void>> archiveStory(int storyId, {String reason});

  Future<ApiResult<MediaProgress>> getMediaProgress(int storyId);

  Future<ApiResult<MediaProgress>> retryMedia(int storyId);
}

class ApiAiStoryRepository implements AiStoryRepository {
  ApiAiStoryRepository(this._api);
  final ApiClient _api;

  static String _story(int id) => '/stories/$id';
  static String _outline(int id) => '${_story(id)}/outline';
  static String _review(int id) => '${_story(id)}/review';

  static InputProgress _input(Object? d) => InputProgress.fromJson(asJson(d));
  static OutlineProgress _outlineP(Object? d) => OutlineProgress.fromJson(asJson(d));
  static List<T> _items<T>(Object? d, T Function(Json) parse) => asList(asJson(d)['items'], parse);

  @override
  Future<ApiResult<StoryCreationContext>> getCreationContext(int childId) =>
      _api.request('/ai-story-input/children/$childId/context', parse: (d) => StoryCreationContext.fromJson(asJson(d)));

  @override
  Future<ApiResult<InputProgress>> submitInput(int childId, CreativeInput input, {required String idempotencyKey, int? existingStoryId}) => _api.request(
    '/ai-story-input/requests',
    method: 'POST',
    body: {...input.toJson(), 'childProfileId': childId, 'existingStoryId': ?existingStoryId, 'idempotencyKey': idempotencyKey},
    parse: _input,
  );

  @override
  Future<ApiResult<InputProgress>> getInputProgress(int storyId, int requestId) =>
      _api.request('/ai-story-input/stories/$storyId/requests/$requestId', parse: _input);

  @override
  Future<ApiResult<InputProgress>> retryInput(int storyId, int requestId, CreativeInput input, {required String retryKey}) => _api.request(
    '/ai-story-input/stories/$storyId/requests/$requestId/retry',
    method: 'POST',
    body: {...input.toJson(), 'retryKey': retryKey},
    parse: _input,
  );

  @override
  Future<ApiResult<OutlineProgress>> getOutline(int storyId) => _api.request(_outline(storyId), parse: _outlineP);

  @override
  Future<ApiResult<OutlineVersion>> editOutline(
    int storyId,
    int versionNo, {
    required String title,
    required String opening,
    required String development,
    required String ending,
  }) => _api.request(
    '${_outline(storyId)}/versions/$versionNo',
    method: 'PUT',
    body: {'title': title, 'opening': opening, 'development': development, 'ending': ending},
    parse: (d) => OutlineVersion.fromJson(asJson(d)),
  );

  @override
  Future<ApiResult<OutlineProgress>> regenerateOutline(int storyId, int versionNo, {required String operationKey}) =>
      _api.request('${_outline(storyId)}/versions/$versionNo/regenerate', method: 'POST', body: {'operationKey': operationKey}, parse: _outlineP);

  @override
  Future<ApiResult<OutlineProgress>> approveOutline(int storyId, int versionNo, {required String approvalKey}) =>
      _api.request('${_outline(storyId)}/versions/$versionNo/approve', method: 'POST', body: {'approvalKey': approvalKey}, parse: _outlineP);

  @override
  Future<ApiResult<OutlineProgress>> rejectOutline(int storyId, int versionNo, {required String reason}) =>
      _api.request('${_outline(storyId)}/versions/$versionNo/reject', method: 'POST', body: {'reason': reason}, parse: _outlineP);

  @override
  Future<ApiResult<GenerationProgress>> getGenerationProgress(int storyId) =>
      _api.request('${_story(storyId)}/generation/progress', parse: (d) => GenerationProgress.fromJson(asJson(d)));

  @override
  Future<ApiResult<ReviewPackage>> getReviewPackage(int storyId) => _api.request(_review(storyId), parse: (d) => ReviewPackage.fromJson(asJson(d)));

  @override
  Future<ApiResult<List<VocabularyItem>>> getVocabulary(int storyId) =>
      _api.request('${_review(storyId)}/vocabulary', parse: (d) => _items(d, VocabularyItem.fromJson));

  @override
  Future<ApiResult<List<QuizQuestion>>> getQuiz(int storyId) => _api.request('${_review(storyId)}/quiz', parse: (d) => _items(d, QuizQuestion.fromJson));

  @override
  Future<ApiResult<List<DiscussionPrompt>>> getDiscussion(int storyId) =>
      _api.request('${_review(storyId)}/discussion', parse: (d) => _items(d, DiscussionPrompt.fromJson));

  @override
  Future<ApiResult<int>> updateStoryReview(int storyId, {required int versionId, required String title, required String content, required String lesson}) =>
      _api.request(
        '${_review(storyId)}/story',
        method: 'PUT',
        body: {'versionId': versionId, 'title': title, 'content': content, 'lesson': lesson},
        parse: (d) => asInt(asJson(d)['versionId']),
      );

  @override
  Future<ApiResult<void>> generateMissingLearning(int storyId, ReviewPackage package) => _api.request<void>(
    '${_review(storyId)}/artifacts/generate',
    method: 'POST',
    body: {
      'storyVersionId': package.storyVersionId,
      'includeVocabulary': package.vocabularyCount == 0,
      'includeQuiz': package.quizCount == 0,
      'includeDiscussion': package.discussionCount == 0,
    },
  );

  @override
  Future<ApiResult<ValidationResult>> validateReview(int storyId) =>
      _api.request('${_review(storyId)}/validation', parse: (d) => ValidationResult.fromJson(asJson(d)));

  @override
  Future<ApiResult<void>> approveStory(int storyId) => _api.request<void>('${_review(storyId)}/approve', method: 'POST');

  @override
  Future<ApiResult<void>> archiveStory(int storyId, {String reason = 'Lưu trữ từ Taletale'}) =>
      _api.request<void>('${_review(storyId)}/archive', method: 'POST', body: {'reason': reason});

  @override
  Future<ApiResult<MediaProgress>> getMediaProgress(int storyId) =>
      _api.request('${_story(storyId)}/media/progress', parse: (d) => MediaProgress.fromJson(asJson(d)));

  @override
  Future<ApiResult<MediaProgress>> retryMedia(int storyId) =>
      _api.request('${_story(storyId)}/media/retry', method: 'POST', parse: (d) => MediaProgress.fromJson(asJson(d)));
}
