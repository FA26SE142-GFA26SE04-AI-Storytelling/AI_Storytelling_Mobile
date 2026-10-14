import '../../core/api/api_client.dart';
import '../../core/api/api_result.dart';
import '../json.dart';
import '../models/story_models.dart';

abstract interface class StoryRepository {
  Future<ApiResult<PagedResult<Story>>> getStories(StoryFilter filter);

  Future<ApiResult<Story>> getStory(int id);
}

class ApiStoryRepository implements StoryRepository {
  ApiStoryRepository(this._api);
  final ApiClient _api;

  @override
  Future<ApiResult<PagedResult<Story>>> getStories(StoryFilter filter) =>
      _api.request('/Story', query: filter.toQuery(), parse: (d) => PagedResult.fromJson(asJson(d), Story.fromJson));

  @override
  Future<ApiResult<Story>> getStory(int id) => _api.request('/Story/$id', parse: (d) => Story.fromJson(asJson(d)));
}
