import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../models/child_session_dto.dart';

part 'stored_kid_session.freezed.dart';
part 'stored_kid_session.g.dart';

enum KidSessionVia {
  @JsonValue('easy_login')
  easyLogin,
  @JsonValue('handover')
  handover,
}

@freezed
abstract class StoredKidSession with _$StoredKidSession {
  const StoredKidSession._();

  const factory StoredKidSession({
    required int childProfileId,
    required String accessToken,
    required int expiresAtMs,
    required KidSessionVia via,
    @Default(true) bool parentalGateEnabled,
  }) = _StoredKidSession;

  factory StoredKidSession.fromJson(Map<String, dynamic> json) =>
      _$StoredKidSessionFromJson(json);

  static StoredKidSession fromChildSession(
    ChildSessionDto dto, {
    required KidSessionVia via,
    required bool parentalGateEnabled,
    DateTime? now,
  }) {
    final effectiveNow = now ?? DateTime.now();
    return StoredKidSession(
      childProfileId: dto.childProfileId,
      accessToken: dto.accessToken,
      expiresAtMs:
          effectiveNow.millisecondsSinceEpoch + dto.expiresInSeconds * 1000,
      via: via,
      parentalGateEnabled: parentalGateEnabled,
    );
  }

  bool isActiveAt(DateTime now) => now.millisecondsSinceEpoch < expiresAtMs;
}
