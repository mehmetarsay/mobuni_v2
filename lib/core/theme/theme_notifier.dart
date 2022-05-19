import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "darkTheme";
  bool? _darkTheme;
  bool? get darkTheme => _darkTheme;
  set darkTheme(bool? value) {
    this._darkTheme = value;
    notifyListeners();
  }

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme!;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    var _pref = GeneralManager.hiveM.hive.get(key);
    if (_pref != null && _pref)
      darkTheme = true;
    else
      darkTheme = false;
  }

  _saveToPrefs() async {
    GeneralManager.hiveM.hive.put(key, darkTheme);
  }
}
