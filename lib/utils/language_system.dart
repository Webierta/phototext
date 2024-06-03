import 'package:intl/find_locale.dart';
import 'package:world_countries/world_countries.dart';

class LanguageSystem {
  Future<String> _getCodeSystemLocale() async {
    try {
      String systemLocale = await findSystemLocale();
      if (systemLocale.contains('_')) {
        systemLocale = systemLocale.substring(0, systemLocale.indexOf('_'));
      }
      return systemLocale.toUpperCase();
    } catch (e) {
      return 'EN';
    }
  }

  Future<NaturalLanguage> getSystemLang() async {
    String codeShort = await _getCodeSystemLocale();
    try {
      NaturalLanguage systemLanguage = NaturalLanguage.fromCodeShort(codeShort);
      if (NaturalLanguage.list.contains(systemLanguage)) {
        return systemLanguage;
      }
    } catch (e) {
      return NaturalLanguage.fromCodeShort('EN');
    }
    return NaturalLanguage.fromCodeShort('EN');
  }
}
