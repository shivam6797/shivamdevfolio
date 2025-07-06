import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00ADB5),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF00ADB5),
      onPrimary: Colors.black,
      secondary: Colors.tealAccent, // 🎯 Accent color for dark theme
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Color(0xFF121212),
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xB3000000), // ~70% black
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.grey[300]),
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF00ADB5),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00ADB5),
      onPrimary: Colors.white,
      secondary: Colors.blueAccent, // 🎯 Accent for light theme (clean on white)
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Color(0xFFF5F5F5),
      onSurface: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xF0FFFFFF), // ~95% white
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  );
}
