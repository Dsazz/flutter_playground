import 'package:flatter_playground/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class L10n {
  static Future<L10n> load(Locale locale) async {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    // Load localized messages for the current locale.
    await initializeMessages(localeName);

    // Force the locale in Intl.
    Intl.defaultLocale = localeName;

    return L10n();
  }

  static L10n of(BuildContext context) => Localizations.of<L10n>(context, L10n);

  ///
  /// Side Drawer
  ///

  String get animations => Intl.message(
        'Animations',
        name: 'animations',
        desc: 'Title for the Animation screen',
      );

  String get loaders => Intl.message(
        'Loaders',
        name: 'loaders',
        desc: 'Title for the Loader screen',
      );

  String get weather => Intl.message(
        'Weather',
        name: 'weather',
        desc: 'Title for the Weather screen',
      );

  String get settings => Intl.message(
        'Settings',
        name: 'settings',
        desc: 'Title for the Setting screen',
      );

  String get about => Intl.message(
        'About',
        name: 'about',
        desc: 'Title for the About screen',
      );

  ///
  /// ----------------------------------------
  ///

  ///
  /// Language translations
  ///
  String get ru => Intl.message(
        'Russian',
        name: 'ru',
        desc: 'Title for Russian lang',
      );

  String get ua => Intl.message(
        'Ukrainian',
        name: 'ua',
        desc: 'Title for Ukrainian lang',
      );

  String get us => Intl.message(
        'English',
        name: 'us',
        desc: 'Title for English lang',
      );

  String get en => Intl.message(
        'English (UK)',
        name: 'en',
        desc: 'Title for English (Britain) lang',
      );

  ///
  /// ----------------------------------
  ///

  String get language => Intl.message(
        'Language',
        name: 'language',
        desc: 'Title for the language settings',
      );

  String get darkMode => Intl.message(
        'Dark mode',
        name: 'darkMode',
        desc: 'Title for the Dark Mode settings',
      );

  String get on => Intl.message(
        'On',
        name: 'on',
        desc: 'Subtitle for the enabled settings',
      );

  String get off => Intl.message(
        'Off',
        name: 'off',
        desc: 'Subtitle for the disabled settings',
      );

  String lang(String key) {
    switch (key) {
      case 'us':
        return us;
      case 'gb':
        return en;
      case 'ua':
        return ua;
      case 'ru':
        return ru;
      default:
        return us;
    }
  }
}
