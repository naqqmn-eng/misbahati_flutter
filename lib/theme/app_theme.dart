import 'package:flutter/material.dart';

// سَكِينة v1.5.0 - كحلي فقط
// كل الاسماء القديمة موجودة هنا كأسماء بديلة = نفس الالوان الكحلية
// عشان لا يخرب اي ملف

class MisbahatiColors extends ThemeExtension<MisbahatiColors> {
  final Color primary;
  final Color accent;
  final Color surface;
  final Color card;
  final Color muted;
  final Color emerald;
  final Color gold;
  final Color goldLight;
  final Color emeraldLight;
  final Color text;
  final Color textSecondary;
  final Color background;
  final Color outline;
  final Color raised;
  final Color border;
  final Color divider;
  final Color shadow;
  const MisbahatiColors({
    required this.primary,
    required this.accent,
    required this.surface,
    required this.card,
    required this.muted,
    required this.emerald,
    required this.gold,
    required this.goldLight,
    required this.emeraldLight,
    required this.text,
    required this.textSecondary,
    required this.background,
    required this.outline,
    required this.raised,
    required this.border,
    required this.divider,
    required this.shadow,
  });
  @override
  MisbahatiColors copyWith({Color? primary, Color? accent, Color? surface, Color? card, Color? muted, Color? emerald, Color? gold, Color? goldLight, Color? emeraldLight, Color? text, Color? textSecondary, Color? background, Color? outline, Color? raised, Color? border, Color? divider, Color? shadow}) {
    return MisbahatiColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      muted: muted ?? this.muted,
      emerald: emerald ?? this.emerald,
      gold: gold ?? this.gold,
      goldLight: goldLight ?? this.goldLight,
      emeraldLight: emeraldLight ?? this.emeraldLight,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      background: background ?? this.background,
      outline: outline ?? this.outline,
      raised: raised ?? this.raised,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
    );
  }
  @override
  MisbahatiColors lerp(ThemeExtension<MisbahatiColors>? other, double t) {
    if (other is! MisbahatiColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return MisbahatiColors(
      primary: l(primary, other.primary),
      accent: l(accent, other.accent),
      surface: l(surface, other.surface),
      card: l(card, other.card),
      muted: l(muted, other.muted),
      emerald: l(emerald, other.emerald),
      gold: l(gold, other.gold),
      goldLight: l(goldLight, other.goldLight),
      emeraldLight: l(emeraldLight, other.emeraldLight),
      text: l(text, other.text),
      textSecondary: l(textSecondary, other.textSecondary),
      background: l(background, other.background),
      outline: l(outline, other.outline),
      raised: l(raised, other.raised),
      border: l(border, other.border),
      divider: l(divider, other.divider),
      shadow: l(shadow, other.shadow),
    );
  }
}

class AppTheme {
  static const Color navy = Color(0xFF0F1B2D);
  static const Color navyLight = Color(0xFF1A2E4A);
  static const Color navyLighter = Color(0xFF243A5A);
  static const Color accent = Color(0xFF7FB3D5);
  static const Color accentLight = Color(0xFFA8CBE8);
  // اسماء قديمة - كلها صارت كحلي/سماوي، ما عاد فيه اخضر ولا ذهبي
  static const Color gold = Color(0xFF7FB3D5);
  static const Color goldLight = Color(0xFFA8CBE8);
  static const Color emerald = Color(0xFF7FB3D5);
  static const Color emeraldLight = Color(0xFFA8CBE8);
  static const Color green = Color(0xFF7FB3D5);
  static const Color greenLight = Color(0xFFA8CBE8);

  static const Color background = Color(0xFF0F1B2D);
  static const Color surface = Color(0xFF1A2E4A);
  static const Color card = Color(0xFF1A2E4A);
  static const Color muted = Color(0xFF9AA9BC);
  static const Color text = Colors.white;
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9AA9BC);
  static const Color primary = Color(0xFF1A2E4A);
  static const Color outline = Color(0xFF2A4262);
  static const Color raised = Color(0xFF243A5A);
  static const Color border = Color(0xFF2A4262);
  static const Color divider = Color(0xFF2A4262);
  static const Color shadow = Color(0xFF000000);

  static const MisbahatiColors colors = MisbahatiColors(
    primary: navyLight,
    accent: accent,
    surface: surface,
    card: card,
    muted: muted,
    emerald: emerald,
    gold: gold,
    goldLight: goldLight,
    emeraldLight: emeraldLight,
    text: text,
    textSecondary: textSecondary,
    background: background,
    outline: outline,
    raised: raised,
    border: border,
    divider: divider,
    shadow: shadow,
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF4F7FA),
    primaryColor: navy,
    colorScheme: const ColorScheme.light(primary: navy, secondary: accent, surface: Colors.white),
    appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white, centerTitle: true),
    cardTheme: CardThemeData(color: Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: navy, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    extensions: const [colors],
    useMaterial3: true,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navy,
    primaryColor: navyLight,
    colorScheme: const ColorScheme.dark(primary: accent, secondary: accentLight, surface: navyLight, background: navy),
    appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white, centerTitle: true),
    cardTheme: CardThemeData(color: navyLight, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: navyLight, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
    extensions: const [colors],
    useMaterial3: true,
  );

  static ThemeData get theme => darkTheme;
}
