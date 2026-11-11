import 'package:flutter/material.dart';

/// Thème centralisé (ThemeData). Adapte la couleur et la typographie
/// à celles de la séance 2.
class AppTheme {
  static const Color seed = Color(0xFF3F51B5);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
