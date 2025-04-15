import 'package:flutter/material.dart';
import 'package:fluttertuner/core/theme/color_scheme.dart';
import 'package:fluttertuner/core/theme/text_theme.dart';

abstract final class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorScheme.light,
        textTheme: AppTextTheme.textTheme,
        scaffoldBackgroundColor: AppColorScheme.background,
      );
  static const SliderThemeData _sliderTheme = SliderThemeData(
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
    trackHeight: 4,
    activeTrackColor: AppColorScheme.primary,
    inactiveTrackColor: AppColorScheme.surfaceVariant, // Новый цвет нужно добавить в схему
    valueIndicatorColor: AppColorScheme.primary,
  );
}
