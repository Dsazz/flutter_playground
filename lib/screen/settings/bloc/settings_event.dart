part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  List<Object> get props => [];
}

class SettingsThemeChanged extends SettingsEvent {
  final bool lightOn;

  const SettingsThemeChanged({@required this.lightOn});

  @override
  List<Object> get props => [lightOn];

  @override
  String toString() => "SettingsThemeChanged { lightOn: $lightOn }";
}

class SettingsLocaleChanged extends SettingsEvent {
  final String locale;

  const SettingsLocaleChanged({@required this.locale});

  @override
  List<Object> get props => [locale];

  @override
  String toString() => "SettingsLocaleChanged { locale: $locale }";
}
