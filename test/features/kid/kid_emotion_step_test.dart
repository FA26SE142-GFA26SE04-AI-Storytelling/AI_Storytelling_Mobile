import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/features/kid/data/kid_reading_repository.dart';
import 'package:ai_storytelling_mobile/features/kid/quiz/kid_emotion_step.dart';
import 'package:ai_storytelling_mobile/models/child_reading_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Repo extends Fake implements KidReadingRepository {
  @override
  Future<ChildStoryReflection> reflectionEmotions(
    int sessionId,
    List<String> codes,
  ) async => ChildStoryReflection(sessionId: sessionId);
}

void main() {
  testWidgets(
    'Màn cha dựng lại (list initialCodes mới) không xoá cảm xúc bé đã chọn',
    (tester) async {
      late StateSetter rebuildParent;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [kidReadingRepositoryProvider.overrideWithValue(_Repo())],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  rebuildParent = setState;
                  // Như KidAfterReadingScreen: mỗi lần build tạo list mới cùng nội dung.
                  return KidEmotionStep(
                    sessionId: 1,
                    initialCodes: List<String>.of(const []),
                    onNext: () {},
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      Color? vuiColor() => tester.widget<Text>(find.text('Vui')).style?.color;
      final selected = TtColors.light.warnInk;

      await tester.tap(find.text('Vui'));
      await tester.pumpAndSettle();
      expect(vuiColor(), selected);

      rebuildParent(() {});
      await tester.pumpAndSettle();
      expect(vuiColor(), selected);
    },
  );
}
