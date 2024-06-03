import 'package:flutter/material.dart';
import 'package:world_countries/world_countries.dart';

import 'shared_prefs.dart';

class IdiomaProvider extends ChangeNotifier {
  final SharedPrefs _sharedPrefs = SharedPrefs();

  NaturalLanguage _appLanguage = NaturalLanguage.fromCodeShort('EN');
  NaturalLanguage get appLanguage => _appLanguage;

  IdiomaProvider() {
    _getAppLanguage();
  }

  void _getAppLanguage() async {
    await _sharedPrefs.init();
    final String code = _sharedPrefs.codeAppLang ?? 'EN';
    _appLanguage = NaturalLanguage.fromCodeShort(code);
    notifyListeners();
  }

  void setAppLanguage(NaturalLanguage newLang) async {
    _sharedPrefs.codeAppLang = newLang.codeShort;
    _appLanguage = newLang;
    notifyListeners();
  }
}
