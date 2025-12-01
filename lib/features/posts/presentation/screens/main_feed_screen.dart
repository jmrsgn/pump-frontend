import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/core/constants/app/app_strings.dart';
import 'package:pump/core/presentation/providers/user_providers.dart';
import 'package:pump/core/routes.dart';
import 'package:pump/core/utils/navigation_utils.dart';
import 'package:pump/features/posts/presentation/providers/post_providers.dart';
import 'package:pump/features/posts/presentation/widgets/post_widget.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/app_drawer.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class MainFeedScreen extends ConsumerStatefulWidget {
  const MainFeedScreen({super.key});

  @override
  ConsumerState<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends ConsumerState<MainFeedScreen> {
  Future<void> _onRefresh() async {
    await ref.read(mainFeedViewModelProvider.notifier).getAllPosts();
  }

  @override
  void initState() {
    super.initState();

    // Initial load
    Future.microtask(() {
      ref.read(userViewModelProvider.notifier).initializeCurrentUser();
      ref.read(mainFeedViewModelProvider.notifier).getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoutViewModel = ref.watch(logoutViewModelProvider.notifier);
    final userState = ref.watch(userViewModelProvider);
    final feedState = ref.watch(mainFeedViewModelProvider);

    final posts = feedState.posts;

    return CustomScaffold(
      isLoading: userState.isLoading || feedState.isLoading,
      appBarLeadingIcon: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      backgroundColor: AppColors.background,

      drawer: userState.user == null
          ? const SizedBox.shrink()
          : AppDrawer(
              currentUser: userState.user!,
              selectedRoute: AppRoutes.mainFeed,
              onSignOut: () async {
                await logoutViewModel.logout();
                if (context.mounted) {
                  NavigationUtils.replaceWith(context, AppRoutes.login);
                }
              },
            ),

      body: RefreshIndicator.noSpinner(
        onRefresh: _onRefresh,
        child: posts.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: AppDimens.dimen80),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostWidget(
                    post: post,
                    onTap: () => NavigationUtils.navigateTo(
                      context,
                      AppRoutes.postInfo,
                      arguments: post,
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  AppStrings.noPostsAvailable,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ),
      ),

      floatingActionButton: userState.user != null
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
              onPressed: () {
                NavigationUtils.navigateTo(
                  context,
                  AppRoutes.createPost,
                  arguments: userState.user,
                );
              },
            )
          : null,
    );
  }
}
