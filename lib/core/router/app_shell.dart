import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/tt_colors.dart';

// ---------------------------------------------------------------------------
// AppShell — khung điều hướng chính (bottom nav trên mobile, rail trên tablet)
// ---------------------------------------------------------------------------
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  // Chuyển tab và giữ lại vị trí cuộn khi nhấn lại tab đang chọn
  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    // Danh sách mục điều hướng
    const destinations = _destinations;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Tablet / desktop: dùng NavigationRail ở cạnh trái
        if (constraints.maxWidth >= 600) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: navigationShell.currentIndex,
                  indicatorColor: tt.primary.withValues(alpha: 0.2),
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: _onTap,
                  destinations: destinations
                      .map(
                        (d) => NavigationRailDestination(
                          icon: Icon(d.icon),
                          selectedIcon: Icon(d.selectedIcon),
                          label: Text(d.label),
                        ),
                      )
                      .toList(),
                ),
                const VerticalDivider(width: 1),
                // Nội dung từng tab
                Expanded(child: navigationShell),
              ],
            ),
          );
        }

        // Mobile: dùng NavigationBar ở dưới màn hình
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            indicatorColor: tt.primary.withValues(alpha: 0.2),
            onDestinationSelected: _onTap,
            destinations: destinations
                .map(
                  (d) => NavigationDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: d.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Dữ liệu mục điều hướng — tách riêng cho dễ bảo trì
// ---------------------------------------------------------------------------
class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const _destinations = [
  _NavItem(
    label: 'Trang chủ',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
  ),
  _NavItem(
    label: 'Thư viện',
    icon: Icons.auto_stories_outlined,
    selectedIcon: Icons.auto_stories_rounded,
  ),
  _NavItem(
    label: 'Tạo',
    icon: Icons.add_circle_outline_rounded,
    selectedIcon: Icons.add_circle_rounded,
  ),
  _NavItem(
    label: 'Bé',
    icon: Icons.child_care_outlined,
    selectedIcon: Icons.child_care_rounded,
  ),
  _NavItem(
    label: 'Tài khoản',
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
  ),
];
