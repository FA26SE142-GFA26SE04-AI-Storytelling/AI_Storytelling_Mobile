import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';

class KidInteractionTopBar extends StatelessWidget {
  const KidInteractionTopBar({
    super.key,
    required this.typeLabel,
    required this.onClose,
  });

  final String typeLabel;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Semantics(
              label: 'Để sau',
              child: IconButton(
                icon: const Icon(Icons.close_rounded, size: 32),
                tooltip: 'Để sau',
                onPressed: onClose,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: tt.gold.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tt.goldDeep.withValues(alpha: 0.3)),
            ),
            child: Text(
              typeLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: tt.goldDeep,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
