import 'package:flutter/material.dart';

abstract final class AppColorScheme {
  static ColorScheme get light => const ColorScheme.light(
        primary: Colors.black,
        surface: Colors.white,
        onPrimary: Colors.black,
      );
  static ColorScheme get dark => const ColorScheme.dark(
        primary: Colors.white,
        surface: Colors.black,
        onPrimary: Colors.white,
      );
}
