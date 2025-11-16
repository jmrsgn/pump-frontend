import 'package:flutter/material.dart';

import 'app_colors.dart';

// TODO: fix comments provided by chatGpt
class AppTextStyles {
  AppTextStyles._();

  // 🧭 AppBar Title
  static const appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  // 🏷️ Headings
  static const heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static const heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ✏️ Body Texts
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.3,
  );

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // 🧾 Caption / Metadata
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  // 💬 Buttons
  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // 💡 Input Fields
  static const input = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // ⚠️ Error / Warning Text
  static const error = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  // 👣 Footer / Copyright
  static const footer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.textHint,
    letterSpacing: 0.2,
  );
}
