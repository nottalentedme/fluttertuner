import 'package:flutter/material.dart';

class StringButtonWidget extends StatelessWidget {
  const StringButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  final String text;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2),
          color: isActive ? theme.onPrimary : theme.primary,
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: isActive ? theme.primary : theme.onPrimary,
          ),
        ),
      ),
    );
  }
}
