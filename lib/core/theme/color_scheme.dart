import 'package:flutter/material.dart';

abstract final class AppColorScheme {
  static const Color primary = Colors.black;
  static const Color background = Colors.white; //фон
  static const Color textwhile = Colors.white;
  static const Color textgrey = Colors.grey;
  static const Color surfaceVariant = Colors.grey;

  static ColorScheme get light => const ColorScheme.light(
        primary: primary, //с
        surface: Colors.white, //нижняя панель
        onPrimary: Colors.white,
        surfaceVariant: surfaceVariant,
      );
}
