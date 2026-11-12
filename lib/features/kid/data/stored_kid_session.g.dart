// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_kid_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredKidSession _$StoredKidSessionFromJson(Map<String, dynamic> json) =>
    _StoredKidSession(
      childProfileId: (json['childProfileId'] as num).toInt(),
      accessToken: json['accessToken'] as String,
      expiresAtMs: (json['expiresAtMs'] as num).toInt(),
      via: $enumDecode(_$KidSessionViaEnumMap, json['via']),
      parentalGateEnabled: json['parentalGateEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$StoredKidSessionToJson(_StoredKidSession instance) =>
    <String, dynamic>{
      'childProfileId': instance.childProfileId,
      'accessToken': instance.accessToken,
      'expiresAtMs': instance.expiresAtMs,
      'via': _$KidSessionViaEnumMap[instance.via]!,
      'parentalGateEnabled': instance.parentalGateEnabled,
    };

const _$KidSessionViaEnumMap = {
  KidSessionVia.easyLogin: 'easy_login',
  KidSessionVia.handover: 'handover',
};
