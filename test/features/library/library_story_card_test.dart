import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_shelf.dart';
import 'package:ai_storytelling_mobile/models/library_story_dto.dart';

LibraryStoryDto _story(
  int id, {
  String title = 'Mèo con',
  bool? hasQuiz,
  String? author = 'Cô Lan',
  int? views,
}) => LibraryStoryDto(
  id: id,
  title: title,
  genre: 'Phiêu lưu',
  ageBand: 'Age_9_10',
  source: 'AiGenerated',
  status: 'Ready',
  isPublished: true,
  authorName: author,
  content: List.filled(1234, 'chữ').join(' '),
  viewCount: views,
  favoriteCount: views == null ? null : 3,
  hasQuiz: hasQuiz,
);

Future<void> _pump(
  WidgetTester tester,
  List<LibraryStoryDto> items, {
  double width = 360,
  double scale = 1,
  bool grid = false,
  ThemeData? theme,
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      theme: theme ?? AppTheme.light(),
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                LibraryShelf(title: 'Kệ', items: items, grid: grid),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('icon câu đố chỉ hiện khi hasQuiz == true; không hiện tác giả, số chữ', (
    tester,
  ) async {
    await _pump(tester, [
      _story(1, title: 'Có quiz', hasQuiz: true),
      _story(2, title: 'Không rõ'),
      _story(3, title: 'Không quiz', hasQuiz: false),
    ]);
    expect(find.byKey(const ValueKey('lib-card-quiz')), findsOneWidget);
    expect(find.byTooltip('Có câu đố sau khi đọc'), findsOneWidget);
    expect(find.text('Cô Lan'), findsNothing);
    expect(find.text('1.234 chữ'), findsNothing);
    expect(find.text('9–10 tuổi'), findsNWidgets(3));
  });

  testWidgets('có lượt thì hiện huy hiệu', (tester) async {
    await _pump(tester, [_story(1, views: 1500)]);
    expect(find.text('1.500'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
  });

  for (final grid in [false, true]) {
    for (final width in [360.0, 412.0]) {
      testWidgets(
        'tên rất dài không tràn (${grid ? 'lưới' : 'kệ ngang'}, $width, chữ 1.3)',
        (tester) async {
          final long = 'Cuộc phiêu lưu kỳ diệu của chú mèo con ở khu rừng ' * 3;
          await _pump(
            tester,
            [
              for (var i = 0; i < 4; i++)
                _story(
                  i,
                  title: long,
                  author: 'Nguyễn Thị Thanh Hương Nguyễn Thị Thanh Hương',
                  hasQuiz: true,
                  views: 123456,
                ),
            ],
            width: width,
            scale: 1.3,
            grid: grid,
            theme: AppTheme.dark(),
          );
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
