import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/child_reading_dto.dart';

/// Màn hình hoàn thành bài đọc truyện cho bé.
class KidReaderCompleteView extends StatelessWidget {
  const KidReaderCompleteView({
    super.key,
    required this.result,
    required this.onHome,
  });

  /// Kết quả đọc truyện trả về từ phiên đọc.
  final ReadingCompleted result;

  /// Callback chuyển về màn hình chính.
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Linh vật ếch trạng thái happy ở giữa kèm animation scale/fade nhẹ
                const TtFrog(
                  mood: TtFrogMood.happy,
                  size: 140,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.85, 0.85),
                      end: const Offset(1, 1),
                      duration: 400.ms,
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 24),

                // Tiêu đề nổi bật phông Baloo 2
                Text(
                  'Em đọc xong rồi!',
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                const SizedBox(height: 16),

                // Trường hợp đọc lại hoặc nhận EXP
                if (result.isRetake)
                  Text(
                    'Em đọc lại truyện này rồi',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 400.ms, delay: 150.ms)
                else if (result.expGained > 0)
                  TtCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.stars_rounded, color: tt.goldDeep, size: 26),
                        const SizedBox(width: 8),
                        Text(
                          '+${result.expGained} EXP',
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: tt.warnInk,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 200.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1, 1),
                        duration: 400.ms,
                      ),

                // Khối huy hiệu mới đạt được
                if (result.newBadges.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  TtCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.military_tech_rounded,
                          color: tt.gold,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Em mở được ${result.newBadges.length} huy hiệu mới',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: tt.text,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: 250.ms),
                ],

                const SizedBox(height: 32),

                // Nút duy nhất về trang chính
                TtButton(
                  label: 'Về trang chính',
                  icon: Icons.home_rounded,
                  onPressed: onHome,
                ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
