import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_child_avatar.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/features/children/data/child_profile_repository.dart';
import 'package:ai_storytelling_mobile/features/children/presentation/child_profile_screen.dart';
import 'package:ai_storytelling_mobile/models/audit_log_entry_dto.dart';
import 'package:ai_storytelling_mobile/models/child_profile_dto.dart';

const _owner = UserProfile(
  id: 7,
  username: 'me',
  email: 'me@example.com',
  fullName: 'Me',
  role: 'User',
  status: 'Active',
);

const _child = ChildProfileDto(
  id: 1,
  nickname: 'Bé An',
  avatarId: 'avatar-default',
  ageBand: 'Age_6_8',
  status: 'Active',
  ownerUserId: 7,
);

class _Repo implements ChildProfileRepository {
  String? savedAvatarId;
  int updateCalls = 0;

  @override
  Future<ChildProfileDto> fetchById(int id) async => _child;

  @override
  Future<ChildProfileDto> update(
    int id, {
    required String nickname,
    required String ageBand,
    String? avatarId,
  }) async {
    updateCalls++;
    savedAvatarId = avatarId;
    return _child.copyWith(avatarId: avatarId ?? _child.avatarId);
  }

  @override
  Future<({List<AuditLogEntryDto> items, int totalPages})> auditLog(
    int id, {
    int pageIndex = 1,
  }) async =>
      (items: const <AuditLogEntryDto>[], totalPages: 0);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _SignedIn extends AuthController {
  @override
  AuthState build() => const AuthSignedIn(_owner);
}

void main() {
  testWidgets(
    'Sửa thông tin: chọn ảnh đại diện khác thì hiện nút Lưu và gửi đúng mã',
    (tester) async {
      // Font test vẽ chữ thành ô vuông, rộng hơn font thật: nút nhóm tuổi tràn ở 360
      // dù máy thật không tràn (khổ 360 kiểm tra bằng ảnh chụp).
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final repo = _Repo();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            childProfileRepositoryProvider.overrideWithValue(repo),
            authControllerProvider.overrideWith(_SignedIn.new),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ChildProfileScreen(childId: 1),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // avatar-default hiện là ếch như web.
      expect(find.text('🐸'), findsWidgets);

      await tester.tap(find.byTooltip('Sửa thông tin'));
      await tester.pumpAndSettle();

      expect(find.byType(TtChildAvatar), findsWidgets);
      // Chưa đổi gì thì chưa có nút Lưu.
      expect(find.text('Lưu'), findsNothing);

      await tester.ensureVisible(find.byKey(const ValueKey('avatar-fox')));
      await tester.tap(find.byKey(const ValueKey('avatar-fox')));
      await tester.pumpAndSettle();

      expect(find.text('Lưu'), findsOneWidget);
      await tester.ensureVisible(find.text('Lưu'));
      await tester.tap(find.text('Lưu'));
      await tester.pumpAndSettle();

      expect(repo.updateCalls, 1);
      expect(repo.savedAvatarId, 'avatar-fox');
      expect(tester.takeException(), isNull);
    },
  );
}
