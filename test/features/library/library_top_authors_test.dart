import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_storytelling_mobile/core/theme/app_theme.dart';
import 'package:ai_storytelling_mobile/features/library/data/library_logic.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_body.dart';
import 'package:ai_storytelling_mobile/features/library/presentation/library_providers.dart';
import 'package:ai_storytelling_mobile/models/library_story_dto.dart';

LibraryStoryDto _story(int id, {int? user, String? author}) => LibraryStoryDto(
  id: id,
  title: 'Truyện $id',
  status: 'Ready',
  isPublished: true,
  createdAt: DateTime(2026, 1, id),
  authorUserId: user,
  authorName: author,
);

Future<void> _pump(
  WidgetTester tester,
  List<LibraryStoryDto> community, {
  double width = 412,
  double scale = 1,
  ThemeData? theme,
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final data = LibraryData(
    shelves: LibraryShelves(mergeLibrary(const [], community)),
    mostViewed: const [],
    mostFavorited: const [],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [libraryProvider.overrideWith((ref) async => data)],
      child: MaterialApp(
        theme: theme ?? AppTheme.light(),
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(scale)),
            child: const Scaffold(
              body: CustomScrollView(slivers: [LibraryBody()]),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'có tác giả: hiện hàng, tên, số truyện; bấm mở lưới truyện của tác giả',
    (tester) async {
      await _pump(tester, [
        _story(1, user: 5, author: 'Cô Lan'),
        _story(2, user: 5, author: 'Cô Lan'),
        _story(3, user: 9, author: 'Bác Tư'),
      ]);
      expect(find.text('Tác giả nổi bật'), findsOneWidget);
      expect(find.text('Cô Lan'), findsOneWidget);
      expect(find.text('2 truyện'), findsOneWidget);
      expect(find.text('1 truyện'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Xem truyện của tác giả Cô Lan'));
      await tester.pumpAndSettle();
      expect(find.text('Tác giả: Cô Lan'), findsOneWidget);
      expect(find.text('Truyện 2'), findsOneWidget);
      expect(find.text('Truyện 1'), findsOneWidget);
      expect(find.text('Truyện 3'), findsNothing);

      await tester.tap(find.byTooltip('Quay lại thư viện'));
      await tester.pumpAndSettle();
      expect(find.text('Tác giả nổi bật'), findsOneWidget);
    },
  );

  testWidgets('không có tác giả (thiếu id / tên) thì không hiện hàng', (
    tester,
  ) async {
    await _pump(tester, [_story(1, author: 'Cô Lan'), _story(2, user: 3)]);
    expect(find.text('Tác giả nổi bật'), findsNothing);
  });

  for (final width in [360.0, 412.0]) {
    testWidgets('tên rất dài không tràn ($width, chữ 1.3)', (tester) async {
      await _pump(
        tester,
        [
          for (var i = 1; i <= 8; i++)
            _story(
              i,
              user: i,
              author: 'Nguyễn Thị Thanh Hương Nguyễn Thị Thanh Hương $i',
            ),
        ],
        width: width,
        scale: 1.3,
        theme: AppTheme.dark(),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('Tác giả nổi bật'), findsOneWidget);
    });
  }
}
