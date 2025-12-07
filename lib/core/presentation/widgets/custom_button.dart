import 'package:flutter/material.dart';
import 'package:pump/core/presentation/theme/app_button_styles.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';

import '../../constants/app/app_dimens.dart';

class CustomButton extends StatelessWidget {
  final IconData? prefixIcon;
  final bool isOutlineButton;
  final VoidCallback? onPressed;
  final String label;

  const CustomButton({
    super.key,
    this.prefixIcon,
    this.isOutlineButton = false,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = prefixIcon == null
        ? null
        : Icon(
            prefixIcon,
            size: AppDimens.dimen20,
            color: isOutlineButton
                ? AppColors.primary
                : AppColors.textOnPrimary,
          );

    if (isOutlineButton) {
      return prefixIcon == null
          ? OutlinedButton(
              style: AppButtonStyles.outlined,
              onPressed: onPressed,
              child: Text(label),
            )
          : OutlinedButton.icon(
              style: AppButtonStyles.outlined,
              onPressed: onPressed,
              icon: iconWidget!,
              label: Text(label),
            );
    }

    return prefixIcon == null
        ? ElevatedButton(
            style: AppButtonStyles.normal,
            onPressed: onPressed,
            child: Text(label),
          )
        : ElevatedButton.icon(
            style: AppButtonStyles.normal,
            onPressed: onPressed,
            icon: iconWidget!,
            label: Text(label),
          );
  }
}
