// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginSessionDto _$LoginSessionDtoFromJson(Map<String, dynamic> json) =>
    _LoginSessionDto(
      id: (json['id'] as num).toInt(),
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$LoginSessionDtoToJson(_LoginSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
    };
