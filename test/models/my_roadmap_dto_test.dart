import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/my_roadmap_dto.dart';

void main() {
  test('MyRoadmapDto đọc được dữ liệu thật: open không có isLocked', () {
    // Rút gọn từ GET /MyRoadmap của Backend (12/11/2026): "open" thiếu trường isLocked.
    final dto = MyRoadmapDto.fromJson({
      'open': {
        'storyId': 908,
        'title': 'Chuyến phiêu lưu của Sóc Bông và Thỏ Trắng',
        'coverImageUrl': 'https://example.com/a.png#crop=0.19,0.12,0.31,0.74',
        'note': null,
        'expectedBy': null,
      },
      'upcoming': <dynamic>[],
      'done': [
        {'storyId': 911, 'title': 'Rùa và thỏ', 'coverImageUrl': null, 'completedAt': '2026-11-08T10:16:59Z'},
      ],
      'completedCount': 1,
      'totalCount': 2,
      'isFinished': false,
    });

    expect(dto.open?.storyId, 908);
    expect(dto.open?.isLocked, isFalse);
    expect(dto.done, hasLength(1));
  });
}
