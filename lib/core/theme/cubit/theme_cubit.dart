// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:fluttertuner/core/theme/cubit/theme_state.dart';
import 'package:fluttertuner/feature/settings/repository/theme_repository.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeRepositoryImp themeRepository})
      : _themeRepository = themeRepository,
        super(ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final ThemeRepositoryImp _themeRepository;

  Future<void> setThemeCubit(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _themeRepository.selectedDarkorLight(
      brightness == Brightness.dark,
    );
  }

  Future<void> _checkSelectedTheme() async{
    try {
      final brightness =
          await _themeRepository.isDarkTheme() ? Brightness.dark : Brightness.light;
      emit(ThemeState(brightness));
    } catch (e) {
      log(e.toString());
    }
  }
}
