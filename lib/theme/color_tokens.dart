import 'package:flutter/material.dart';

/// Light, near-white warm beige as the dominant color, wine/maroon as the
/// brand accent — see CLAUDE.md's "Design tokens" section before adding a
/// new usage.
abstract final class ColorTokens {
  static const primary = Color(0xFF6E2532);
  static const primaryDark = Color(0xFF4E1B24);
  static const primaryLight = Color(0xFF8C3B49);
  static const secondary = Color(0xFFA66A1E);
  static const secondaryFaded = Color(0x33A66A1E);
  static const bg = Color(0xFFFAF3E7);
  static const surface = Color(0xFFF3E6D3);
  static const text = Color(0xFF3A2418);
  static const textMuted = Color(0xFF7A6352);
  static const border = Color(0xFFE4D2B8);

  /// Text/icons on top of a `primary` (wine) surface — not interchangeable
  /// with [text], which is for the light `bg`/`surface`.
  static const white = Color(0xFFFFFFFF);

  /// Classic opaque selection blue — still reads well against the new
  /// (dark, warm-brown) [text] color.
  static const selection = Color(0xFF0078D7);
}
