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
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2),
            color: isActive ? Colors.white : Colors.black),
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 25, color: isActive ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
