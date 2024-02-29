import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.dark;
  int index = 0;


  void changeThemeMode(ThemeMode mode){
    themeMode = mode;
    notifyListeners();
  }

  void changeLanguageCode(String langCode){
    languageCode = langCode;
    notifyListeners();
  }
  void changeIndex(int currentIndex){
    index =currentIndex;
    notifyListeners();
  }
}