import 'package:flutter/material.dart';
import 'nalar_colors.dart';
import 'nalar_radius.dart';
import 'nalar_text_styles.dart';

class NalarTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: NalarColors.background,
      primaryColor: NalarColors.primaryCoral,
      colorScheme: const ColorScheme.light(
        primary: NalarColors.primaryCoral,
        secondary: NalarColors.brightCoral,
        surface: NalarColors.white,
        background: NalarColors.background,
        error: NalarColors.primaryCoral,
        onPrimary: NalarColors.white,
        onSecondary: NalarColors.white,
        onSurface: NalarColors.charcoal,
        onBackground: NalarColors.charcoal,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: NalarColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        iconTheme: IconThemeData(color: NalarColors.charcoal),
        titleTextStyle: NalarTextStyles.heading3,
      ),
      cardTheme: CardThemeData(
        color: NalarColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: NalarRadius.borderLg,
          side: const BorderSide(color: NalarColors.border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NalarColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: NalarRadius.borderMd,
          borderSide: const BorderSide(color: NalarColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: NalarRadius.borderMd,
          borderSide: const BorderSide(color: NalarColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: NalarRadius.borderMd,
          borderSide: const BorderSide(color: NalarColors.primaryCoral, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: NalarRadius.borderMd,
          borderSide: const BorderSide(color: NalarColors.primaryCoral, width: 1),
        ),
        hintStyle: NalarTextStyles.bodyMedium.copyWith(color: NalarColors.secondaryText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NalarColors.primaryCoral,
          foregroundColor: NalarColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: NalarRadius.borderMd,
          ),
          textStyle: NalarTextStyles.buttonLabel,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: NalarColors.primaryCoral,
          side: const BorderSide(color: NalarColors.primaryCoral, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: NalarRadius.borderMd,
          ),
          textStyle: NalarTextStyles.buttonLabel.copyWith(color: NalarColors.primaryCoral),
        ),
      ),
    );
  }
}
