import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/features/library/presentation/story_preview_actions.dart';
import 'package:ai_storytelling_mobile/models/story_handover_dto.dart';

void main() {
  test('roadmapAddSummary gom bé đã thêm và bé bị bỏ qua', () {
    final s = roadmapAddSummary(
      [
        (childProfileId: 1, outcome: 'Added', message: null),
        (childProfileId: 2, outcome: 'Skipped', message: 'Truyện đã có'),
      ],
      {1: 'Na', 2: 'Bin'},
    );
    expect(s.anyAdded, isTrue);
    expect(s.message, 'Đã thêm vào lộ trình của Na. Bỏ qua Bin: Truyện đã có.');
  });

  test('sorted: bé gợi ý lên đầu, rồi bé đọc được', () {
    final o = StoryHandoverOptionsDto.fromJson({
      'storyId': 9,
      'suggestedChildProfileId': 3,
      'children': [
        {'childProfileId': 1, 'nickname': 'A', 'canRead': false, 'message': 'x'},
        {'childProfileId': 2, 'nickname': 'B', 'canRead': true},
        {'childProfileId': 3, 'nickname': 'C', 'canRead': true},
      ],
    });
    expect(o.sorted.map((c) => c.childProfileId), [3, 2, 1]);
  });
}
