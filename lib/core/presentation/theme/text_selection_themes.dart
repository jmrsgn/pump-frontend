import 'package:flutter/material.dart';

import '../../constants/app/app_dimens.dart';
import 'app_colors.dart';

class TextSelectionThemes {
  TextSelectionThemes._();

  static final TextSelectionThemeData defaultTheme = TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.primary.withValues(alpha: AppDimens.alpha0_3),
    selectionHandleColor: AppColors.primary,
  );
}
