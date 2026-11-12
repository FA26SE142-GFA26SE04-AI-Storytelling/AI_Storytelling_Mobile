import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/child_profile_dto.dart';
import '../data/child_profile_repository.dart';
import 'child_card.dart';

final childrenProvider =
    FutureProvider.autoDispose<List<ChildProfileDto>>((ref) {
  return ref.watch(childProfileRepositoryProvider).fetchMine();
});

class ChildrenTabScreen extends ConsumerWidget {
  const ChildrenTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = context.tt;
    final childrenAsync = ref.watch(childrenProvider);

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Không đặt tiêu đề trang (quy tắc dự án): thanh điều hướng đã cho biết đang ở tab Bé.
            Expanded(
              child: childrenAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (_, _) => const TtSkeleton(
                    height: 120,
                    radius: BorderRadius.all(Radius.circular(TtRadius.lg)),
                  ),
                ),
                error: (error, _) {
                  final String errorMessage = error is ApiException
                      ? error.message
                      : 'Có lỗi xảy ra. Vui lòng thử lại.';

                  return TtErrorState(
                    title: 'Chưa tải được danh sách bé',
                    message: errorMessage,
                    onRetry: () => ref.invalidate(childrenProvider),
                  );
                },
                data: (children) {
                  if (children.isEmpty) {
                    return TtEmptyState(
                      icon: Icons.child_care_rounded,
                      title: 'Chưa có hồ sơ bé',
                      message: 'Hồ sơ bé sẽ được tạo trong bản sau nhé.',
                      actionLabel: 'Tải lại',
                      onAction: () => ref.invalidate(childrenProvider),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(childrenProvider);
                      try {
                        await ref.read(childrenProvider.future);
                      } catch (_) {}
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: children.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return ChildCard(child: children[index]);
                      },
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
