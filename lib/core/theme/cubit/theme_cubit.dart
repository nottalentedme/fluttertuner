import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/core/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void toggleTheme() {
    if (state == AppTheme.darkTheme) {
      emit(AppTheme.lightTheme);
    } else {
      emit(AppTheme.darkTheme);
    }
  }
}
