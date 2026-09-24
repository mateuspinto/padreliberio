import 'package:flutter/material.dart';

import 'color_tokens.dart';

/// Elderly-oriented sizing (CLAUDE.md): larger type scale and touch targets
/// than Material defaults.
ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorTokens.bg,
  colorScheme: const ColorScheme.light(
    primary: ColorTokens.primary,
    secondary: ColorTokens.secondary,
    surface: ColorTokens.surface,
    onSurface: ColorTokens.text,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorTokens.primary,
    foregroundColor: ColorTokens.white,
  ),
  navigationDrawerTheme: const NavigationDrawerThemeData(
    backgroundColor: ColorTokens.surface,
    indicatorColor: ColorTokens.secondaryFaded,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: ColorTokens.selection,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: ColorTokens.text, fontSize: 18),
    bodySmall: TextStyle(color: ColorTokens.textMuted, fontSize: 16),
    headlineMedium: TextStyle(
      color: ColorTokens.text,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(64, 56),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(64, 56),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(64, 56),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  iconTheme: const IconThemeData(size: 28),
);
