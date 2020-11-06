part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final SettingsData data;

  const SettingsState(this.data);

  @override
  List<Object> get props => [data.lightOn, data.theme, data.locale];

  @override
  String toString() => 'SettingState { data: $data }';
}

class SettingsInitial extends SettingsState {
  SettingsInitial(SettingsData data) : super(data);

  @override
  String toString() => 'SettingInitialState { data: $data }';
}

class SettingsThemeChange extends SettingsState {
  SettingsThemeChange(SettingsData data) : super(data);

  @override
  String toString() => 'SettingsThemeChange { data: $data }';
}

class SettingsLocaleChange extends SettingsState {
  SettingsLocaleChange(SettingsData data) : super(data);

  @override
  String toString() => 'SettingsLocaleChange { data: $data }';
}
