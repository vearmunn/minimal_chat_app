part of 'theme_bloc.dart';

sealed class ThemeEvent {}

final class ToggleTheme extends ThemeEvent {}

final class LoadTheme extends ThemeEvent {}
