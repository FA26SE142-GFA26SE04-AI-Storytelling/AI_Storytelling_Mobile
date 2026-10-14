import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../shared/widgets/frog.dart';

/// Khung chung cho các tab khu người lớn: AppBar có logo ếch và nền mặt nước.
class TtPage extends StatelessWidget {
  const TtPage({super.key, required this.title, required this.body, this.actions = const [], this.showLogo = false});

  final String title;
  final Widget body;
  final List<Widget> actions;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: c.water),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          titleSpacing: showLogo ? 4 : null,
          leading: showLogo
              ? const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Center(child: Frog(size: 44, variant: FrogVariant.face)),
                )
              : null,
          title: Text(title),
          actions: [...actions, const SizedBox(width: 4)],
        ),
        body: body,
      ),
    );
  }
}
