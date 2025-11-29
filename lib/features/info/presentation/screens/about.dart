import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/utils/ui_utils.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: AppStrings.about,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.question, size: 120),
              UiUtils.addVerticalSpaceL(),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    UiUtils.addVerticalSpaceS(),
                    Text(
                      AppStrings.placeholderParagraph2,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              _addDividerWithVerticalSpace(),

              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(AppStrings.inspiration, style: AppTextStyles.heading2),
                    UiUtils.addVerticalSpaceS(),
                    Text(
                      AppStrings.placeholderParagraph,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              _addDividerWithVerticalSpace(),

              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(AppStrings.howItWorks, style: AppTextStyles.heading2),
                    UiUtils.addVerticalSpaceS(),
                    Text(
                      AppStrings.placeholderParagraph2,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              _addDividerWithVerticalSpace(),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(AppStrings.developer, style: AppTextStyles.heading1),
                    UiUtils.addVerticalSpaceM(),
                    const CircleAvatar(
                      radius: AppDimens.dimen64,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: AppDimens.dimen86,
                      ), // TODO fix color
                    ),
                    UiUtils.addVerticalSpaceM(),
                    Text(
                      AppStrings.placeholderParagraph2,
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              _addDividerWithVerticalSpace(),

              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      AppStrings.contactDetails,
                      style: AppTextStyles.heading2,
                    ),
                    UiUtils.addVerticalSpaceS(),
                    _buildContactTile(
                      title: AppStrings.email,
                      subtitle: AppStrings.devEmail,
                      leading: Icon(Icons.email),
                    ),
                    UiUtils.addVerticalSpaceXS(),
                    _buildContactTile(
                      title: AppStrings.phone,
                      subtitle: AppStrings.devMobileNo,
                      leading: Icon(Icons.call),
                    ),
                    UiUtils.addVerticalSpaceXS(),
                    _buildContactTile(
                      title: AppStrings.github,
                      subtitle: AppStrings.devGithubUsername,
                      leading: Icon(Icons.code),
                    ),
                  ],
                ),
              ),
              UiUtils.addVerticalSpaceXL(),
              UiUtils.addCopyright(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required String title,
    required String subtitle,
    required Widget leading,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
      tileColor: AppColors.surface,
      leading: leading,
      trailing: IconButton(onPressed: null, icon: Icon(Icons.open_in_new)),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _addDividerWithVerticalSpace() {
    return Column(
      children: [
        UiUtils.addVerticalSpaceXXL(),
        UiUtils.addDivider(),
        UiUtils.addVerticalSpaceXXL(),
      ],
    );
  }
}
