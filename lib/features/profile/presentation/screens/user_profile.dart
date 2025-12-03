import 'package:flutter/material.dart';
import 'package:pump/core/utils/ui_utils.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/domain/entities/user.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';

class UserProfileScreen extends StatelessWidget {
  final User currentUser;

  const UserProfileScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: AppStrings.profile,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.paddingScreen),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  UiUtils.addVerticalSpaceS(),
                  currentUser.profileImageUrl == null
                      ? CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: AppDimens.radius48,
                          child: Text(
                            currentUser.firstName[0],
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: AppDimens.textSize48,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(
                            currentUser.profileImageUrl!,
                          ),
                          radius: AppDimens.radius48,
                        ),

                  UiUtils.addVerticalSpaceM(),

                  Text(
                    "${currentUser.firstName} ${currentUser.lastName}",
                    style: AppTextStyles.heading2,
                  ),
                  Text(currentUser.email, style: AppTextStyles.bodySmall),

                  UiUtils.addVerticalSpaceS(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: AppColors.success,
                        size: AppDimens.dimen8,
                      ),
                      UiUtils.addHorizontalSpaceXS(),
                      Text(AppStrings.active, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
            UiUtils.addVerticalSpaceXL(),
            _buildProfileSettingsTitle(
              title: AppStrings.editProfile,
              leading: Icon(Icons.edit),
            ),
            UiUtils.addVerticalSpaceXS(),
            _buildProfileSettingsTitle(
              title: AppStrings.paymentMethod,
              leading: Icon(Icons.payment),
            ),
            UiUtils.addVerticalSpaceXS(),
            _buildProfileSettingsTitle(
              title: AppStrings.clients,
              leading: Icon(Icons.group),
            ),
            UiUtils.addVerticalSpaceXS(),
            _buildProfileSettingsTitle(
              title: AppStrings.coach,
              leading: Icon(Icons.person),
            ),
            UiUtils.addVerticalSpaceXS(),
            _buildProfileSettingsTitle(
              title: AppStrings.help,
              leading: Icon(Icons.help),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSettingsTitle({
    required String title,
    required Widget leading,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      tileColor: AppColors.surface,
      leading: leading,
      trailing: IconButton(
        onPressed: null,
        icon: Icon(Icons.keyboard_arrow_right),
      ),
      title: Text(title),
    );
  }
}
