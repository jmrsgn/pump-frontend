import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pump/core/constants/app/app_dimens.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final appBarTitle = GoogleFonts.montserrat(
    fontSize: AppDimens.textSize20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  // Heading Texts
  static final heading1 = GoogleFonts.montserrat(
    fontSize: AppDimens.textSize28,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static final heading2 = heading1.copyWith(
    fontSize: AppDimens.textSize24,
    fontWeight: FontWeight.w600,
  );

  static final heading3 = heading2.copyWith(fontSize: AppDimens.textSize20);

  // Body Texts
  static final body = GoogleFonts.inter(
    fontSize: AppDimens.textSize16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final bodyLarge = body.copyWith(
    fontSize: AppDimens.textSize18,
    letterSpacing: 0.3,
  );

  static final bodySmall = body.copyWith(
    fontSize: AppDimens.textSize14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Caption / Metadata Texts
  static final caption = GoogleFonts.inter(
    fontSize: AppDimens.textSize12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // Buttons Texts
  static final button = GoogleFonts.montserrat(
    fontSize: AppDimens.textSize16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Input Fields Texts
  static final input = GoogleFonts.inter(
    fontSize: AppDimens.textSize16,
    fontWeight: FontWeight.normal,
  );

  static final inputLabel = GoogleFonts.inter(
    fontSize: AppDimens.textSize14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // Error / Warning Text
  static final error = GoogleFonts.inter(
    fontSize: AppDimens.textSize13,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  // Footer / Copyright
  static final footer = GoogleFonts.inter(
    fontSize: AppDimens.textSize12,
    fontWeight: FontWeight.w300,
    color: AppColors.textHint,
    letterSpacing: 0.2,
  );
}
