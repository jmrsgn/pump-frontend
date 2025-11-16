import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';
import '../../../../core/utils/navigation_utils.dart';
import '../widgets/post_widget.dart';

class LikedPostsScreen extends StatelessWidget {
  const LikedPostsScreen({super.key});

  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(AppStrings.likedPosts, style: AppTextStyles.appBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
          onPressed: () {
            NavigationUtils.handleBackNavigation(context);
          },
        ),
      ),
      backgroundColor: AppColors.background,
      body: Center(child: Text("Hello")),
    );
  }
}
