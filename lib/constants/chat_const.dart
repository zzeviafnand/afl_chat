import 'package:flutter/material.dart';

class ChatColor {
  static const MaterialColor primaryColor = MaterialColor(
    _primaryColor,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_primaryColor),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static const int _primaryColor = 0xFF3c4df0;

  static Color buttonPrimaryColor = const Color(0xFF00a8f4);
  static Color buttonSecondaryColor = Colors.white;
}
