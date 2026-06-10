import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF05070A);
  static const Color card = Color(0xFF0D1117);
  static const Color cardAlt = Color(0xFF111827);
  static const Color border = Color(0xFF1E293B);
  static const Color dividerSubtle = Color(0x661E293B);
  static const Color blue = Color(0xFF38BDF8);
  static const Color green = Color(0xFF22C55E);
  static const Color amber = Color(0xFFF59E0B);
  static const Color red = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFAAB8CA);
  static const Color textMuted = Color(0xFF7E8DA2);

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: blue,
      secondary: green,
      surface: card,
      error: red,
      onPrimary: Color(0xFF04141C),
      onSecondary: Color(0xFF07160C),
      onSurface: textPrimary,
      onError: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerColor: border,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          height: 1.08,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 15.5,
          fontWeight: FontWeight.w600,
          height: 1.15,
        ),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 15, height: 1.35),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 13.5,
          height: 1.4,
        ),
        bodySmall: TextStyle(color: textMuted, fontSize: 12.5, height: 1.35),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: border),
        ),
        margin: EdgeInsets.zero,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textPrimary,
          backgroundColor: card,
          minimumSize: const Size(38, 38),
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: blue,
          foregroundColor: const Color(0xFF04141C),
          minimumSize: const Size(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          minimumSize: const Size(0, 50),
          side: const BorderSide(color: textPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: card,
        selectedColor: blue.withValues(alpha: 0.16),
        disabledColor: cardAlt,
        labelStyle: const TextStyle(color: textSecondary),
        secondaryLabelStyle: const TextStyle(color: blue),
        side: const BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: card,
        selectedItemColor: blue,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: card,
        indicatorColor: blue.withValues(alpha: 0.18),
        height: 74,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: textPrimary,
            fontSize: 12.5,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          );
        }),
      ),
    );
  }
}
