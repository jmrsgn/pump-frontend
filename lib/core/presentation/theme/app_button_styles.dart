import 'package:flutter/material.dart';

import '../../constants/app/app_dimens.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppButtonStyles {
  AppButtonStyles._();

  static final normal = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(AppColors.primary),
    foregroundColor: WidgetStateProperty.all(AppColors.textOnPrimary),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(
        vertical: AppDimens.padding12,
        horizontal: AppDimens.padding16,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
    ),
    textStyle: WidgetStateProperty.all(AppTextStyles.button),
  );

  static final outlined = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    foregroundColor: WidgetStateProperty.all(AppColors.primary),
    side: WidgetStateProperty.all(
      BorderSide(color: AppColors.primary, width: AppDimens.dimen1_5),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        vertical: AppDimens.padding12,
        horizontal: AppDimens.padding16,
      ),
    ),
    textStyle: WidgetStateProperty.all(AppTextStyles.button),
  );
}
