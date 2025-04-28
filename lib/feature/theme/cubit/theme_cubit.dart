// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertuner/feature/theme/cubit/theme_state.dart';
import 'package:fluttertuner/feature/theme/repository/theme_repository_interface.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeRepository themeRepository})
      : _themeRepository = themeRepository,
        super(const ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final ThemeRepository _themeRepository;

  Future<void> setThemeCubit(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _themeRepository.selectedDarkorLight(
      brightness == Brightness.dark,
    );
  }

  Future<void> _checkSelectedTheme() async {
    try {
      final brightness = await _themeRepository.isDarkTheme()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeState(brightness));
    } catch (e) {
      log(e.toString());
    }
  }
}
