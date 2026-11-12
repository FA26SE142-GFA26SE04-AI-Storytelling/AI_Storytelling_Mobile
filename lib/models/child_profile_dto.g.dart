// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildProfileDto _$ChildProfileDtoFromJson(Map<String, dynamic> json) =>
    _ChildProfileDto(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String,
      avatarId: json['avatarId'] as String,
      ageBand: json['ageBand'] as String,
      status: json['status'] as String,
      language: json['language'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChildProfileDtoToJson(_ChildProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avatarId': instance.avatarId,
      'ageBand': instance.ageBand,
      'status': instance.status,
      'language': instance.language,
      'createdAt': instance.createdAt,
    };
