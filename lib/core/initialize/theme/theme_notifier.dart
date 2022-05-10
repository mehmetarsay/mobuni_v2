import 'package:flutter/material.dart';


class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  bool? _darkTheme;

  bool? get darkTheme => _darkTheme;


  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme(){
    _darkTheme = !_darkTheme!;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    // if(_pref == null)
    //   _pref  = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    // await _initPrefs();
    // _darkTheme = _pref!.getBool(key) ?? false;
    // notifyListeners();
  }

  _saveToPrefs() async {
    // await _initPrefs();
    // _pref!.setBool(key, _darkTheme!);
  }

}
