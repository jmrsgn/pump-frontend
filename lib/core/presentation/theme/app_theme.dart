import 'package:flutter/material.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';

import 'input_decoration_theme.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      dividerColor: AppColors.background,
      inputDecorationTheme: AppInputDecorations.defaultTheme,
    );
  }
}
