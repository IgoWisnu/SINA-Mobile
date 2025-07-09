import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2e77f7);
  static const blueHover = Color(0xFF235fed);
  static const blueActive = Color(0xFF1C4AD9);
  static const textDisable = Color(0xFF5FA2FB);
  static const blueDisable = Color(0xFFDBE9FE);
  static const Color grey = Color(0xFF9E9E9E); // Grey 500
  static const Color orange = Color(0xFFFF9800); // Orange 500
  static const Color green = Color(0xFF4CAF50); // Green 500
  static const Color red = Color(0xFFF44336); // Red 500
  static const Color dark = Color(0xFF2B2B2B);

  //gradient
  static const LinearGradient lightBlueGradient = LinearGradient(
    colors: [
      Colors.white,
      Color(0xFFE3F2FD), // This is Colors.blue[50]
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight, // ← Left to Right
  );

  //gradient
  static const LinearGradient lightBlueGradientVertical = LinearGradient(
    colors: [
      Colors.white,
      Color(0xFFE3F2FD), // This is Colors.blue[50]
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft, // ← Left to Right
  );

  //gradient
  static const LinearGradient darkBlueGradientVertical = LinearGradient(
    colors: [
      Color(0xFF2B2B2B),
      Color(0xFF212834), // This is Colors.blue[50]
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft, // ← Left to Right
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      Color(0xFFE3F2FD), // Light Blue (Colors.blue[50])
      AppColors.primary, // Your custom primary blue
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient blueToBlueGradient = LinearGradient(
    colors: [
      Color(0xFF172FAA),
      AppColors.primary, // Your custom primary blue
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
