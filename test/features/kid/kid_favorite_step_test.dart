import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/kid/quiz/kid_favorite_step.dart';
import 'package:ai_storytelling_mobile/features/kid/quiz/kid_scene_grid.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(ChildStoryReflection? r) => ProviderScope(
  child: MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      body: KidFavoriteStep(
        sessionId: 1,
        pickedTile: const KidSceneTile(sceneId: 1, number: 1),
        canRecord: false, // không dựng KidVoiceRecorder (cần plugin ghi âm)
        reflection: r,
        onBackToPick: () {},
        onSent: () {},
      ),
    ),
  ),
);

void main() {
  testWidgets('Đã gửi thì ẩn ô viết và nút gửi, chỉ còn "Đã gửi"', (
    tester,
  ) async {
    await tester.pumpWidget(_app(null));
    // Nút to in hoa nhãn.
    expect(find.text('GỬI BỐ MẸ'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Suy ngẫm tải xong sau khi trang đã dựng.
    await tester.pumpWidget(
      _app(const ChildStoryReflection(sessionId: 1, noteText: 'Con mèo')),
    );
    await tester.pump();
    expect(find.text('Đã gửi cho bố mẹ'), findsOneWidget);
    expect(find.text('GỬI BỐ MẸ'), findsNothing);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('Đã gửi ghi âm thì báo "Đã gửi lời kể"', (tester) async {
    await tester.pumpWidget(
      _app(const ChildStoryReflection(sessionId: 1, hasNoteRecording: true)),
    );
    expect(find.text('Đã gửi lời kể cho bố mẹ'), findsOneWidget);
    expect(find.text('GỬI BỐ MẸ'), findsNothing);
  });
}
