import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/frog.dart';
import '../auth/auth_controller.dart';
import '../shell/tt_page.dart';

/// Trang chủ. Nội dung (thẻ "Cho bé đọc", chỉ số, việc cần làm) làm ở P1.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    return TtPage(
      title: 'Taletale',
      showLogo: true,
      body: EmptyState(title: 'Chào ${user?.givenName ?? 'bạn'}', message: 'Tổng quan về truyện của bé sẽ hiện ở đây.', mood: FrogMood.happy),
    );
  }
}
