import 'package:flutter/material.dart';

class AppTheme {
  // 1. Define Brand Colors
  static const Color primaryColor = Color(0xFF6B4EFF); // Violet from screenshot
  static const Color secondaryColor = Color(0xFFE0E0E0);
  static const Color backgroundColor = Color(0xFFF8F9FE);
  static const Color surfaceColor = Colors.white;

  // 2. Create the Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,

      // Define Color Scheme
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: Color(0xFF00C853), // Green for online status
        surface: surfaceColor,
        background: backgroundColor,
      ),

      // Text Theme (Pro Tip: Use Google Fonts)
      textTheme: TextTheme(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyMedium: const TextStyle(color: Colors.black87),
        bodySmall: TextStyle(color: Colors.grey[600]),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0, // Prevents color change on scroll
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(), // Perfectly round
      ),
    );
  }
}
