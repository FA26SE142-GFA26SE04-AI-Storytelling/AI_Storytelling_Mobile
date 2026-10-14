import 'package:ai_storytelling_mobile/data/models/story_models.dart';
import 'package:ai_storytelling_mobile/domain/story_view.dart';
import 'package:flutter_test/flutter_test.dart';

Story story({String status = 'draft', bool published = false}) =>
    Story(id: 1, title: 't', ageBand: 'Age_6_8', status: status, isPublished: published, createdAt: DateTime.utc(2026));

void main() {
  test('normalizeStoryStatus đổi PascalCase sang snake_case', () {
    expect(normalizeStoryStatus('ContentReview'), 'content_review');
    expect(normalizeStoryStatus('MediaProcessing'), 'media_processing');
    expect(normalizeStoryStatus('ready'), 'ready');
  });

  test('nhãn trạng thái theo bảng của web', () {
    expect(storyStatus(story(status: 'ContentReview')), (StoryTone.wait, 'Chờ duyệt'));
    expect(storyStatus(story(status: 'ready', published: true)), (StoryTone.ok, 'Đã xuất bản'));
    expect(storyStatus(story(status: 'Archived')), (StoryTone.draft, 'Lưu trữ'));
    expect(storyStatus(story(status: 'SomethingNew')).$2, 'SomethingNew');
    expect(awaitsReview(story(status: 'ContentReview')), isTrue);
  });

  test('ageLabel', () {
    expect(ageLabel('Age_6_8'), '6–8 tuổi');
    expect(ageLabel('Age_3_5'), '3–5 tuổi');
  });

  group('splitScenes', () {
    test('tách theo đoạn', () {
      expect(splitScenes('Một.\n\nHai.\n  \nBa.'), ['Một.', 'Hai.', 'Ba.']);
    });

    test('một đoạn thì gom mỗi 3 câu', () {
      expect(splitScenes('A một. B hai! C ba? D bốn… E năm'), ['A một. B hai! C ba?', 'D bốn… E năm']);
    });

    test('rỗng', () {
      expect(splitScenes('  '), isEmpty);
    });
  });

  test('ảnh bìa tạm chọn màu ổn định theo id', () {
    expect(coverColors(7), coverColors(1));
    expect(coverColors(-2), hasLength(3));
  });

  test('shortDate bỏ năm nếu là năm nay', () {
    final now = DateTime(2026, 10, 14);
    expect(shortDate(DateTime(2026, 10, 13), now: now), '13/10');
    expect(shortDate(DateTime(2025, 1, 2), now: now), '2/1/2025');
    expect(shortDate(DateTime(2026, 10, 13), now: now, withYear: true), '13/10/2026');
  });
}
