import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_access_credential_dto.freezed.dart';
part 'child_access_credential_dto.g.dart';

@freezed
abstract class ChildAccessCredentialDto with _$ChildAccessCredentialDto {
  const factory ChildAccessCredentialDto({
    required int childProfileId,
    required bool hasEasyLogin,
    DateTime? easyLoginCreatedAt,
    String? secret,
  }) = _ChildAccessCredentialDto;

  factory ChildAccessCredentialDto.fromJson(Map<String, dynamic> json) =>
      _$ChildAccessCredentialDtoFromJson(json);
}

@freezed
abstract class EasyLoginSecretDto with _$EasyLoginSecretDto {
  const factory EasyLoginSecretDto({
    required String secret,
    required DateTime createdAt,
  }) = _EasyLoginSecretDto;

  factory EasyLoginSecretDto.fromJson(Map<String, dynamic> json) =>
      _$EasyLoginSecretDtoFromJson(json);
}
