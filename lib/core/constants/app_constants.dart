import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF0D1B2A);
  static const Color primary = Color(0xFF1B2A3B);
  static const Color primaryLight = Color(0xFF243447);
  static const Color accent = Color(0xFFFFB703);
  static const Color accentDark = Color(0xFFE5A503);
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  
  static Color cardBg = Colors.white.withOpacity(0.08);
  static const Color scaffoldBg = Color(0xFF0D1B2A);
}

class AppSizes {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  static const double paddingXs = 4.0;
  static const double paddingSm = 8.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 24.0;
  static const double paddingXl = 32.0;
  
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 100.0;
}

class AppStrings {
  static const String appName = 'SecureGate';
  static const String tagline = 'Smart Visitor Management System';
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}
