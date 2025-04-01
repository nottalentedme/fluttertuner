import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';

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
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2),
            color: isActive ? AppColorScheme.textwhile : AppColorScheme.primary),
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 30, color: isActive ? AppColorScheme.primary : AppColorScheme.textwhile),
        ),
      ),
    );
  }
}
