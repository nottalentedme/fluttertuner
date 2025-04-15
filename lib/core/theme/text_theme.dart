import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  static TextTheme get textTheme => const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        displayLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
}
