import 'package:flutter/material.dart';

class AppTheme {
  static const emerald = Color(0xFF0F1B2D);
  static const teal = Color(0xFF7FB3D5);
  // Compatibility aliases for existing widgets.
  static const gold = Color(0xFF7FB3D5);
  static const goldLight = Color(0xFFA8CBE8);
  static const background = Color(0xFFF2F4F7);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceRaised = Color(0xFFE8EDF2);
  static const text = Color(0xFF0F1B2D);
  static const outline = Color(0xFFD9DEE5);
  static const muted = Color(0xFF7A8695);
  static const light = Color(0xFFF2F4F7);
  static const dark = Color(0xFF0F1B2D);

  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F1B2D) : const Color(0xFFF2F4F7);
    final surface = isDark ? const Color(0xFF1A2E4A) : Colors.white;
    final raised = isDark ? const Color(0xFF243A5A) : const Color(0xFFE8EDF2);
    final fg = isDark ? const Color(0xFFF2F4F7) : const Color(0xFF0F1B2D);
    final secondary = isDark ? const Color(0xFFC0C8D0) : muted;
    final line = isDark ? const Color(0xFF2A3F5F) : const Color(0xFFD9DEE5);
    final scheme = (isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
      primary: emerald, secondary: teal, surface: surface, onSurface: fg,
      onPrimary: Colors.white, outline: line,
    );
    return ThemeData(
      useMaterial3: true, brightness: brightness, colorScheme: scheme,
      scaffoldBackgroundColor: bg, canvasColor: bg, fontFamily: 'sans-serif',
      appBarTheme: AppBarTheme(backgroundColor: bg, foregroundColor: fg, centerTitle: true,
        elevation: 0, scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: fg)),
      cardTheme: CardThemeData(color: surface, elevation: 0, margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22), side: BorderSide(color: line))),
      dividerColor: line,
      snackBarTheme: SnackBarThemeData(backgroundColor: isDark ? const Color(0xFF243A5A) : fg,
        contentTextStyle: const TextStyle(color: Colors.white), behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      listTileTheme: ListTileThemeData(iconColor: emerald, textColor: fg),
      switchTheme: SwitchThemeData(thumbColor: WidgetStatePropertyAll(emerald)),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: emerald,
        foregroundColor: Colors.white, elevation: 0, textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(foregroundColor: fg,
        side: BorderSide(color: line), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12))),
      extensions: <ThemeExtension<dynamic>>[MisbahatiColors(background: bg, surface: surface, raised: raised, text: fg, muted: secondary, outline: line)],
    );
  }
}

class MisbahatiColors extends ThemeExtension<MisbahatiColors> {
  const MisbahatiColors({required this.background, required this.surface, required this.raised, required this.text, required this.muted, required this.outline});
  final Color background, surface, raised, text, muted, outline;
  @override MisbahatiColors copyWith({Color? background, Color? surface, Color? raised, Color? text, Color? muted, Color? outline}) => MisbahatiColors(background: background ?? this.background, surface: surface ?? this.surface, raised: raised ?? this.raised, text: text ?? this.text, muted: muted ?? this.muted, outline: outline ?? this.outline);
  @override MisbahatiColors lerp(ThemeExtension<MisbahatiColors>? other, double t) { if (other is! MisbahatiColors) return this; return MisbahatiColors(background: Color.lerp(background, other.background, t)!, surface: Color.lerp(surface, other.surface, t)!, raised: Color.lerp(raised, other.raised, t)!, text: Color.lerp(text, other.text, t)!, muted: Color.lerp(muted, other.muted, t)!, outline: Color.lerp(outline, other.outline, t)!); }
}