import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_session_dto.freezed.dart';
part 'login_session_dto.g.dart';

@freezed
abstract class LoginSessionDto with _$LoginSessionDto {
  const factory LoginSessionDto({
    required int id,
    required DateTime issuedAt,
    required DateTime expiresAt,
  }) = _LoginSessionDto;

  factory LoginSessionDto.fromJson(Map<String, dynamic> json) =>
      _$LoginSessionDtoFromJson(json);
}
