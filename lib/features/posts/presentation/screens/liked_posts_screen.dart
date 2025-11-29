import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';

class LikedPostsScreen extends StatelessWidget {
  const LikedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: AppStrings.likedPosts,
      backgroundColor: AppColors.background,
      body: Center(child: Text("Liked Posts")),
    );
  }
}
