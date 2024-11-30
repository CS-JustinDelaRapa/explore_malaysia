import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF7D7D1F);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey600 = Color(0xFF757575);
  static const Color blue = Colors.blue;
  static const Color white70 = Colors.white70;

  // Opacity variations
  static Color blackWithOpacity(double opacity) => black.withOpacity(opacity);
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
}
