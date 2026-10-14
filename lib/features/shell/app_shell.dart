import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../shared/widgets/tt_button.dart';
import '../workspace/workspace_providers.dart';

/// Kích thước màn hình (DESIGN.md › breakpoints).
enum WindowSize {
  compact,
  medium,
  expanded;

  static WindowSize of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= 840 ? expanded : (w >= 600 ? medium : compact);
  }
}

class _Tab {
  const _Tab(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Thứ tự trùng với các nhánh trong router: Trang chủ, Thư viện, Duyệt, Bé.
const _tabs = [
  _Tab('Trang chủ', Icons.home_outlined, Icons.home_rounded),
  _Tab('Thư viện', Icons.auto_stories_outlined, Icons.auto_stories_rounded),
  _Tab('Duyệt', Icons.inbox_outlined, Icons.inbox_rounded),
  _Tab('Bé', Icons.face_outlined, Icons.face_rounded),
];

/// Khung khu người lớn: thanh đáy trên điện thoại, NavigationRail trên máy tính bảng.
/// "Tạo truyện" không phải một tab mà mở Studio toàn màn hình.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _goBranch(int branch) => shell.goBranch(branch, initialLocation: branch == shell.currentIndex);

  void _openStudio(BuildContext context) => context.push('/studio');

  /// Tab Duyệt (vị trí 2 trong _tabs) có badge số truyện chờ duyệt.
  static Widget _icon(int tab, IconData icon, int pending) {
    if (tab != 2 || pending == 0) return Icon(icon);
    return Badge(label: Text('$pending'), child: Icon(icon));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(reviewQueueProvider).length;
    final size = WindowSize.of(context);
    if (size == WindowSize.compact) return _bottomBar(context, pending);
    return _rail(context, pending, extended: size == WindowSize.expanded);
  }

  Widget _bottomBar(BuildContext context, int pending) {
    // Nút "Tạo" nằm giữa thanh đáy: vị trí 2 trên thanh, các tab sau nó lùi một bậc.
    const createSlot = 2;
    final selected = shell.currentIndex < createSlot ? shell.currentIndex : shell.currentIndex + 1;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (i) {
          if (i == createSlot) return _openStudio(context);
          _goBranch(i < createSlot ? i : i - 1);
        },
        destinations: [
          for (final (i, t) in _tabs.indexed) ...[
            if (i == createSlot)
              const NavigationDestination(
                // Chiếm 24dp như icon thường để nhãn thẳng hàng, phần lá tràn ra ngoài khi vẽ.
                icon: SizedBox(height: 24, child: OverflowBox(maxHeight: 34, child: _CreateIcon())),
                label: 'Tạo truyện',
                tooltip: 'Tạo truyện mới',
              ),
            NavigationDestination(icon: _icon(i, t.icon, pending), selectedIcon: _icon(i, t.selectedIcon, pending), label: t.label),
          ],
        ],
      ),
    );
  }

  Widget _rail(BuildContext context, int pending, {required bool extended}) {
    final c = context.tt;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            minExtendedWidth: 220,
            selectedIndex: shell.currentIndex,
            onDestinationSelected: _goBranch,
            labelType: extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
            groupAlignment: -1,
            leading: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: extended
                  ? TtButton(label: 'Tạo truyện', icon: Icons.auto_awesome_rounded, onPressed: () => _openStudio(context))
                  : Tooltip(
                      message: 'Tạo truyện mới',
                      child: InkWell(
                        borderRadius: TtRadius.leaf,
                        onTap: () => _openStudio(context),
                        child: const Padding(padding: EdgeInsets.all(4), child: _CreateIcon(width: 56, height: 44)),
                      ),
                    ),
            ),
            destinations: [
              for (final (i, t) in _tabs.indexed)
                NavigationRailDestination(icon: _icon(i, t.icon, pending), selectedIcon: _icon(i, t.selectedIcon, pending), label: Text(t.label)),
            ],
          ),
          VerticalDivider(width: 1, color: c.line),
          Expanded(child: shell),
        ],
      ),
    );
  }
}

/// Nút tạo truyện ở giữa thanh đáy: lá xanh đậm có dấu lấp lánh.
class _CreateIcon extends StatelessWidget {
  const _CreateIcon({this.width = 48, this.height = 34});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: c.primaryStrong,
        borderRadius: TtRadius.leaf,
        boxShadow: [BoxShadow(color: c.primary.withValues(alpha: 0.45), blurRadius: 12, offset: const Offset(0, 4), spreadRadius: -4)],
      ),
      child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
    );
  }
}
