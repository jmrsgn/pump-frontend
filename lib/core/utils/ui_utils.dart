import 'package:flutter/material.dart';

import '../constants/app/app_dimens.dart';
import '../constants/app/app_strings.dart';
import '../presentation/theme/app_colors.dart';
import '../presentation/theme/app_text_styles.dart';

class UiUtils {
  UiUtils._();

  static Widget addDivider() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.dimen4),
      child: SizedBox(
        height: AppDimens.dimen8,
        width: AppDimens.dimen48,
        child: Container(color: AppColors.primary),
      ),
    );
  }

  static Widget addCopyright() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.dimen8),
      child: Center(
        child: Text(AppStrings.copyright, style: AppTextStyles.footer),
      ),
    );
  }

  static Widget addSpace({double height = 0, double width = 0}) {
    return SizedBox(height: height, width: width);
  }

  // Vertical Spaces
  static Widget addVerticalSpaceXS() {
    return SizedBox(height: AppDimens.spaceXS);
  }

  static Widget addVerticalSpaceS() {
    return SizedBox(height: AppDimens.spaceS);
  }

  static Widget addVerticalSpaceM() {
    return SizedBox(height: AppDimens.spaceM);
  }

  static Widget addVerticalSpaceL() {
    return SizedBox(height: AppDimens.spaceL);
  }

  static Widget addVerticalSpaceXL() {
    return SizedBox(height: AppDimens.spaceXL);
  }

  static Widget addVerticalSpaceXXL() {
    return SizedBox(height: AppDimens.spaceXXL);
  }

  // Horizontal Spaces
  static Widget addHorizontalSpaceXS() {
    return SizedBox(width: AppDimens.spaceXS);
  }

  static Widget addHorizontalSpaceS() {
    return SizedBox(width: AppDimens.spaceS);
  }

  static Widget addHorizontalSpaceM() {
    return SizedBox(width: AppDimens.spaceM);
  }

  static Widget addHorizontalSpaceL() {
    return SizedBox(width: AppDimens.spaceL);
  }

  static Widget addHorizontalSpaceXL() {
    return SizedBox(width: AppDimens.spaceXL);
  }

  static Widget addHorizontalSpaceXXL() {
    return SizedBox(width: AppDimens.spaceXXL);
  }

  // Snackbar
  static void showSnackbar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppTextStyles.bodySmall),
        backgroundColor: backgroundColor ?? AppColors.surface,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusS),
        ),
      ),
    );
  }

  static void showSnackBarSuccess(
    BuildContext context, {
    required String message,
  }) => showSnackbar(
    context,
    message: message,
    backgroundColor: AppColors.snackBarSuccess,
  );

  static void showSnackBarError(
    BuildContext context, {
    required String message,
  }) => showSnackbar(
    context,
    message: message,
    backgroundColor: AppColors.snackBarError,
  );

  static void showSnackBarInfo(
    BuildContext context, {
    required String message,
  }) => showSnackbar(
    context,
    message: message,
    backgroundColor: AppColors.snackBarInfo,
  );
}
