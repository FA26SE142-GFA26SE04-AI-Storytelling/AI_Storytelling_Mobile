// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditLogEntryDto _$AuditLogEntryDtoFromJson(Map<String, dynamic> json) =>
    _AuditLogEntryDto(
      id: (json['id'] as num).toInt(),
      actorUserId: (json['actorUserId'] as num?)?.toInt(),
      action: json['action'] as String,
      entityType: json['entityType'] as String,
      entityId: (json['entityId'] as num).toInt(),
      occurredAt: DateTime.parse(json['occurredAt'] as String),
    );

Map<String, dynamic> _$AuditLogEntryDtoToJson(_AuditLogEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actorUserId': instance.actorUserId,
      'action': instance.action,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'occurredAt': instance.occurredAt.toIso8601String(),
    };
