import 'package:flutter/material.dart';

abstract class AppColors{
  Color get background;
  Color get cardBackground;
  Color get primaryNeon;
  Color get textMain;
  Color get textMuted;
}

class DarkColors implements AppColors{
  @override
  Color get background => const Color(0xFF0A0A0A);
  @override
  Color get cardBackground => const Color(0xFF121212);
  @override
  Color get primaryNeon => const Color(0xFF9EFF00);
  @override
  Color get textMain => Colors.white;
  @override
  Color get textMuted => const Color(0xFF666666);
}

class LightColors implements AppColors{
  @override
  Color get background => const Color(0xFFF2F4F7);
  @override
  Color get cardBackground => const Color(0xFFFFFFFF);
  @override
  Color get primaryNeon => const Color(0xFF00A3FF);
  @override
  Color get textMain => const Color(0xFF101828);
  @override
  Color get textMuted => const Color(0xFF667085);
}