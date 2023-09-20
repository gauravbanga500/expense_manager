import 'package:expenser_app/shared_preferences/theme_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModal extends ChangeNotifier{
  late bool _isDark;
  late ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;



  ThemeModal(){
    _isDark = false;
    themeSharedPreferences = ThemeSharedPreferences();
    getThemePreferences();
  }

  set isDark(bool value){
    _isDark = value;
     themeSharedPreferences.setTheme(value);
     notifyListeners();
  }

  getThemePreferences() async{
    _isDark = await themeSharedPreferences.getTheme();
     notifyListeners();
  }

}
class MyAppTheme{

  static ThemeData lightTheme(){
    return ThemeData(
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontSize: 35,
              color: Colors.black
          ),
          bodyMedium: TextStyle(
              fontSize: 25,
              color: Colors.black
          ),
          labelMedium: TextStyle(
              fontSize: 16,
              color: Colors.black
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        primarySwatch: Colors.blue

    );

  }

  static ThemeData darkTheme(){
    return ThemeData(
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
        textTheme: TextTheme(
            headlineLarge: TextStyle(
                fontSize: 35,
                color: Colors.white
            ),
            bodyMedium: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),
            labelMedium: TextStyle(
                fontSize: 16,
                color: Colors.white
            )
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white
            )
        ),
        brightness: Brightness.dark
    );
  }
  MyAppTheme();
}