import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor:AppColor.whiteColor,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColor.whiteColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: const BorderSide(color: AppColor.whiteColor, width: 4),
      ),
      backgroundColor: AppColor.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.whiteColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColor.whiteColor),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.blackColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColor.blackColor),
    scaffoldBackgroundColor: const Color(0xFF1D1F24),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFF1D1F24),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: AppColor.blackColor, width: 4),
      ),
      backgroundColor: AppColor.primaryDarkColor,
    ),
  );
}
