import 'package:flatter_playground/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsData {
  static const defaultLocale = "en";

  final List<_LangItem> languages = [
    _LangItem(0, 'en', 'gb', 'English (UK)'),
    _LangItem(1, 'us', 'us', 'English'),
    _LangItem(2, 'ua', 'ua', 'Українська'),
    _LangItem(3, 'ru', 'ru', 'Русский'),
  ];

  _LangItem get selectedLanguage {
    return languages.firstWhere((item) => item.key == locale);
  }

  _LangItem languageByIndex(int index) {
    return languages.firstWhere((item) => item.index == index);
  }

  ThemeData theme;
  bool lightOn;
  String locale;

  SettingsData({
    @required this.lightOn,
    @required this.theme,
    @required this.locale,
  })  : assert(lightOn != null),
        assert(theme != null),
        assert(locale != null);

  SettingsData.initial()
      : theme = lightTheme,
        lightOn = true,
        locale = Intl.defaultLocale ?? defaultLocale;

  @override
  String toString() {
    return "Theme: ${theme.brightness}, lightOn: $lightOn, locale: $locale";
  }

  SettingsData clone() {
    return SettingsData(
      lightOn: this.lightOn,
      theme: this.theme,
      locale: this.locale,
    );
  }
}

class _LangItem {
  final index;
  final key;
  final flag;
  final title;

  const _LangItem(this.index, this.key, this.flag, this.title);
}
