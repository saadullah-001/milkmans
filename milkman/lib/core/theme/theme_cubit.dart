import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;

  const ThemeState({required this.mode});

  ThemeState copyWith({ThemeMode? mode}) {
    return ThemeState(mode: mode ?? this.mode);
  }

  @override
  List<Object?> get props => [mode];
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(mode: ThemeMode.system));
  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(mode: mode));
  }

  void toggleLightDark() {
    final newMode = state.mode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    emit(state.copyWith(mode: newMode));
  }
}
