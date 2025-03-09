import 'package:defifundr_mobile/core/themes/theme_state.dart';
import 'package:defifundr_mobile/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ThemeEvent {}

class SetThemeEvent extends ThemeEvent {
  final ThemeOptions themeOption;

  SetThemeEvent(this.themeOption);
}

class GetThemeEvent extends ThemeEvent {}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState.theme(
          themeData: AppTheme.themeOptions[ThemeOptions.light]!,
        )) {
    on<SetThemeEvent>(_onSetTheme);
    on<GetThemeEvent>(_onGetTheme);
  }

  Future<void> _onSetTheme(
      SetThemeEvent event, Emitter<ThemeState> emit) async {
    emit(
        ThemeState.theme(themeData: AppTheme.themeOptions[event.themeOption]!));
  }

  void _onGetTheme(GetThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState.theme(
        themeData: AppTheme.themeOptions[ThemeOptions.light]!));
  }

  ThemeData getTheme() {
    return AppTheme.themeOptions[ThemeOptions.light]!;
  }
}

final themeBloc = ThemeBloc();

extension ThemeBlocX on BuildContext {
  ThemeBloc get themeBloc => BlocProvider.of<ThemeBloc>(this);
  ThemeState get themeState => themeBloc.state;
}
