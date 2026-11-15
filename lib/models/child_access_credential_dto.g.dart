// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_access_credential_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildAccessCredentialDto _$ChildAccessCredentialDtoFromJson(
  Map<String, dynamic> json,
) => _ChildAccessCredentialDto(
  childProfileId: (json['childProfileId'] as num).toInt(),
  hasEasyLogin: json['hasEasyLogin'] as bool,
  easyLoginCreatedAt: json['easyLoginCreatedAt'] == null
      ? null
      : DateTime.parse(json['easyLoginCreatedAt'] as String),
  secret: json['secret'] as String?,
);

Map<String, dynamic> _$ChildAccessCredentialDtoToJson(
  _ChildAccessCredentialDto instance,
) => <String, dynamic>{
  'childProfileId': instance.childProfileId,
  'hasEasyLogin': instance.hasEasyLogin,
  'easyLoginCreatedAt': instance.easyLoginCreatedAt?.toIso8601String(),
  'secret': instance.secret,
};

_EasyLoginSecretDto _$EasyLoginSecretDtoFromJson(Map<String, dynamic> json) =>
    _EasyLoginSecretDto(
      secret: json['secret'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$EasyLoginSecretDtoToJson(_EasyLoginSecretDto instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'createdAt': instance.createdAt.toIso8601String(),
    };
