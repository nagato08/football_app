import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF3852A4);
const Color accentYellow = Color(0xFFF8D959);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryBlue,
  scaffoldBackgroundColor: primaryBlue.withOpacity(0.1),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
  ),
  cardColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black87),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentYellow),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF121212),
  scaffoldBackgroundColor: Color(0xFF121212),
  cardColor: Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.white70),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFCCCCCC)),
  ),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    accentColor: accentYellow,
  ),
);