import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/child_roadmap_dto.dart';
import '../../../models/parent_reading_feedback_dto.dart';
import '../data/home_repository.dart';

/// Tóm tắt một bé cho thẻ ở Trang chủ.
class ChildHomeSummary {
  const ChildHomeSummary({required this.readings, this.next});

  /// Truyện bé đã đọc xong, mới nhất trước (theo Backend).
  final List<ParentReadingFeedbackItemDto> readings;

  /// Bước "open" của lộ trình: truyện tiếp theo bé cần đọc.
  final ChildRoadmapItemDto? next;

  ParentReadingFeedbackItemDto? get latest =>
      readings.isEmpty ? null : readings.first;

  /// Số truyện đọc xong cùng ngày với [now] theo giờ máy.
  int readOn(DateTime now) => readings.where((r) {
        final d = r.completedAt?.toLocal();
        return d != null &&
            d.year == now.year &&
            d.month == now.month &&
            d.day == now.day;
      }).length;
}

final childHomeSummaryProvider = FutureProvider.autoDispose
    .family<ChildHomeSummary, int>((ref, childId) async {
  final repo = ref.watch(homeRepositoryProvider);
  // Future.wait (không dùng record .wait) để giữ nguyên ApiException cho thẻ hiện lỗi.
  final results = await Future.wait<Object?>([
    repo.fetchReadingFeedback(childId),
    repo.fetchRoadmap(childId),
  ]);
  final page = results[0] as ParentReadingFeedbackPageDto;
  final roadmap = results[1] as ChildRoadmapDto?;
  return ChildHomeSummary(readings: page.items, next: roadmap?.open);
});
