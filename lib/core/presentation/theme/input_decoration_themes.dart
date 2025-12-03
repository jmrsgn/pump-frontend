import 'package:flutter/material.dart';

import '../../constants/app/app_dimens.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class InputDecorationThemes {
  InputDecorationThemes._();

  static final InputDecorationTheme defaultTheme = InputDecorationTheme(
    hintStyle: AppTextStyles.inputLabel,
    prefixIconColor: AppColors.textHint,
    contentPadding: EdgeInsets.symmetric(
      vertical: AppDimens.padding16,
      horizontal: AppDimens.padding24,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.textHint,
        width: AppDimens.dimen2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: AppDimens.dimen3),
      borderRadius: BorderRadius.all(Radius.circular(AppDimens.radius8)),
    ),
  );
}
