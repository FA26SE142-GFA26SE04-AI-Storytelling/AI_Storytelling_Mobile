import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/tt_colors.dart';
import '../../events/data/event_repository.dart';
import '../../library/presentation/library_body.dart';
import '../../notifications/data/notification_repository.dart';
import '../../notifications/presentation/notification_bell.dart';
import 'account_avatar_button.dart';

/// Trang chủ phụ huynh: thanh trên (tên app, tìm, chuông, avatar) và thư viện truyện.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(BuildContext context, WidgetRef ref) {
    ref.invalidate(unreadNotificationCountProvider);
    ref.invalidate(eventListProvider);
    return refreshLibrary(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.tt.bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(context, ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Nội dung rộng tối đa 960, căn giữa trên màn rộng.
              SliverLayoutBuilder(
                builder: (context, constraints) => SliverPadding(
                  padding: const EdgeInsets.only(bottom: 16),
                  sliver: LibraryBody(
                    side: math.max(
                      16.0,
                      (constraints.crossAxisExtent - 960) / 2,
                    ),
                    trailing: const [
                      NotificationBellButton(size: 40),
                      AccountAvatarButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
