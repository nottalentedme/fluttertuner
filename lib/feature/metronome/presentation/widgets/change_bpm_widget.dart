import 'package:flutter/material.dart';

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
    final theme = Theme.of(context).colorScheme;
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primary,
              border: Border.all(
                width: 2,
                color: theme.primary,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: icon));
  }
}
