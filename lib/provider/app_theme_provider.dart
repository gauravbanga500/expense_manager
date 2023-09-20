import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppThemeProvider extends ChangeNotifier {
ThemeData _theme = ThemeData.dark();



  bool isDark = false;

  void changeTheme(){

    isDark = !isDark;
    notifyListeners();
  }

  bool getThemeBoolean(){
    return isDark;
  }

  get  themeBoolean => isDark;

}