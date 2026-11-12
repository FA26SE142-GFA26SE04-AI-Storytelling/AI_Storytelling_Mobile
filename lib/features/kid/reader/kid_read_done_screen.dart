import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/reading_start_dto.dart';
import '../home/kid_home_providers.dart';

/// Màn hình chúc mừng sau khi bé hoàn thành lượt đọc truyện.
class KidReadDoneScreen extends ConsumerWidget {
  const KidReadDoneScreen({
    super.key,
    required this.completed,
  });

  /// Thông tin kết quả phiên đọc vừa hoàn tất.
  final ReadingCompletedDto completed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TtFrog(
                  mood: TtFrogMood.happy,
                  size: 160,
                ),
                const SizedBox(height: 16),
                Text(
                  'Em đọc xong rồi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                ),
                if (completed.isRetake) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Em đọc lại truyện này rồi nhé.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                  ),
                ] else if (completed.expGained > 0) ...[
                  const SizedBox(height: 16),
                  Text(
                    '+${completed.expGained} EXP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: tt.gold,
                    ),
                  ),
                ],
                if (completed.newBadges.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Em vừa mở được huy hiệu mới!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: tt.text,
                    ),
                  ),
                ],
                if (completed.roadmapStepCompleted) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Bước tiếp theo trong hành trình đã mở!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: tt.text,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  height: 64,
                  child: TtButton(
                    label: 'Về trang của em',
                    icon: Icons.home_rounded,
                    expanded: true,
                    onPressed: () {
                      ref.invalidate(kidHomeDataProvider);
                      context.go('/kid');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
