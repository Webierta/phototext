import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  static const String _prefscodeAppLang = 'codeAppLang';

  init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String? get codeAppLang =>
      _sharedPrefs?.getString(_prefscodeAppLang); // ?? 'en';
  set codeAppLang(String? value) =>
      _sharedPrefs?.setString(_prefscodeAppLang, value!);
}
