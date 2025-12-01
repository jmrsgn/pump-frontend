import 'package:flutter/material.dart';
import 'package:pump/core/presentation/theme/app_bar_themes.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';

import 'input_decoration_themes.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData.dark().copyWith(
      // Default App Theme
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.divider,
      // Prevents AppBar color shift in dark mode
      applyElevationOverlayColor: false,

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationThemes.defaultTheme,

      // App Bar Themes
      appBarTheme: AppBarThemes.defaultTheme,

      // Bottom Navigation Bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNav,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
      ),

      // Text Selection Theme
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.3),
        selectionHandleColor: AppColors.primary,
      ),
    );
  }
}
