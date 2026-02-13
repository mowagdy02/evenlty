import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale appLocale = const Locale('en');

  AppLanguageProvider() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString("language_key");

    if (savedLang != null) {
      appLocale = Locale(savedLang);
      notifyListeners();
    }
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (appLocale == newLocale) return;

    appLocale = newLocale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language_key", newLocale.languageCode);
  }
}
