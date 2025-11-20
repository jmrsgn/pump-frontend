import 'package:flutter/material.dart';
import 'package:pump/core/constants/app/app_dimens.dart';
import 'package:pump/core/constants/app/app_strings.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';
import 'package:pump/core/presentation/theme/app_text_styles.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/core/utils/ui_utils.dart';

class ClientInfoScreen extends StatelessWidget {
  const ClientInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(AppStrings.clientInfo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.defaultScreenPadding),
          child: Column(
            children: [
              // Basic Info Card
              Card(
                color: AppColors.surface,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: AppDimens.dimen36,
                    backgroundImage: AssetImage("assets/images/jm.jpg"),
                  ),
                  title: Text(
                    "John Martin Marasigan",
                    style: AppTextStyles.heading3,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                color: AppColors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.dimen12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.physicalStats,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      UiUtils.addVerticalSpaceL(),
                      _buildStatRow(AppStrings.height, '163 cm'),
                      _buildStatRow(AppStrings.weight, '64.35 kg'),
                      _buildStatRow(AppStrings.bodyFat, '20%'),
                      _buildStatRow(AppStrings.muscleMass, '40 kg'),
                    ],
                  ),
                ),
              ),

              // Training Info Card
              _buildCard(AppStrings.trainingInfo, [
                _buildListTile(
                  AppStrings.programTemplate("Sample program"),
                  subtitle: AppStrings.startDateTemplate("Oct 2025"),
                ),
                _buildListTile(AppStrings.frequencyTemplate("4x/week")),
                _buildListTile(
                  AppStrings.lastWorkout,
                  subtitle: "Nov 20, 2025",
                ),
              ]),

              // Nutrition Info Card
              _buildCard(AppStrings.nutritionInfo, [
                _buildListTile(AppStrings.dailyCaloriesTemplate("2583 cal")),
                _buildListTile(
                  AppStrings.macrosTemplate("194g", "291g", "72g"),
                ),
                _buildListTile(AppStrings.mealPlanTemplate("Lean Bulk")),
              ]),

              // Progress & Analytics Card
              _buildCard(AppStrings.progressAndAnalytics, [
                _buildListTile(AppStrings.nextCheckInTemplate("Nov 23, 2025")),
                _buildListTile(
                  AppStrings.graphsAndProgressPhotos,
                  subtitle: AppStrings.tapToViewChartsAndPhotos,
                  onTap: () => {},
                ),
              ]),

              // Coaching Notes & Communication
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
      ),
    );
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
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
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
          : Text(subtitle, style: AppTextStyles.bodySmall),
      onTap: onTap,
    );
  }

  Widget _buildCard(String title, List<Widget> tiles) {
    return Card(
      color: AppColors.surface,
      child: ExpansionTile(
        collapsedIconColor: AppColors.textOnPrimary,
        iconColor: AppColors.textOnPrimary,
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        children: tiles,
      ),
    );
  }
}
