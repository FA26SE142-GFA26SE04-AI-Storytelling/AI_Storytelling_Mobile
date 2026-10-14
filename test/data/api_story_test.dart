import 'package:ai_storytelling_mobile/core/api/api_client.dart';
import 'package:ai_storytelling_mobile/core/storage/session_storage.dart';
import 'package:ai_storytelling_mobile/data/models/child_models.dart';
import 'package:ai_storytelling_mobile/data/models/story_models.dart';
import 'package:ai_storytelling_mobile/data/repositories/child_repository.dart';
import 'package:ai_storytelling_mobile/data/repositories/story_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  ApiClient client(FakeAdapter adapter) => ApiClient(baseUrl: 'https://test/api/v1', session: SessionStorage(MemorySecureStore()), adapter: adapter);

  test('GET /Story gửi đúng query và đọc trang kết quả', () async {
    final adapter = FakeAdapter({
      'GET /Story': (_) => (
        200,
        envelope({
          'items': [
            {
              'id': 9,
              'title': 'Mây',
              'ageBand': 'Age_6_8',
              'status': 'Ready',
              'isPublished': true,
              'createdAt': '2026-10-01T00:00:00Z',
              'source': 'AI',
              'pages': [
                {'pageNumber': 2, 'content': 'B'},
                {'pageNumber': 1, 'content': 'A'},
              ],
            },
          ],
          'totalCount': 1,
          'pageNumber': 1,
          'pageSize': 100,
          'totalPages': 1,
          'hasPreviousPage': false,
          'hasNextPage': false,
        }),
      ),
    });

    final res = await ApiStoryRepository(client(adapter)).getStories(const StoryFilter(childProfileId: 3, search: ' mây '));

    expect(adapter.calls.single.queryParameters, {
      'search': 'mây',
      'childProfileId': 3,
      'sortBy': 'createdAt',
      'sortDescending': true,
      'pageNumber': 1,
      'pageSize': 100,
    });
    final s = res.data!.items.single;
    expect(s.fromAi, isTrue);
    expect(s.pages.map((p) => p.content), ['A', 'B'], reason: 'sắp theo số trang');
  });

  test('chính sách an toàn: đọc quy tắc và gửi lại đúng khuôn', () async {
    final adapter = FakeAdapter({
      'GET /SafetyPolicy/4': (_) => (
        200,
        envelope({
          'id': 1,
          'childProfileId': 4,
          'maxStoryLength': 800,
          'requiredApprovalMode': 'AutoPublishOnThreshold',
          'parentalGateEnabled': true,
          'consentRecorded': true,
          'categories': [
            {'contentCategoryId': 5, 'rule': 'Blocked'},
          ],
        }),
      ),
      'PUT /SafetyPolicy/4': (_) => (200, envelope(null)),
    });
    final repo = ApiChildRepository(client(adapter));

    final policy = (await repo.getSafetyPolicy(4)).data!;
    expect(policy.approvalMode, ApprovalMode.autoPublishOnThreshold);
    expect(policy.ruleOf(5), CategoryRule.blocked);

    await repo.setSafetyPolicy(policy.copyWith(rules: {...policy.rules, 2: CategoryRule.restricted}));
    expect(adapter.calls.last.data, {
      'maxStoryLength': 800,
      'requiredApprovalMode': 'AutoPublishOnThreshold',
      'parentalGateEnabled': true,
      'consentRecorded': true,
      'categories': [
        {'contentCategoryId': 5, 'rule': 'Blocked'},
        {'contentCategoryId': 2, 'rule': 'Restricted'},
      ],
    });
  });

  test('bỏ hồ sơ bé đã lưu trữ', () async {
    Map<String, Object?> kid(int id, String status) => {
      'id': id,
      'ownerUserId': 1,
      'nickname': 'Bé $id',
      'ageBand': 'Age_6_8',
      'status': status,
      'createdAt': '2026-08-01T00:00:00Z',
    };
    final adapter = FakeAdapter({
      'GET /ChildProfile/mine': (_) => (200, envelope([kid(1, 'Active'), kid(2, 'Archived')])),
    });

    final res = await ApiChildRepository(client(adapter)).getMyChildren();
    expect(res.data!.map((c) => c.id), [1]);
  });
}
