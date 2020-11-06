import 'package:flutter/material.dart';

import 'l10n.dart';

class L10nDelegate extends LocalizationsDelegate<L10n> {
  const L10nDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['us', 'ru', 'ua', 'en'].contains(locale.languageCode);

  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<L10n> old) => false;
}
