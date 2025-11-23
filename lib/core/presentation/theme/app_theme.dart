import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';

import 'input_decoration_theme.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData.dark().copyWith(
      // Prevents AppBar color shift in dark mode
      applyElevationOverlayColor: false,

      // Default app theme
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.divider,
      inputDecorationTheme: AppInputDecorations.defaultTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        shadowColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Bottom Navigation Bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNav,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
      ),
    );
  }
}
