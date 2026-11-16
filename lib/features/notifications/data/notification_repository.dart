import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../models/notification_dto.dart';

// ─── Abstract contract ───────────────────────────────────────────────────────

abstract class NotificationRepository {
  Future<List<NotificationDto>> list();
  Future<int> unreadCount();
  Future<void> markRead(int id);
  Future<void> markAllRead();
  Future<void> delete(int id);
}

// ─── Implementation ──────────────────────────────────────────────────────────

class ApiNotificationRepository implements NotificationRepository {
  ApiNotificationRepository({required this.dio});

  final Dio dio;

  /// Giải nén data từ response theo cấu trúc {"success", "message", "data"}.
  dynamic _unwrap(Response<dynamic> response) {
    final body = response.data as Map<String, dynamic>?;
    if (body == null || body['success'] != true) {
      final msg = (body?['message'] as String?)?.trim();
      throw ApiException(
        statusCode: response.statusCode,
        message: (msg != null && msg.isNotEmpty)
            ? msg
            : 'Có lỗi xảy ra. Vui lòng thử lại.',
      );
    }
    return body['data'];
  }

  @override
  Future<List<NotificationDto>> list() => runApi(() async {
        final data = _unwrap(await dio.get<dynamic>('/Notification'));
        if (data == null) return <NotificationDto>[];
        return (data as List<dynamic>)
            .map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  @override
  Future<int> unreadCount() => runApi(() async {
        final data =
            _unwrap(await dio.get<dynamic>('/Notification/unread-count'));
        return (data as num?)?.toInt() ?? 0;
      });

  @override
  Future<void> markRead(int id) => runApi(() async {
        _unwrap(await dio.put<dynamic>('/Notification/$id/read'));
      });

  @override
  Future<void> markAllRead() => runApi(() async {
        _unwrap(await dio.put<dynamic>('/Notification/read-all'));
      });

  @override
  Future<void> delete(int id) => runApi(() async {
        _unwrap(await dio.delete<dynamic>('/Notification/$id'));
      });
}

// ─── Providers ───────────────────────────────────────────────────────────────

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => ApiNotificationRepository(dio: ref.watch(dioProvider)),
);

/// Danh sách thông báo, mới nhất trước (Backend đã sắp xếp).
final notificationsProvider =
    FutureProvider.autoDispose<List<NotificationDto>>(
  (ref) => ref.watch(notificationRepositoryProvider).list(),
);

/// Số thông báo chưa đọc cho chấm/badge. Tự tải lại khi app trở lại foreground.
final unreadNotificationCountProvider = FutureProvider.autoDispose<int>((ref) {
  final listener = AppLifecycleListener(onResume: ref.invalidateSelf);
  ref.onDispose(listener.dispose);
  return ref.watch(notificationRepositoryProvider).unreadCount();
});
