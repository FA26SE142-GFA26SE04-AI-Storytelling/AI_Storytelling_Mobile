import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_session_dto.freezed.dart';
part 'child_session_dto.g.dart';

@freezed
abstract class ChildSessionDto with _$ChildSessionDto {
  const factory ChildSessionDto({
    required int childProfileId,
    required String avatarId,
    required String accessToken,
    required int expiresInSeconds,
  }) = _ChildSessionDto;

  factory ChildSessionDto.fromJson(Map<String, dynamic> json) =>
      _$ChildSessionDtoFromJson(json);
}

@freezed
abstract class ChildSessionProfileDto with _$ChildSessionProfileDto {
  const factory ChildSessionProfileDto({
    required int childProfileId,
    required String nickname,
    required String ageBand,
  }) = _ChildSessionProfileDto;

  factory ChildSessionProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ChildSessionProfileDtoFromJson(json);
}
