import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_profile_dto.freezed.dart';
part 'child_profile_dto.g.dart';

@freezed
abstract class ChildProfileDto with _$ChildProfileDto {
  const factory ChildProfileDto({
    required int id,
    required String nickname,
    required String avatarId,
    required String ageBand,
    required String status,
    String? language,
    String? createdAt,
  }) = _ChildProfileDto;

  factory ChildProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ChildProfileDtoFromJson(json);
}
