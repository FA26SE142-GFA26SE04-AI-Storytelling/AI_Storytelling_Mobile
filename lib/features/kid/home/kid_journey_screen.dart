import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_state_views.dart';
import 'kid_home_providers.dart';
import 'kid_roadmap_strip.dart';

/// Hành trình đọc của bé (route /kid/journey), mở từ nút "Hành trình" trên sảnh.
class KidJourneyScreen extends ConsumerWidget {
  const KidJourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final dataAsync = ref.watch(kidHomeDataProvider);

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TtButton(
                  label: 'Quay lại',
                  icon: Icons.arrow_back_rounded,
                  variant: TtButtonVariant.secondary,
                  onPressed: () =>
                      context.canPop() ? context.pop() : context.go('/kid'),
                ),
              ),
            ),
            Expanded(
              child: dataAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: TtErrorState(
                    title: 'Chưa mở được hành trình',
                    message: error is ApiException
                        ? error.message
                        : 'Có lỗi xảy ra. Vui lòng thử lại.',
                    onRetry: () => ref.invalidate(kidHomeDataProvider),
                  ),
                ),
                data: (data) {
                  final r = data.roadmap;
                  if (r.done.isEmpty && r.open == null && r.upcoming.isEmpty) {
                    return const Center(
                      child: TtEmptyState(
                        icon: Icons.map_rounded,
                        title: 'Bố mẹ chưa chọn truyện cho em',
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: KidRoadmapStrip(
                          roadmap: r,
                          onRead: (id) => context.push('/kid/read/$id'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
