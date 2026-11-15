import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log_entry_dto.freezed.dart';
part 'audit_log_entry_dto.g.dart';

@freezed
abstract class AuditLogEntryDto with _$AuditLogEntryDto {
  const factory AuditLogEntryDto({
    required int id,
    int? actorUserId,
    required String action,
    required String entityType,
    required String entityId,
    required DateTime occurredAt,
  }) = _AuditLogEntryDto;

  factory AuditLogEntryDto.fromJson(Map<String, dynamic> json) =>
      _$AuditLogEntryDtoFromJson(json);
}
