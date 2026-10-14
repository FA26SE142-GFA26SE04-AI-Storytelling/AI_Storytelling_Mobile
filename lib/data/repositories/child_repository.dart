import '../../core/api/api_client.dart';
import '../../core/api/api_result.dart';
import '../json.dart';
import '../models/child_models.dart';

abstract interface class ChildRepository {
  /// Hồ sơ các bé của phụ huynh đang đăng nhập (bỏ hồ sơ đã lưu trữ).
  Future<ApiResult<List<ChildProfile>>> getMyChildren();

  Future<ApiResult<List<ContentCategory>>> getContentCategories();

  Future<ApiResult<SafetyPolicy>> getSafetyPolicy(int childId);

  Future<ApiResult<void>> setSafetyPolicy(SafetyPolicy policy);
}

class ApiChildRepository implements ChildRepository {
  ApiChildRepository(this._api);
  final ApiClient _api;

  @override
  Future<ApiResult<List<ChildProfile>>> getMyChildren() async {
    final res = await _api.request<List<ChildProfile>>('/ChildProfile/mine', parse: (d) => asList(d, ChildProfile.fromJson));
    if (!res.success) return res;
    return ApiResult.ok(res.data!.where((c) => !c.isArchived).toList());
  }

  @override
  Future<ApiResult<List<ContentCategory>>> getContentCategories() async {
    final res = await _api.request<List<ContentCategory>>('/ContentCategory', parse: (d) => asList(d, ContentCategory.fromJson));
    if (!res.success) return res;
    return ApiResult.ok(res.data!.where((c) => c.isActive).toList());
  }

  @override
  Future<ApiResult<SafetyPolicy>> getSafetyPolicy(int childId) => _api.request('/SafetyPolicy/$childId', parse: (d) => SafetyPolicy.fromJson(asJson(d)));

  @override
  Future<ApiResult<void>> setSafetyPolicy(SafetyPolicy policy) =>
      _api.request<void>('/SafetyPolicy/${policy.childProfileId}', method: 'PUT', body: policy.toRequestJson());
}
