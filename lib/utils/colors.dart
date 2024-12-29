import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF0A0F1E);    // Rich dark blue - luxury and depth
  static const Color accentColor = Color(0xFFB8A355);     // Antique gold - premium feel
  static const Color secondaryColor = Color(0xFF2A2D45);  // Deep purple-blue - sophistication

  // Background Colors
  static const Color lightColor = Color(0xFFF9F8FF);      // Warm white - elegance
  static const Color darkColor = Color(0xFF151A30);       // Deep blue-black - depth
  
  // Metallic Accents
  static const Color platinum = Color(0xFFE5E4E2);        // Platinum metallic
  static const Color champagne = Color(0xFFF3E5AB);       // Champagne gold
  static const Color titanium = Color(0xFFBEC2CB);        // Titanium metallic
  static const Color pearl = Color(0xFFF0EAD6);           // Pearl white

  // Text Colors
  static const Color darkTextColor = Color(0xFF151A30);   // Deep blue-black for light backgrounds
  static const Color lightTextColor = Color(0xFFF9F8FF);  // Warm white for dark backgrounds

  // Additional Accent Colors
  static const Color sapphire = Color(0xFF0F52BA);        // Deep sapphire blue
  static const Color amethyst = Color(0xFF6C4AB0);        // Rich purple
  static const Color aquamarine = Color(0xFF79B9CA);      // Soft blue-green

  // Theme Color Scheme
  static final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: accentColor,
    surface: secondaryColor,
    background: lightColor,
    tertiary: champagne,
    brightness: Brightness.light,
  );

  // Theme Data
  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightColor,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: lightTextColor,
      elevation: 0,
      shadowColor: champagne.withOpacity(0.3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: darkTextColor,
        elevation: 4,
        shadowColor: champagne.withOpacity(0.5),
      ),
    ),
    fontFamily: 'Montserrat',
  );

  // Luxury Gradient Presets
  static final LinearGradient premiumDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      secondaryColor,
      Color(0xFF1A1B35),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  // Metallic Gradient
  static final LinearGradient metallicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      platinum.withOpacity(0.95),
      titanium.withOpacity(0.8),
      platinum.withOpacity(0.9),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  // Premium Accent Gradient
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

  // Modern Tech Gradient
  static final LinearGradient modernTechGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      sapphire.withOpacity(0.9),
      amethyst.withOpacity(0.7),
      aquamarine.withOpacity(0.8),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  // Pearl Shimmer Gradient
  static final LinearGradient pearlShimmerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      pearl.withOpacity(0.95),
      platinum.withOpacity(0.8),
      pearl.withOpacity(0.9),
      champagne.withOpacity(0.3),
    ],
    stops: const [0.0, 0.3, 0.7, 1.0],
  );

  // Background Texture Gradient
  static final LinearGradient subtleTextureGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      lightColor,
      pearl.withOpacity(0.3),
      lightColor,
    ],
    stops: const [0.0, 0.5, 1.0],
  );
}