import 'package:flutter/material.dart';

import '../../data/services/local_cache_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._cache);

  final LocalCacheService _cache;
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void load() {
    _themeMode = _cache.darkMode ? ThemeMode.dark : ThemeMode.light;
    _locale = Locale(_cache.languageCode);
    notifyListeners();
  }

  Future<void> toggleTheme(bool dark) async {
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    await _cache.setDarkMode(dark);
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _locale = Locale(code);
    await _cache.setLanguageCode(code);
    notifyListeners();
  }
}
