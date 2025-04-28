import 'package:flutter/material.dart';

abstract final class AppColorScheme {
  static ColorScheme get light => const ColorScheme.light(
        primary: Colors.black,
        surface: Colors.white,
        onPrimary: Colors.black,
      );
  static ColorScheme get dark => const ColorScheme.dark(
        primary: Color.fromARGB(255, 46, 46, 45),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 175, 252, 65),
        tertiary: Color.fromARGB(255, 84, 83, 83),
      );
}
