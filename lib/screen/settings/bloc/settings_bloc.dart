import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flatter_playground/config/theme.dart';
import 'package:flatter_playground/lang/l10n.dart';
import 'package:flatter_playground/screen/settings/bloc/settings_state_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial(SettingsData.initial()));

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    final currentState = state;

    if (event is SettingsThemeChanged) {
      yield* _mapSettingsThemeChangedToState(event, currentState);
    }
    if (event is SettingsLocaleChanged) {
      yield* _mapSettingsLocaleChangedToState(event, currentState);
    }
  }

  Stream<SettingsState> _mapSettingsThemeChangedToState(
    SettingsThemeChanged change,
    SettingsState currentState,
  ) async* {
    SettingsData data = currentState.data.clone();
    data.lightOn = change.lightOn;
    data.theme = change.lightOn ? lightTheme : darkTheme;

    yield SettingsThemeChange(data);
  }

  Stream<SettingsState> _mapSettingsLocaleChangedToState(
    SettingsLocaleChanged change,
    SettingsState currentState,
  ) async* {
    SettingsData data = currentState.data.clone();
    data.locale = change.locale;

    L10n.load(Locale(data.locale, ''));

    yield SettingsLocaleChange(data);
  }
}
