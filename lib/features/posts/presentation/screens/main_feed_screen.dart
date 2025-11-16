import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/constants/app/app_dimens.dart';
import 'package:pump/core/constants/app/app_strings.dart';
import 'package:pump/core/presentation/providers/user_providers.dart';
import 'package:pump/core/routes.dart';
import 'package:pump/core/utils/navigation_utils.dart';
import 'package:pump/features/posts/presentation/providers/post_providers.dart';
import 'package:pump/features/posts/presentation/widgets/post_widget.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userViewModelProvider.notifier).initializeCurrentUser();
      ref.read(mainFeedViewModelProvider.notifier).getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoutViewModel = ref.watch(logoutViewModelProvider.notifier);
    final userState = ref.watch(userViewModelProvider);
    final mainFeedState = ref.watch(mainFeedViewModelProvider);

    return CustomScaffold(
      isLoading: userState.isLoading || mainFeedState.isLoading,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.message, size: AppDimens.dimen20),
            onPressed: () =>
                NavigationUtils.navigateTo(context, AppRoutes.messages),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      drawer: userState.user == null
          ? const SizedBox.shrink()
          : AppDrawer(
              currentUser: userState.user!,
              onSignOut: () async {
                await logoutViewModel.logout();
                if (context.mounted) {
                  NavigationUtils.replaceWith(context, AppRoutes.login);
                }
              },
              selectedRoute: AppRoutes.mainFeed,
            ),
      body: mainFeedState.posts != null && mainFeedState.posts!.isNotEmpty
          ? ListView.builder(
              itemCount: mainFeedState.posts!.length,
              itemBuilder: (context, index) {
                return PostWidget(
                  post: mainFeedState.posts![index],
                  onTap: () => NavigationUtils.navigateTo(
                    context,
                    AppRoutes.postInfo,
                    arguments: mainFeedState.posts![index],
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
      floatingActionButton: userState.user != null
          ? FloatingActionButton(
              onPressed: () {
                NavigationUtils.navigateTo(
                  context,
                  AppRoutes.createPost,
                  arguments: userState.user,
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
