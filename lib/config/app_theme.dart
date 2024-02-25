import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color greyColor = Color(0xFFC8C9CB);
  static const Color blackColor = Color(0xFF141922);
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
          color: Color(0xFF363636),
        ),
        bodySmall: GoogleFonts.roboto(fontSize: 12, color: Color(0xFF363636),),),
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
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 22, color: Color(0xFF060E1E), fontWeight: FontWeight.bold),
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
    scaffoldBackgroundColor: const Color(0xFF060E1E),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: blackColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color:blackColor, width: 4)),
      backgroundColor: primaryColor,
    ),
  );
}
