import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get cyberTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,

      // 1. Core Color Scheme Setup
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryNeon,
        background: AppColors.background,
        surface: AppColors.cardBackground,
      ),

      // 2. Global Button Theme (For CustomButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNeon,
          foregroundColor: AppColors.background,
          disabledBackgroundColor: AppColors.primaryNeon.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 0,
        ),
      ),

      // 3. Global Input Decoration Theme (For TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // Defualt Border (Bina click kiye jo dikhta hai)
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(4),
        ),
        // Click karne par Neon Green Glow Border
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryNeon, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
