import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkman/core/theme/app_theme.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const ThemeState({
    required this.mode,
    required this.darkTheme,
    required this.lightTheme,
  });

  ThemeState copyWith({ThemeMode? mode}) {
    return ThemeState(
      mode: mode ?? this.mode,
      darkTheme: darkTheme,
      lightTheme: lightTheme,
    );
  }

  @override
  List<Object?> get props => [mode];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeState(
          mode: ThemeMode.system,
          darkTheme: AppTheme.dark(),
          lightTheme: AppTheme.light(),
        ),
      );

  void setThemeMode(ThemeMode mode) => emit(state.copyWith(mode: mode));

  void toggleLightDark() {
    final ThemeMode newMode = state.mode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    emit(state.copyWith(mode: newMode));
  }
}
