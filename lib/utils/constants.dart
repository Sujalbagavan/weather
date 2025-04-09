import 'package:flutter/material.dart';

class AppColors {
  // Modern weather app color palette
  static const Color primaryColor = Color(0xFF1E88E5);    // Rich Blue
  static const Color secondaryColor = Color(0xFF64B5F6);  // Light Blue
  static const Color accentColor = Color(0xFFFFB74D);     // Warm Orange
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray
  static const Color darkBackgroundColor = Color(0xFF1A1A1A); // Dark Mode
  
  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);
  
  // Text colors
  static const Color textPrimary = Color(0xFF2C2C2C);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFF5F5F5);
  
  // Weather condition colors
  static const Color sunny = Color(0xFFFFB74D);      // Warm Orange
  static const Color rainy = Color(0xFF64B5F6);      // Light Blue
  static const Color cloudy = Color(0xFF90A4AE);     // Blue Grey
  static const Color storm = Color(0xFF546E7A);      // Dark Blue Grey
}

class AppStrings {
  static const String appName = 'Weather Dashboard';
  static const String apiKey = '88e2f19f33a6beecc06994dcf8b07d9f'; // Get a new API key from OpenWeatherMap
  static const String networkError = 'Network Error';
  static const String invalidApiKey = 'Invalid API Key';
  static const String failedToLoadData = 'Failed to load weather data';
}

class AppDimens {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
}

class AppStyles {
  static const double cardRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double spacing = 16.0;
  
  static BoxDecoration gradientCard = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.primaryColor,
        AppColors.primaryColor.withOpacity(0.8),
      ],
    ),
    borderRadius: BorderRadius.circular(cardRadius),
  );
  
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
}