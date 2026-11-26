import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/access/data/child_access_repository.dart';
import 'package:ai_storytelling_mobile/features/access/presentation/child_access_screen.dart';
import 'package:ai_storytelling_mobile/models/child_access_credential_dto.dart';

import '../../support/ipad_sizes.dart';

class FakeChildAccessRepository implements ChildAccessRepository {
  FakeChildAccessRepository({this.secret, this.hasCode = true});

  String? secret;
  bool hasCode;
  int generateCalls = 0;
  int revokeCalls = 0;

  @override
  Future<ChildAccessCredentialDto> fetchCredential(int id) async {
    if (!hasCode) {
      throw ApiException(statusCode: 404, message: 'Không tìm thấy');
    }
    return ChildAccessCredentialDto(
      childProfileId: id,
      hasEasyLogin: true,
      easyLoginCreatedAt: DateTime(2026, 11, 15, 9, 5),
      secret: secret,
    );
  }

  @override
  Future<EasyLoginSecretDto> generateEasyLogin(int id) async {
    generateCalls++;
    hasCode = true;
    secret = 'new-secret';
    return EasyLoginSecretDto(secret: 'new-secret', createdAt: DateTime.now());
  }

  @override
  Future<void> revokeCredential(int id) async {
    revokeCalls++;
    hasCode = false;
    secret = null;
  }
}

Future<void> pumpScreen(
  WidgetTester tester,
  FakeChildAccessRepository repo, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [childAccessRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: theme ?? AppTheme.light(),
        home: const ChildAccessScreen(childId: 1),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('ChildAccessScreen', () {
    testWidgets('Có mã thì hiện QrImageView và thời gian tạo', (tester) async {
      await pumpScreen(tester, FakeChildAccessRepository(secret: 'abc'));

      expect(find.byType(QrImageView), findsOneWidget);
      expect(find.text('Tạo lúc 15/11/2026 09:05'), findsOneWidget);
      expect(find.text('Tạo mã mới'), findsOneWidget);
      expect(find.text('Thu hồi'), findsOneWidget);
    });

    testWidgets('Chưa có mã thì hiện nút "Tạo mã QR", bấm thì hiện QR', (
      tester,
    ) async {
      final repo = FakeChildAccessRepository(hasCode: false);
      await pumpScreen(tester, repo);

      expect(find.byType(QrImageView), findsNothing);
      expect(find.text('Tạo mã QR'), findsOneWidget);

      await tester.tap(find.text('Tạo mã QR'));
      await tester.pumpAndSettle();

      expect(repo.generateCalls, 1);
      expect(find.byType(QrImageView), findsOneWidget);
    });

    testWidgets('Có mã cũ không xem lại được thì không hiện QR', (
      tester,
    ) async {
      await pumpScreen(tester, FakeChildAccessRepository());

      expect(find.byType(QrImageView), findsNothing);
      expect(find.text('Tạo mã mới'), findsOneWidget);
    });

    testWidgets('Thu hồi qua popup xác nhận rồi về trạng thái chưa có mã', (
      tester,
    ) async {
      final repo = FakeChildAccessRepository(secret: 'abc');
      await pumpScreen(tester, repo);

      await tester.tap(find.text('Thu hồi'));
      await tester.pumpAndSettle();
      expect(repo.revokeCalls, 0);

      await tester.tap(find.text('Thu hồi').last);
      await tester.pumpAndSettle();

      expect(repo.revokeCalls, 1);
      expect(find.byType(QrImageView), findsNothing);
      expect(find.text('Tạo mã QR'), findsOneWidget);
    });

    testWidgets('Không overflow ở 320x640 và 1024x768 (sáng và tối)', (
      tester,
    ) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.view.devicePixelRatio = 1.0;

      for (final size in const [Size(320, 640), Size(1024, 768)]) {
        tester.view.physicalSize = size;
        for (final theme in [AppTheme.light(), AppTheme.dark()]) {
          await pumpScreen(
            tester,
            FakeChildAccessRepository(secret: 'abc'),
            theme: theme,
          );
          expect(tester.takeException(), isNull);
          await pumpScreen(
            tester,
            FakeChildAccessRepository(hasCode: false),
            theme: theme,
          );
          expect(tester.takeException(), isNull);
        }
      }
    });
  });

  group('iPad không tràn', () {
    for (final entry in kIpadSizes.entries) {
      testWidgets('${entry.key}: không tràn', (tester) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await pumpScreen(tester, FakeChildAccessRepository(secret: 'abc'));
        expect(tester.takeException(), isNull);
      });
    }
  });
}
