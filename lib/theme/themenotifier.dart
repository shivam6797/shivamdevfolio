import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// key we’ll use inside SharedPreferences
const _storageKey = 'APP_THEME_MODE';   // 0-light | 1-dark | 2-system

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;        // default
  ThemeMode get themeMode => _themeMode;

  bool   get isDarkMode => _themeMode == ThemeMode.dark;

  /* ───────────────────────── constructor ───────────────────────── */
  ThemeNotifier() {
    _load();                                      // restore saved mode
  }

  /* ───────────────────── toggle & persist ─────────────────────── */
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    _save();
  }

  /* ───────────────────────── storage helpers ───────────────────── */
  Future<void> _save() async =>
      (await SharedPreferences.getInstance())
          .setInt(_storageKey, _themeMode.index);

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final idx   = prefs.getInt(_storageKey);
    if (idx != null && idx >= 0 && idx < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[idx];
      notifyListeners();                           // rebuild UI
    }
  }
}
