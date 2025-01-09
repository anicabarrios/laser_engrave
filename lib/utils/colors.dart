import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF2C3E50);    // Deep blue-gray
  static const Color accentColor = Color(0xFF3498DB);     // Clean blue
  static const Color secondaryColor = Color(0xFF34495E);  // Slate gray

  // Background Colors
  static const Color lightColor = Color(0xFFF8F9FA);      // Off-white
  static const Color darkColor = Color(0xFF1A1A1A);       // Almost black
  
  // Metallic Accents
  static const Color platinum = Color(0xFFE5E7E9);        // Light metallic
  static const Color champagne = Color(0xFFBDC3C7);       // Light silver
  static const Color titanium = Color(0xFF95A5A6);        // Medium metallic
  static const Color pearl = Color(0xFFFFFFFF);           // Pure white

  // Text Colors
  static const Color darkTextColor = Color(0xFF2C3E50);   // Deep blue-gray
  static const Color lightTextColor = Color(0xFFFFFFFF);  // Pure white

  // Additional Accent Colors
  static const Color sapphire = Color(0xFF3498DB);        // Clean blue
  static const Color amethyst = Color(0xFF34495E);        // Slate gray
  static const Color aquamarine = Color(0xFF1ABC9C);      // Teal

  // Theme Color Scheme and other settings remain the same
  static final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: accentColor,
    surface: secondaryColor,
    background: lightColor,
    tertiary: champagne,
    brightness: Brightness.light,
  );

  // Gradients
  static final LinearGradient premiumDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      secondaryColor,
      darkColor,
    ],
    stops: const [0.0, 0.5, 1.0],
  );

   static final LinearGradient metallicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      pearl,
      pearl.withOpacity(0.95),
      platinum.withOpacity(0.3),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  static final LinearGradient luxuryAccentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      champagne.withOpacity(0.9),
      accentColor.withOpacity(0.8),
      champagne.withOpacity(0.9),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  // Theme Data
  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightColor,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: lightTextColor,
      elevation: 2,
      shadowColor: champagne.withOpacity(0.3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: lightTextColor,
        elevation: 2,
        shadowColor: champagne.withOpacity(0.4),
      ),
    ),
    fontFamily: 'Montserrat',
  );
}