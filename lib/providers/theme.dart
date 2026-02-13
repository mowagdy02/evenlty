import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.system;

  AppThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString("Theme_key");

    if (savedTheme != null) {
      if (savedTheme == "dark") {
        appTheme = ThemeMode.dark;
      } else if (savedTheme == "light") {
        appTheme = ThemeMode.light;
      } else {
        appTheme = ThemeMode.system;
      }
      notifyListeners();
    }
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;

    appTheme = newTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Theme_key", newTheme.name);
  }
}
