import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  get themeMode => state;

  void toggleTheme(bool isDark) {
    isDark ? emit(ThemeMode.dark) : emit(ThemeMode.light);
  }
}
