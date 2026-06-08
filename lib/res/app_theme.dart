import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData getTheme({required AppColors colors, required bool isDark}){
    return ThemeData(
      brightness: isDark? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: colors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primaryNeon,
        brightness: isDark? Brightness.dark : Brightness.light,
        primary: colors.primaryNeon,
        surface: colors.cardBackground
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryNeon,
          foregroundColor: isDark? const Color(0xFF0A0A0A) : Colors.black,
          disabledBackgroundColor: colors.primaryNeon.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 0
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.cardBackground,
        hintStyle: TextStyle(
          color: isDark? Colors.white24 : const Color(0xFF757575),
          fontSize: 13
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primaryNeon, width: 1.5),
          borderRadius: BorderRadius.circular(4)
        ),
      )
    );
  }
}