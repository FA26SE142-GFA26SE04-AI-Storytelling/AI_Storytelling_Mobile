import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/pond_backdrop.dart';

/// Studio tạo truyện, mở toàn màn hình (không có thanh đáy). Wizard 5 bước làm ở P3.
class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: context.tt.water),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(tooltip: 'Đóng', icon: const Icon(Icons.close_rounded), onPressed: () => context.pop()),
          title: const Text('Tạo truyện mới'),
        ),
        body: const Stack(
          children: [
            Positioned.fill(child: PondBackdrop()),
            EmptyState(title: 'Bắt đầu một câu chuyện mới', message: 'Nhập ý tưởng, AI sẽ kiểm tra an toàn, viết dàn ý cho bạn duyệt, rồi mới viết truyện.'),
          ],
        ),
      ),
    );
  }
}
