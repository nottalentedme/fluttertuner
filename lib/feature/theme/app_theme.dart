import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/theme/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final darkTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.montserratTextTheme(),
      colorScheme: AppColorScheme.dark);

  static final lightTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.montserratTextTheme(),
      colorScheme: AppColorScheme.light);
}
