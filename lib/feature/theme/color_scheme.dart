import 'package:flutter/material.dart';

abstract final class AppColorScheme {
  static ColorScheme get light => const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.black,
      onTertiary: Colors.white,
      outlineVariant: Colors.black,
      tertiary: Colors.lightGreen,
      outline: Colors.black,
      inversePrimary: Colors.black,
      onPrimaryFixed: Colors.grey,
      surfaceTint: Colors.white);
  static ColorScheme get dark => const ColorScheme.dark(
        primary: Color.fromARGB(255, 46, 46, 45),
        onPrimary: Colors.white,
        onPrimaryFixed: Color.fromARGB(255, 46, 46, 45),
        secondary: Color.fromARGB(255, 175, 252, 65),
        onTertiary: Color.fromARGB(255, 175, 252, 65),
        outlineVariant: Color.fromARGB(255, 46, 46, 45),
        tertiary: Color.fromARGB(255, 175, 252, 65),
        outline: Color.fromARGB(255, 46, 46, 45),
        inversePrimary: Colors.black,
        surfaceTint: Color.fromARGB(255, 175, 252, 65),
      );
}
