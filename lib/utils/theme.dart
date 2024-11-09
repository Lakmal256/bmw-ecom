import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const _tintedForegroundColorLight = Color(0xFF000000);
  static const _tintedForegroundColorDark = Color(0xFFFFFFFF);
  static const _inputTextFieldColorForDark = Color(0xFF616161);
  static const _drawerTextColorForDark = Color(0xFFBDBDBD);
  static const _primaryColor = Color(0xFF002366);

  static final light = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[200],
    ).copyWith(primary: _primaryColor, surface: Colors.grey[200]),
    primaryColor: _primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.grey[400]),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.lato(
        fontSize: 52,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      titleSmall: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _tintedForegroundColorLight,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: _inputTextFieldColorForDark),
        prefixIconColor: _inputTextFieldColorForDark,
        suffixIconColor: _inputTextFieldColorForDark),
    tabBarTheme: const TabBarTheme(indicatorColor: _primaryColor),
  );

  static final dark = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey[850],
    ).copyWith(primary: _primaryColor,surface: Colors.grey[850]),
    primaryColor: _primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.grey[800]),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.lato(
        fontSize: 52,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      titleSmall: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorDark,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _drawerTextColorForDark,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _drawerTextColorForDark,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _tintedForegroundColorLight,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: _inputTextFieldColorForDark),
        prefixIconColor: _inputTextFieldColorForDark,
        suffixIconColor: _inputTextFieldColorForDark),
    cardColor: Colors.grey[700],
    tabBarTheme: const TabBarTheme(indicatorColor: _primaryColor),
  );
}
