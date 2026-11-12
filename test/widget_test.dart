import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_storytelling_mobile/app.dart';

void main() {
  testWidgets('Ứng dụng hiển thị màn trống với tên app', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TaleTaleApp()));
    await tester.pumpAndSettle();

    expect(find.text('Đầm Sen Kể Chuyện'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNothing);
  });
}
