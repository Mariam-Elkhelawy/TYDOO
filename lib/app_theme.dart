import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF413076);
  static const Color primaryDarkColor = Color(0xFF8B6EE5);
  static const Color secondaryColor = Color(0xFFDFC0D8);
  static const Color greyColor = Color(0xFFC8C9CB);
  static const Color blackColor = Color(0xFF141922);
  static const Color darkColor = Color(0xFF383838);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF363636),
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        color: const Color(0xFF363636),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Colors.white, width: 4),
      ),
      backgroundColor: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 22,
          color: const Color(0xFF060E1E),
          fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: blackColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: blackColor),
    scaffoldBackgroundColor: const Color(0xFF1D1F24),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFF1D1F24),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: blackColor, width: 4),
      ),
      backgroundColor: primaryDarkColor,
    ),
  );
}
