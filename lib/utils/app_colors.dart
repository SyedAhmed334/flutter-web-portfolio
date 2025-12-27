// lib/utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Original colors
  static const Color darkGreen = Color(0xFF0A5F38); // Original primary
  static const Color mediumGreen = Color(0xFF1B8A5A); // Original accent
  static const Color lightGreen = Color(0xFF2ECC71);
  static const Color purpleAccent = Color(0xFF371e77);

  // New theme colors from ThemeController
  // Modern Theme Colors
  static const Color primaryColor = Color(0xFF00E676); // Neon Green
  static const Color accentColor = Color(0xFF69F0AE);
  static const Color backgroundColor = Color(0xFF0a0a0a); // Deepest Black
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color cardColor =
      Color(0xFF252525); // Slightly lighter for cards

  static const Color textColor = Colors.white;
  static const Color textColorSecondary = Color(0xFFAAAAAA);

  static const List<Color> primaryGradient = [
    Color(0xFF00E676),
    Color(0xFF69F0AE),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF1E1E1E),
    Color(0xFF252525),
  ];
}
