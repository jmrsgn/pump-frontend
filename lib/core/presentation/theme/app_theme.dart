import 'package:flutter/material.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';
import 'package:pump/core/presentation/theme/text_selection_themes.dart';
import 'package:pump/core/presentation/theme/widgets/app_bar_themes.dart';
import 'package:pump/core/presentation/theme/widgets/bottom_navigation_bar_themes.dart';

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

      // Text Selection Theme
      textSelectionTheme: TextSelectionThemes.defaultTheme,

      // Widgets
      // App Bar Themes
      appBarTheme: AppBarThemes.defaultTheme,

      // Bottom Navigation Bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemes.defaultTheme,
    );
  }
}
