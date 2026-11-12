// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildSessionDto _$ChildSessionDtoFromJson(Map<String, dynamic> json) =>
    _ChildSessionDto(
      childProfileId: (json['childProfileId'] as num).toInt(),
      avatarId: json['avatarId'] as String,
      accessToken: json['accessToken'] as String,
      expiresInSeconds: (json['expiresInSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$ChildSessionDtoToJson(_ChildSessionDto instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'avatarId': instance.avatarId,
      'accessToken': instance.accessToken,
      'expiresInSeconds': instance.expiresInSeconds,
    };

_ChildSessionProfileDto _$ChildSessionProfileDtoFromJson(
  Map<String, dynamic> json,
) => _ChildSessionProfileDto(
  childProfileId: (json['childProfileId'] as num).toInt(),
  nickname: json['nickname'] as String,
  ageBand: json['ageBand'] as String,
);

Map<String, dynamic> _$ChildSessionProfileDtoToJson(
  _ChildSessionProfileDto instance,
) => <String, dynamic>{
  'childProfileId': instance.childProfileId,
  'nickname': instance.nickname,
  'ageBand': instance.ageBand,
};
