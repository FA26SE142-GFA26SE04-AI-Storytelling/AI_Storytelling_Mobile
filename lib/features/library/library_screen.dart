import 'package:material_ui/material_ui.dart';

import '../../shared/widgets/feedback.dart';
import '../shell/tt_page.dart';

/// Thư viện truyện. Tìm kiếm, chip lọc và lưới truyện làm ở P1.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) => const TtPage(
    title: 'Thư viện truyện',
    body: EmptyState(title: 'Thư viện của bé', message: 'Truyện đã tạo cho bé sẽ hiện ở đây.'),
  );
}
