import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';

class ChangeBPMWidget extends StatelessWidget {
  const ChangeBPMWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final Icon icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorScheme.primary,
              border: Border.all(
                width: 2,
                color: AppColorScheme.primary,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: icon));
  }
}
