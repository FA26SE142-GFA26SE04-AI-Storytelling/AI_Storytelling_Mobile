import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

/// Thông báo trong app (GET /Notification). [payload] là chuỗi JSON thô,
/// chỉ dùng để đọc thêm thông tin, không bao giờ hiện ra giao diện.
@freezed
abstract class NotificationDto with _$NotificationDto {
  const NotificationDto._();

  const factory NotificationDto({
    required int id,
    int? childProfileId,
    @Default('') String type,
    @Default('') String group,
    String? payload,
    @Default('') String status,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  /// Backend dùng trạng thái `Unread` / `Read`.
  bool get isUnread => readAt == null && status.toLowerCase() != 'read';
}
