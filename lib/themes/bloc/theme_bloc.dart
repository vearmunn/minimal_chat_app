import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleTheme>((event, emit) async {
      final newTheme =
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', newTheme == ThemeMode.dark);
      emit(ThemeState(themeMode: newTheme));
    });
    on<LoadTheme>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
    });
  }
}
