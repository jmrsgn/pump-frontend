import 'package:flutter/material.dart';

import '../app_colors.dart';

class BottomNavigationBarThemes {
  BottomNavigationBarThemes._();

  static final BottomNavigationBarThemeData defaultTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNav,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
      );
}
