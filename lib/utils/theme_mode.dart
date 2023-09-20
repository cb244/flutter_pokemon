import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveThemeMode(ThemeMode mode) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString('themeMode', mode.name);
}

Future<ThemeMode> loadThemeMode(SharedPreferences pref) async {
  String name = pref.getString('themeMode') ?? ThemeMode.system.name;
  return ThemeMode.values.byName(name);
}

class ThemeModeNotifier extends ChangeNotifier {
  late ThemeMode _themeMode;
  late SharedPreferences _pref;

  ThemeModeNotifier(SharedPreferences pref) {
    _init(pref);
  }

  ThemeMode get mode => _themeMode;

  void _init(SharedPreferences pref) async {
    _pref = pref;
    _themeMode = await loadThemeMode(_pref);
    notifyListeners();
  }

  void update(ThemeMode nextMode) {
    _themeMode = nextMode;
    saveThemeMode(nextMode);
    notifyListeners();
  }
}
