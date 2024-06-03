import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:world_countries/world_countries.dart';

class Idioma {
  static final List<NaturalLanguage> _locales = AppLocalizations
      .supportedLocales // [Locale('en'), Locale('es')]
      .map((locale) =>
          NaturalLanguage.fromCodeShort(locale.languageCode.toUpperCase()))
      .toList();

  static List<NaturalLanguage> get locales => Idioma._locales;
}
