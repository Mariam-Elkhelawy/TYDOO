import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  late String languageCode;
  late ThemeMode themeMode;
  int index = 0;
  SharedPreferences? sharedPreferences;
  String? _imagePath;

  String? get imagePath => _imagePath;

  setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }
  void changeThemeMode(ThemeMode mode) {
    themeMode = mode;
    if (mode == ThemeMode.light) {
      saveTheme(false);
    } else {
      saveTheme(true);
    }
    notifyListeners();
  }

  void changeLanguageCode(String langCode) {
    languageCode = langCode;
    if (langCode == 'ar') {
      saveLanguage(false);
    } else {
      saveLanguage(true);
    }
    notifyListeners();
  }

  void changeIndex(int currentIndex) {
    index = currentIndex;
    notifyListeners();
  }

  Future<void> saveTheme(bool isDark) async {
    await sharedPreferences!.setBool('isDark', isDark);
  }

  Future<void> saveLanguage(bool isEnglish) async {
    await sharedPreferences!.setBool('isEnglish', isEnglish);
  }

  bool? getTheme() {
    return sharedPreferences!.getBool('isDark');
  }

  bool? getLanguage() {
    return sharedPreferences!.getBool('isEnglish');
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getTheme() ?? false) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    if (getLanguage() ?? false) {
      languageCode = 'en';
    } else {
      languageCode = 'ar';
    }
  }

}
