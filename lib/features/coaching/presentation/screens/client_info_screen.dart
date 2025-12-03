import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/utils/ui_utils.dart';

class ClientInfoScreen extends StatelessWidget {
  final void Function(int)? onTileTap;

  const ClientInfoScreen({super.key, this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.padding4),
        child: Column(
          children: [
            // Basic Info Card
            Card(
              color: AppColors.surfaceLight,
              child: ListTile(
                leading: CircleAvatar(
                  radius: AppDimens.radius36,
                  backgroundImage: AssetImage("assets/images/jm.jpg"),
                ),
                title: Text(
                  "John Martin Marasigan",
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: AppDimens.textSize18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiUtils.addVerticalSpaceXS(),
                    Text('Age: 25 | Male', style: AppTextStyles.bodySmall),
                    Text(
                      'Active client since Oct 2025',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            // Physical Stats Card
            Card(
              color: AppColors.surfaceLight,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.padding12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.physicalStats,
                      style: AppTextStyles.heading3.copyWith(
                        fontSize: AppDimens.textSize16,
                      ),
                    ),
                    UiUtils.addVerticalSpaceL(),
                    _buildStatRow(AppStrings.height, '163 cm'),
                    _buildStatRow(AppStrings.weight, '64.35 kg'),
                    _buildStatRow(AppStrings.bodyFat, '20%'),
                    _buildStatRow(AppStrings.muscleMass, '30 kg'),
                  ],
                ),
              ),
            ),

            // Training Info
            _buildCard(AppStrings.trainingInfo, [
              _buildListTile(
                AppStrings.programTemplate("Program ni Kuya O"),
                subtitle: AppStrings.startDateTemplate("Oct 2025"),
              ),
              _buildListTile(
                AppStrings.frequencyTemplate("4x/week"),
                subtitle: AppStrings.tapToViewTrainingBlock,
                onTap: () => onTileTap?.call(2),
              ),
              _buildListTile(AppStrings.lastWorkout, subtitle: "Nov 20, 2025"),
            ]),

            // Nutrition
            _buildCard(AppStrings.nutritionInfo, [
              _buildListTile(AppStrings.dailyCaloriesTemplate("2583 cal")),
              _buildListTile(AppStrings.macrosTemplate("194g", "291g", "72g")),
              _buildListTile(AppStrings.mealPlanTemplate("Lean Bulk")),
            ]),

            // Progress & Analytics
            _buildCard(AppStrings.progressAndAnalytics, [
              _buildListTile(AppStrings.nextCheckInTemplate("Nov 23, 2025")),
              _buildListTile(
                AppStrings.graphsAndProgressPhotos,
                subtitle: AppStrings.tapToViewChartsAndPhotos,
                onTap: () => onTileTap?.call(1),
              ),
            ]),

            // Coaching Notes
            _buildCard(AppStrings.coachingNotes, [
              _buildListTile(
                AppStrings.lastNoteTemplate("Overall size, especially chest"),
              ),
              _buildListTile(AppStrings.remindersTemplate("NA")),
            ]),

            // Extras
            _buildCard(AppStrings.extras, [
              _buildListTile(
                AppStrings.supplementsTemplate(
                  "Whey Protein, Creatine, Pre-workout",
                ),
              ),
              _buildListTile(AppStrings.injuriesTemplate("Neck")),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildListTile(String title, {String? subtitle, VoidCallback? onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppDimens.dimen16,
      vertical: 0,
    ),
    title: Text(title, style: AppTextStyles.body),
    subtitle: subtitle == null
        ? null
        : Text(
            subtitle,
            style: onTap == null
                ? AppTextStyles.bodySmall
                : AppTextStyles.bodySmall.copyWith(color: AppColors.info),
          ),
    onTap: onTap,
    dense: true,
    visualDensity: const VisualDensity(vertical: -4), // reduces height
  );
}

Widget _buildCard(String title, List<Widget> tiles) {
  return Card(
    color: AppColors.surfaceLight,
    child: ExpansionTile(
      iconColor: AppColors.textOnPrimary,
      collapsedIconColor: AppColors.textHint,
      title: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          fontSize: AppDimens.textSize16,
          color: AppColors.textOnPrimary,
        ),
      ),
      children: tiles,
    ),
  );
}
