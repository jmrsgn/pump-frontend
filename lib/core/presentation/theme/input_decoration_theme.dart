import 'package:flutter/material.dart';

import '../../constants/app/app_dimens.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppInputDecorations {
  static final InputDecorationTheme defaultTheme = InputDecorationTheme(
    hintStyle: AppTextStyles.inputLabel,
    prefixIconColor: AppColors.textHint,
    contentPadding: EdgeInsets.symmetric(
      vertical: AppDimens.textFieldVerticalPadding,
      horizontal: AppDimens.textFieldHorizontalPadding,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.textHint,
        width: AppDimens.textFieldEnabledBorderWidth,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimens.textFieldCornerRadius),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primary,
        width: AppDimens.textFieldFocusedBorderWidth,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimens.textFieldCornerRadius),
      ),
    ),
  );
}
