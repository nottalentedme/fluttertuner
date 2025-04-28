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
      customBorder: const RoundedRectangleBorder(),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(width: 2),
          color: isActive ? theme.surface : theme.primary,
          borderRadius: BorderRadius.circular(
              16), // Добавьте эту строку для скругления углов
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: isActive ? theme.primary : theme.surface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
