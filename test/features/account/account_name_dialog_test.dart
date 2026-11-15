import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';
import 'package:ai_storytelling_mobile/features/account/presentation/account_name_dialog.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';
import 'package:ai_storytelling_mobile/models/audit_log_entry_dto.dart';
import 'package:ai_storytelling_mobile/models/login_session_dto.dart';

// ─── Fake Repository ────────────────────────────────────────────────────────

class FakeAccountRepository implements AccountRepository {
  @override
  Future<void> updateProfile({
    required String fullName,
    String? avatarUrl,
  }) async {}

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) =>
      throw UnimplementedError();

  @override
  Future<void> requestEmailChange({
    required String currentPassword,
    required String newEmail,
  }) =>
      throw UnimplementedError();

  @override
  Future<void> confirmEmailChange(String otp) => throw UnimplementedError();

  @override
  Future<List<LoginSessionDto>> listSessions() => throw UnimplementedError();

  @override
  Future<void> revokeSession(int id) => throw UnimplementedError();

  @override
  Future<void> logoutAllDevices() => throw UnimplementedError();

  @override
  Future<({List<AuditLogEntryDto> items, int totalPages})> accountAudit({
    int pageIndex = 0,
  }) =>
      throw UnimplementedError();
}

// ─── Test Harness ───────────────────────────────────────────────────────────

class _TestHarness extends ConsumerWidget {
  final UserProfile user;

  const _TestHarness({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => showEditNameDialog(context, ref, user),
      child: const Text('Mở popup'),
    );
  }
}

Widget _buildTestWidget({
  required UserProfile user,
  AccountRepository? repository,
}) {
  return ProviderScope(
    overrides: [
      accountRepositoryProvider.overrideWithValue(
        repository ?? FakeAccountRepository(),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: Center(
          child: _TestHarness(user: user),
        ),
      ),
    ),
  );
}

void main() {
  const testUser = UserProfile(
    id: 1,
    username: 'nguyenan',
    email: 'nguyenan@example.com',
    fullName: 'Nguyễn An',
    role: 'Parent',
    status: 'Active',
  );

  testWidgets(
    'Mở popup bằng ElevatedButton: user.fullName = Nguyễn An, hiện ô nhập và nút Lưu KHÔNG hiển thị',
    (tester) async {
      await tester.pumpWidget(_buildTestWidget(user: testUser));
      await tester.tap(find.text('Mở popup'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Kiểm tra ô nhập có giá trị 'Nguyễn An'
      expect(find.text('Nguyễn An'), findsOneWidget);

      // Kiểm tra nút "Lưu" không hiển thị theo yêu cầu
      expect(find.text('Lưu'), findsNothing);
    },
  );

  testWidgets(
    'Gõ thêm ký tự vào ô -> nút Lưu hiện. Xoá về đúng Nguyễn An -> nút Lưu lại ẩn',
    (tester) async {
      await tester.pumpWidget(_buildTestWidget(user: testUser));
      await tester.tap(find.text('Mở popup'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      // Gõ thêm ký tự vào ô
      await tester.enterText(textField, 'Nguyễn An Mới');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Nút "Lưu" hiện
      expect(find.text('Lưu'), findsOneWidget);

      // Xoá về đúng 'Nguyễn An'
      await tester.enterText(textField, 'Nguyễn An');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Nút "Lưu" lại ẩn
      expect(find.text('Lưu'), findsNothing);
    },
  );
}
