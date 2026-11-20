import 'package:flutter/material.dart';

class AppTheme {
  // الوان سَكِينة - كحلي فقط بدون ذهبي
  static const Color navy = Color(0xFF0F1B2D);
  static const Color navyLight = Color(0xFF1A2E4A);
  static const Color navyLighter = Color(0xFF243A5A);
  static const Color accent = Color(0xFF7FB3D5);
  static const Color accentLight = Color(0xFFA8CBE8);
  // اسم بديل لنفس اللون عشان اي ملف قديم يستخدم gold ما يخرب
  static const Color gold = Color(0xFF7FB3D5);

  static const Color background = Color(0xFF0F1B2D);
  static const Color surface = Color(0xFF1A2E4A);
  static const Color card = Color(0xFF1A2E4A);
  static const Color muted = Color(0xFF9AA9BC);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9AA9BC);
  static const Color primary = Color(0xFF1A2E4A);

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF4F7FA),
    primaryColor: navy,
    colorScheme: const ColorScheme.light(
      primary: navy,
      secondary: accent,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    useMaterial3: true,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navy,
    primaryColor: navyLight,
    colorScheme: const ColorScheme.dark(
      primary: accent,
      secondary: accentLight,
      surface: navyLight,
      background: navy,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: navyLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: navyLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    useMaterial3: true,
  );

  // لو كودك يستخدم AppTheme.theme
  static ThemeData get theme => darkTheme;
}
