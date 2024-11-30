import 'package:flutter/material.dart';

class AppColors {
  static const secondary = Color(0xFF8EB8E2);
  static const Color superLightBlue = Color(0xFFB3CADD);
  static const Color favoriteBlue = Color.fromARGB(255, 57, 131, 204);
  static const Color buttonColor = Color.fromARGB(255, 39, 97, 154);
  static const Color primary = Color(0xFF005AAE);
  static Color green = Colors.green ;
  static const Color cardBackground = Color.fromARGB(255, 249, 252, 255);

  static Map<int, Color> colorSwatch = {
    50: const Color(0xFFE0EAF3),
    100: const Color(0xFFB3CADD),
    200: const Color(0xFF80A7C5),
    300: const Color(0xFF4D84AE),
    400: const Color(0xFF26699B),
    500: const Color(0xFF005AAE),
    600: const Color(0xFF0051A5),
    700: const Color(0xFF004398),
    800: const Color(0xFF00378B),
    900: const Color(0xFF002570),
  };

  static MaterialColor blueMaterialColor =
      MaterialColor(0xFF005AAE, colorSwatch);
}
