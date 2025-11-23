import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/features/posts/presentation/providers/create_post_state.dart';
import 'package:pump/features/posts/presentation/providers/post_providers.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/domain/entities/user.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';
import '../../../../core/routes.dart';
import '../../../../core/utils/navigation_utils.dart';
import '../../../../core/utils/ui_utils.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  final User currentUser;

  const CreatePostScreen({super.key, required this.currentUser});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    // Listeners
    ref.listen<CreatePostState>(createPostViewModelProvider, (previous, next) {
      if (previous?.isLoading == true && next.isLoading == false) {
        if (next.errorMessage == null) {
          if (!mounted) return;
          UiUtils.showSnackBarSuccess(
            context,
            message: AppStrings.successfullyCreatedPost,
          );
          NavigationUtils.replaceWith(context, AppRoutes.mainFeed);
        } else {
          if (!mounted) return;
          UiUtils.showSnackBarError(context, message: next.errorMessage!);
        }
      }
    });

    final createPostState = ref.watch(createPostViewModelProvider);
    final createPostViewModel = ref.watch(createPostViewModelProvider.notifier);

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return CustomScaffold(
      isLoading: createPostState.isLoading,
      appBarTitle: AppStrings.createPost,
      appBarActions: [
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.paperPlane,
            size: AppDimens.dimen20,
          ),
          onPressed: () {
            final title = titleController.text.trim();
            final description = descriptionController.text.trim();
            createPostViewModel.createPost(title, description);
          },
        ),
      ],
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info row
              Row(
                children: [
                  widget.currentUser.profileImageUrl == null
                      ? CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: AppDimens.radiusL,
                          child: Text(
                            widget.currentUser.firstName[0],
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(
                            widget.currentUser.profileImageUrl!,
                          ),
                          radius: AppDimens.radiusL,
                        ),
                  UiUtils.addHorizontalSpaceS(),
                  Text(
                    '${widget.currentUser.firstName} ${widget.currentUser.lastName}',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              UiUtils.addVerticalSpaceM(),

              // Title TextField
              TextField(
                controller: titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: AppStrings.whatsOnYourMind,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                style: AppTextStyles.heading3,
              ),

              UiUtils.addVerticalSpaceS(),

              // Description TextField
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
