import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';

class AppBarThemes {
  AppBarThemes._();

  static final AppBarTheme defaultTheme = AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    shadowColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
