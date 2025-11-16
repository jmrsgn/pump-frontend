import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core Brand Colors
  static const Color primary = Color(0xFFFF7A00); // Main accent orange
  static const Color primaryDark = Color(0xFFCC5E00); // Pressed/active state
  static const Color primaryLight = Color(0xFFFFA94D); // Hover/focus/gradients

  // Backgrounds & Surfaces
  static const Color background = Color(0xFF0D0D0D); // App background
  static const Color surface = Color(0xFF151515); // Card/AppBar surfaces
  static const Color surfaceLight = Color(
    0xFF1C1C1C,
  ); // Slightly lighter surface

  // Text Colors
  static const Color textPrimary = Color(0xFFEAEAEA); // Default readable text
  static const Color textSecondary = Color(0xFFB3B3B3); // Captions, subtitles
  static const Color textDisabled = Color(0xFF666666); // Disabled/placeholder
  static const Color textHint = Color(0xFF777777); // Hint text inside inputs
  static const Color textOnPrimary = Colors.white; // Text on orange

  //  Functional Colors
  static const Color success = Color(0xFF00C853); // Green for success
  static const Color warning = Color(0xFFFFA000); // Orange-yellow for warnings
  static const Color error = Color(0xFFE53935); // Red for errors
  static const Color info = Color(0xFF29B6F6); // Blue for info banners

  static const Color accentBlueLight = Color(0xFF03A9F4);

  // UI Components
  static const Color appBar = surface;
  static const Color bottomNav = Color(0xFF121212);
  static const Color drawerBackground = Color(0xFF121212);
  static const Color drawerSelected = primary;
  static const Color drawerUnselected = textSecondary;

  // Inputs & Borders
  static const Color inputBackground = Color(0xFF2A2A2A);
  static const Color inputBorder = Color(0xFF333333);
  static const Color inputFocusedBorder = primary;
  static const Color divider = Color(0xFF333333);

  // Overlays / Shadows
  static const Color overlay = Color(0x80000000); // 50% black overlay
  static const Color shadow = Color(0x33000000); // 20% black shadow

  // SnackBar
  static const Color snackBarError = Color(0xFFFF7043); // coral/orange
  static const Color snackBarSuccess = Color(0xFF00BFA6); // teal/cyan
  static const Color snackBarInfo = Color(0xFF9C27B0); // purple
}
