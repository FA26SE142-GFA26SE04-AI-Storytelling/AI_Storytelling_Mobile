import 'package:material_ui/material_ui.dart';

import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/frog.dart';
import '../shell/tt_page.dart';

/// Hàng chờ duyệt. Danh sách và màn duyệt chi tiết làm ở P3.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) => const TtPage(
    title: 'Duyệt nội dung',
    body: EmptyState(title: 'Đã xử lý hết hàng chờ', message: 'Truyện mới sẽ xuất hiện ở đây khi AI viết xong và chờ bạn duyệt.', mood: FrogMood.happy),
  );
}
