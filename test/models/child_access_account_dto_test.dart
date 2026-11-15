import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/models/audit_log_entry_dto.dart';
import 'package:ai_storytelling_mobile/models/child_access_credential_dto.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';
import 'package:ai_storytelling_mobile/models/content_category_dto.dart';
import 'package:ai_storytelling_mobile/models/login_session_dto.dart';

void main() {
  group('ChildProfileDto', () {
    test(
      'fromJson đủ trường: đọc đúng ownerUserId, shouldReapplyBlockedPreset, suggestedReadingMode',
      () {
        final json = {
          'id': 1,
          'nickname': 'Bé Bo',
          'avatarId': 'avatar_bunny',
          'ageBand': '3-5',
          'status': 'active',
          'language': 'vi',
          'createdAt': '2026-11-15T00:00:00Z',
          'ownerUserId': 42,
          'shouldReapplyBlockedPreset': true,
          'suggestedReadingMode': 'guided',
        };
        final dto = ChildProfileDto.fromJson(json);

        expect(dto.id, 1);
        expect(dto.nickname, 'Bé Bo');
        expect(dto.avatarId, 'avatar_bunny');
        expect(dto.ageBand, '3-5');
        expect(dto.status, 'active');
        expect(dto.language, 'vi');
        expect(dto.createdAt, '2026-11-15T00:00:00Z');
        expect(dto.ownerUserId, 42);
        expect(dto.shouldReapplyBlockedPreset, isTrue);
        expect(dto.suggestedReadingMode, 'guided');
      },
    );

    test(
      'fromJson JSON cũ không có 3 trường mới: 3 field là null không văng lỗi',
      () {
        final json = {
          'id': 2,
          'nickname': 'Bé Bông',
          'avatarId': 'avatar_bear',
          'ageBand': '6-8',
          'status': 'active',
        };
        final dto = ChildProfileDto.fromJson(json);

        expect(dto.id, 2);
        expect(dto.nickname, 'Bé Bông');
        expect(dto.avatarId, 'avatar_bear');
        expect(dto.ageBand, '6-8');
        expect(dto.status, 'active');
        expect(dto.ownerUserId, isNull);
        expect(dto.shouldReapplyBlockedPreset, isNull);
        expect(dto.suggestedReadingMode, isNull);
      },
    );
  });

  group('ContentCategoryDto', () {
    test('fromJson đủ trường: đọc đúng defaultBlockedAgeBands', () {
      final json = {
        'id': 10,
        'code': 'bedtime_stories',
        'displayName': 'Truyện trước giờ đi ngủ',
        'isActive': true,
        'defaultBlockedAgeBands': ['under_3', '3-5'],
      };
      final dto = ContentCategoryDto.fromJson(json);

      expect(dto.id, 10);
      expect(dto.code, 'bedtime_stories');
      expect(dto.displayName, 'Truyện trước giờ đi ngủ');
      expect(dto.isActive, isTrue);
      expect(dto.defaultBlockedAgeBands, ['under_3', '3-5']);
    });

    test('fromJson JSON không có defaultBlockedAgeBands: list rỗng', () {
      final json = {
        'id': 11,
        'code': 'adventure',
        'displayName': 'Phiêu lưu',
        'isActive': true,
      };
      final dto = ContentCategoryDto.fromJson(json);

      expect(dto.id, 11);
      expect(dto.code, 'adventure');
      expect(dto.displayName, 'Phiêu lưu');
      expect(dto.isActive, isTrue);
      expect(dto.defaultBlockedAgeBands, isEmpty);
    });
  });

  group('ChildAccessCredentialDto', () {
    test('fromJson đủ trường: có secret và easyLoginCreatedAt', () {
      final json = {
        'childProfileId': 1,
        'hasEasyLogin': true,
        'easyLoginCreatedAt': '2026-11-15T08:00:00.000Z',
        'secret': 'secret_code_123',
      };
      final dto = ChildAccessCredentialDto.fromJson(json);

      expect(dto.childProfileId, 1);
      expect(dto.hasEasyLogin, isTrue);
      expect(dto.secret, 'secret_code_123');
      expect(dto.easyLoginCreatedAt, DateTime.parse('2026-11-15T08:00:00.000Z'));
    });

    test(
      'fromJson không có secret và easyLoginCreatedAt null: nhận giá trị null',
      () {
        final json = {
          'childProfileId': 2,
          'hasEasyLogin': false,
          'easyLoginCreatedAt': null,
        };
        final dto = ChildAccessCredentialDto.fromJson(json);

        expect(dto.childProfileId, 2);
        expect(dto.hasEasyLogin, isFalse);
        expect(dto.secret, isNull);
        expect(dto.easyLoginCreatedAt, isNull);
      },
    );
  });

  group('EasyLoginSecretDto', () {
    test('fromJson đủ trường: đọc secret và createdAt (DateTime)', () {
      final json = {
        'secret': 'sec_abc123',
        'createdAt': '2026-11-15T08:30:00.000Z',
      };
      final dto = EasyLoginSecretDto.fromJson(json);

      expect(dto.secret, 'sec_abc123');
      expect(dto.createdAt, DateTime.parse('2026-11-15T08:30:00.000Z'));
    });

    test('toJson tuần tự hóa đúng secret và chuỗi createdAt ISO-8601', () {
      final dto = EasyLoginSecretDto(
        secret: 'sec_xyz789',
        createdAt: DateTime.parse('2026-11-15T10:00:00.000Z'),
      );
      final json = dto.toJson();

      expect(json['secret'], 'sec_xyz789');
      expect(json['createdAt'], '2026-11-15T10:00:00.000Z');
    });
  });

  group('AuditLogEntryDto', () {
    test('fromJson đủ trường: actorUserId có giá trị và occurredAt đọc đúng', () {
      final json = {
        'id': 1,
        'actorUserId': 1001,
        'action': 'update_safety_policy',
        'entityType': 'ChildProfile',
        'entityId': 123,
        'occurredAt': '2026-11-15T09:15:00.000Z',
      };
      final dto = AuditLogEntryDto.fromJson(json);

      expect(dto.id, 1);
      expect(dto.actorUserId, 1001);
      expect(dto.action, 'update_safety_policy');
      expect(dto.entityType, 'ChildProfile');
      expect(dto.entityId, 123);
      expect(dto.occurredAt, DateTime.parse('2026-11-15T09:15:00.000Z'));
    });

    test(
      'fromJson thiếu hoặc null actorUserId: actorUserId null được và occurredAt đọc đúng',
      () {
        final json = {
          'id': 2,
          'actorUserId': null,
          'action': 'system_sync',
          'entityType': 'ChildProfile',
          'entityId': 123,
          'occurredAt': '2026-11-15T09:20:00.000Z',
        };
        final dto = AuditLogEntryDto.fromJson(json);

        expect(dto.id, 2);
        expect(dto.actorUserId, isNull);
        expect(dto.action, 'system_sync');
        expect(dto.entityType, 'ChildProfile');
        expect(dto.entityId, 123);
        expect(dto.occurredAt, DateTime.parse('2026-11-15T09:20:00.000Z'));
      },
    );
  });

  group('LoginSessionDto', () {
    test('fromJson đủ trường: id, issuedAt, expiresAt đọc đúng', () {
      final json = {
        'id': 101,
        'issuedAt': '2026-11-15T08:00:00.000Z',
        'expiresAt': '2026-11-15T12:00:00.000Z',
      };
      final dto = LoginSessionDto.fromJson(json);

      expect(dto.id, 101);
      expect(dto.issuedAt, DateTime.parse('2026-11-15T08:00:00.000Z'));
      expect(dto.expiresAt, DateTime.parse('2026-11-15T12:00:00.000Z'));
    });

    test('toJson tuần tự hóa đúng id, issuedAt, expiresAt', () {
      final dto = LoginSessionDto(
        id: 202,
        issuedAt: DateTime.parse('2026-11-15T09:00:00.000Z'),
        expiresAt: DateTime.parse('2026-11-15T13:00:00.000Z'),
      );
      final json = dto.toJson();

      expect(json['id'], 202);
      expect(json['issuedAt'], '2026-11-15T09:00:00.000Z');
      expect(json['expiresAt'], '2026-11-15T13:00:00.000Z');
    });
  });
}
