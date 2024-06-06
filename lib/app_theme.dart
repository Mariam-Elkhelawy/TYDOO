import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_colors.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF413076);
  static const Color primaryDarkColor = Color(0xFF8B6EE5);
  static const Color secondaryColor = Color(0xFFDFC0D8);
  static const Color greyColor = Color(0xFFC8C9CB);
  static const Color blackColor = Colors.black;
  static const Color darkColor = Color(0xFF383838);
  static const Color whiteColor = Colors.white;
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 22, color: AppColor.blackColor, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.inter(
          fontSize: 24, color: AppColor.blackColor, fontWeight: FontWeight.w800),
      bodyMedium: GoogleFonts.inter(
        fontSize: 20,
        color: const Color(0xFFEFEFEF),
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColor.blackColor
      ),
    ),
    scaffoldBackgroundColor:Colors.white,
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
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 22,
          color: const Color(0xFF060E1E),
          fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 18, color: AppColor.primaryColor, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColor.whiteColor,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
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
