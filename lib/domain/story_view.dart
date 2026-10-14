import 'dart:ui' show Color;

import '../data/models/ai_story_models.dart';
import '../data/models/story_models.dart';

// Logic hiển thị truyện dùng chung, port từ lib/storyView.ts và story-workflow/storyGenerationFlow.ts bên web.

/// "ContentReview" / "content_review" → "content_review".
String normalizeStoryStatus(String value) => value.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]}_${m[2]}').toLowerCase();

enum StoryTone { ok, wait, draft }

const _statuses = <String, (StoryTone, String)>{
  'published': (StoryTone.ok, 'Đã xuất bản'),
  'ready': (StoryTone.ok, 'Sẵn sàng'),
  'approved': (StoryTone.ok, 'Đã duyệt'),
  'media_processing': (StoryTone.wait, 'Đang tạo minh hoạ'),
  'content_review': (StoryTone.wait, 'Chờ duyệt'),
  'outline_review': (StoryTone.wait, 'Chờ duyệt dàn ý'),
  'input_accepted': (StoryTone.wait, 'Đang xử lý'),
  'rejected': (StoryTone.draft, 'Bị từ chối'),
  'archived': (StoryTone.draft, 'Lưu trữ'),
  'draft': (StoryTone.draft, 'Bản nháp'),
};

String statusKey(Story s) => s.isPublished ? 'published' : normalizeStoryStatus(s.status.isEmpty ? 'draft' : s.status);

/// Màu nhãn và chữ trạng thái của truyện.
(StoryTone, String) storyStatus(Story s) => _statuses[statusKey(s)] ?? (StoryTone.draft, s.status.isEmpty ? 'Bản nháp' : s.status);

/// Bé đọc được: đã duyệt và có minh hoạ.
bool isReadable(Story s) => storyStatus(s).$1 == StoryTone.ok;

/// Đang chờ phụ huynh duyệt nội dung.
bool awaitsReview(Story s) => statusKey(s) == 'content_review';

bool isMediaStage(String status) => const {'approved', 'media_processing', 'ready'}.contains(normalizeStoryStatus(status));

String ageLabel(String band) => switch (band) {
  'Age_6_8' => '6–8 tuổi',
  'Age_9_12' => '9–12 tuổi',
  _ => '${band.replaceFirst('Age_', '').replaceFirst('_', '–')} tuổi',
};

/// Chủ đề hiển thị: danh mục, thể loại hoặc "Khác".
String storyTopic(Story s) => (s.categoryName ?? '').isNotEmpty ? s.categoryName! : ((s.genre ?? '').isNotEmpty ? s.genre! : 'Khác');

String storyText(Story s) => s.content ?? s.pages.map((p) => p.content).join(' ');

int wordCount(String text) => text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;

/// Tách nội dung thành các cảnh: theo đoạn; nếu chỉ có một đoạn thì gom mỗi 3 câu.
List<String> splitScenes(String content) {
  final paragraphs = content.split(RegExp(r'\n\s*\n')).map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
  if (paragraphs.length > 1) return paragraphs;
  final single = paragraphs.isEmpty ? '' : paragraphs.first;
  final sentences = RegExp(r'''[^.!?…]+[.!?…]+["”']?\s*|[^.!?…]+$''').allMatches(single).map((m) => m[0]!).toList();
  return [for (var i = 0; i < sentences.length; i += 3) sentences.skip(i).take(3).join().trim()].where((s) => s.isNotEmpty).toList();
}

/// Các trang để bé đọc: ưu tiên trang có sẵn, không có thì tách từ nội dung.
List<String> readingPages(Story s) => s.pages.isNotEmpty ? [for (final p in s.pages) p.content] : splitScenes(s.content ?? '');

/// Ảnh bìa tạm khi chưa có minh hoạ: 3 điểm màu của gradient, chọn theo id (giống gradientFor bên web).
List<Color> coverColors(int id) => _covers[id.abs() % _covers.length];

const _covers = [
  [Color(0xFF2FA866), Color(0xFF6FD39A), Color(0xFFD2F5E0)],
  [Color(0xFF2D9CDB), Color(0xFF6FC8F0), Color(0xFFBDEBFF)],
  [Color(0xFFF59E0B), Color(0xFFFFC85C), Color(0xFFFFE9A8)],
  [Color(0xFFFF6B6B), Color(0xFFFFA07A), Color(0xFFFFD9A8)],
  [Color(0xFFE0568A), Color(0xFFF59BB6), Color(0xFFFFD6E2)],
  [Color(0xFF3B3A8C), Color(0xFF7A6FD6), Color(0xFFF0A6C0)],
];

/// Dàn ý mới đã sẵn sàng chờ phụ huynh duyệt (và khác phiên bản trước nếu có).
bool outlineReady(OutlineProgress p, {int? previousVersion}) {
  final v = p.currentVersion;
  return normalizeStoryStatus(p.storyStatus) == 'outline_review' &&
      v != null &&
      v.isCurrent &&
      p.activeOperation == null &&
      v.outlineApprovedAt == null &&
      (previousVersion == null || v.versionNo > previousVersion);
}

/// Đang viết nội dung, hay nội dung đã ổn định và đang tạo học liệu.
bool generatingLearning(GenerationProgress? p) => p != null && p.content == 'stable' && (p.stableStoryVersionId ?? 0) > 0;
