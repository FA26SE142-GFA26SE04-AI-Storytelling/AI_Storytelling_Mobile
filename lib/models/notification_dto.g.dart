// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: (json['id'] as num).toInt(),
      childProfileId: (json['childProfileId'] as num?)?.toInt(),
      type: json['type'] as String? ?? '',
      group: json['group'] as String? ?? '',
      payload: json['payload'] as String?,
      status: json['status'] as String? ?? '',
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childProfileId': instance.childProfileId,
      'type': instance.type,
      'group': instance.group,
      'payload': instance.payload,
      'status': instance.status,
      'readAt': instance.readAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
