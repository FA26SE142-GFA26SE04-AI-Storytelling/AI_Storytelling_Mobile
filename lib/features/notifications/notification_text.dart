import 'dart:convert';

import '../../models/notification_dto.dart';

/// `StoryWishSubmitted` → `story_wish_submitted` (giống web lib/notifications.ts).
String notificationKey(String type) => type
    .replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (m) => '${m[1]}_${m[2]}',
    )
    .toLowerCase();

/// Câu hiển thị theo enum NotificationType của Backend (chép từ web).
const _texts = <String, String>{
  'supervision_invite': 'Bạn được mời cùng giám sát một bé',
  'supervision_invite_result': 'Lời mời giám sát đã được trả lời',
  'supervision_revoked': 'Bạn đã bị gỡ khỏi hồ sơ một bé',
  'permission_request': 'Có yêu cầu cấp thêm quyền',
  'permission_request_result': 'Yêu cầu cấp quyền đã được xử lý',
  'ownership_transfer_request': 'Có đề nghị chuyển quyền quản lý chính',
  'ownership_transfer_result': 'Đề nghị chuyển quyền đã được xử lý',
  'account_security_changed': 'Bảo mật tài khoản vừa thay đổi',
  'admin_role_changed': 'Quyền quản trị của bạn vừa thay đổi',
  'staff_invite': 'Bạn được mời làm thành viên vận hành',
  'story_wish_submitted': 'Bé vừa gửi một điều ước',
  'story_wish_expiring': 'Điều ước của bé sắp hết hạn',
  'story_summary_sent': 'Bé vừa gửi tóm tắt sau khi đọc truyện',
  'story_moderation_result': 'Truyện đã được kiểm duyệt an toàn',
  'content_moderation_result': 'Nội dung đã được kiểm duyệt',
  'story_archived_by_moderation': 'Một truyện đã bị lưu trữ sau kiểm duyệt',
  'roadmap_story_added': 'Có truyện mới trong lộ trình của con',
  'roadmap_story_removed': 'Một truyện đã được gỡ khỏi lộ trình',
  'roadmap_completed': 'Con đã đọc hết truyện trong lộ trình',
  'content_reported': 'Báo cáo nội dung đã được gửi',
  'content_report_resolved': 'Báo cáo nội dung đã được xử lý',
  'content_report_escalated':
      'Một báo cáo nội dung được chuyển lên quản trị viên',
  'community_library_reviewed': 'Truyện nộp thư viện cộng đồng đã được duyệt',
  'creator_content_flagged': 'Nội dung bạn tạo vừa bị gắn cờ',
  'moderation_sla_warning': 'Có mục kiểm duyệt sắp quá hạn xử lý',
  'payment_confirmed': 'Thanh toán thành công, gói đã được áp',
  'subscription_expiring':
      'Gói của bạn sắp hết hạn, hãy gia hạn để không gián đoạn',
  'story_rating_published': 'Truyện của bạn vừa có đánh giá mới',
  'story_rating_moderated': 'Đánh giá truyện của bạn đã được xem xét',
};

/// Câu dễ hiểu cho một thông báo. Không bao giờ trả JSON/payload thô.
String notificationText(NotificationDto n) {
  final key = notificationKey(n.type);
  if (key == 'content_moderation_result' && n.payload != null) {
    try {
      final p = jsonDecode(n.payload!);
      if (p is Map && p['itemType'] == 'PublicStoryRemoval') {
        final raw = p['storyTitle'];
        final title =
            raw is String && raw.trim().isNotEmpty ? ' “${raw.trim()}”' : '';
        if (p['decision'] == 'approved') {
          return 'Yêu cầu gỡ truyện$title đã được chấp thuận';
        }
        if (p['decision'] == 'rejected') {
          return 'Yêu cầu gỡ truyện$title đã bị từ chối';
        }
      }
    } catch (_) {
      // Payload cũ hoặc hỏng: giữ câu chung.
    }
  }
  return _texts[key] ?? 'Bạn có thông báo mới';
}

/// Màn mở khi chạm thông báo; null = chỉ đánh dấu đã đọc.
/// Việc của bé (lộ trình, điều ước, tóm tắt đọc) → tab Học tập; giám sát → màn Quản lý bé.
String? notificationTarget(NotificationDto n) {
  final key = notificationKey(n.type);
  if (key.startsWith('roadmap_') ||
      key.startsWith('story_wish_') ||
      key == 'story_summary_sent') {
    return '/learning';
  }
  if (n.group == 'supervisors') return '/kids';
  if (key == 'account_security_changed') return '/account';
  return null;
}

/// Thời gian tương đối: "Vừa xong", "5 phút trước", "Hôm qua", "12/03/2026".
String relativeTime(DateTime at, {DateTime? now}) {
  final local = at.toLocal();
  final current = (now ?? DateTime.now()).toLocal();
  final diff = current.difference(local);
  if (diff.inMinutes < 1) return 'Vừa xong';
  if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
  final today = DateTime(current.year, current.month, current.day);
  final day = DateTime(local.year, local.month, local.day);
  final days = today.difference(day).inDays;
  if (days == 0) return '${diff.inHours} giờ trước';
  if (days == 1) return 'Hôm qua';
  if (days < 7) return '$days ngày trước';
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year}';
}
