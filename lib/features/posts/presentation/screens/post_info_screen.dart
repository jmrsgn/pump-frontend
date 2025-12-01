import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/constants/app/app_dimens.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/core/utils/time_utils.dart';
import 'package:pump/core/utils/ui_utils.dart';
import 'package:pump/features/posts/domain/entities/post.dart';
import 'package:pump/features/posts/presentation/providers/post_info_state.dart';
import 'package:pump/features/posts/presentation/providers/post_providers.dart';
import 'package:pump/features/posts/presentation/widgets/comment_widget.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/app_text_input.dart';

class PostInfoScreen extends ConsumerStatefulWidget {
  final Post post;

  const PostInfoScreen({super.key, required this.post});

  @override
  ConsumerState<PostInfoScreen> createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends ConsumerState<PostInfoScreen>
    with RebuildEveryMinute {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Focus on the input and show keyboard after first frame
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // FocusScope.of(context).requestFocus(_focusNode);

    // // Scroll to bottom if needed
    // _scrollToBottom();
    // });

    // Load initial comments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialComments =
          widget.post.comments
              ?.where((c) => c != null) // remove null items
              .map((c) => c!) // convert Comment? → Comment
              .toList() ??
          []; // default empty list
      ref
          .read(postInfoViewModelProvider.notifier)
          .loadInitialComments(initialComments);
    });

    startMinuteRebuild();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    stopMinuteRebuild();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final relativeTime = TimeUtils.timeAgo(widget.post.createdAt);

    final postInfoViewModel = ref.watch(postInfoViewModelProvider.notifier);
    final postInfoState = ref.watch(postInfoViewModelProvider);

    final comments = postInfoState.comments;

    // Listen for new comments and scroll down
    ref.listen<PostInfoState>(postInfoViewModelProvider, (previous, next) {
      if (previous != null &&
          previous.comments.length != next.comments.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        isLoading: postInfoState.isLoading,
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            // -------- FIXED NON-SCROLLING POST CONTENT --------
            Padding(
              padding: const EdgeInsets.all(AppDimens.spaceS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(relativeTime),
                  UiUtils.addVerticalSpaceS(),
                  _buildPostInfo(),
                  UiUtils.addVerticalSpaceS(),
                  _buildActionButtons(),
                  UiUtils.addVerticalSpaceL(),
                  _buildLikesAndShares(),
                ],
              ),
            ),

            // -------- ONLY COMMENTS SCROLL --------
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spaceS,
                ),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final c = comments[index];

                  return Column(
                    children: [
                      CommentWidget(comment: c),
                      if (index < comments.length - 1)
                        UiUtils.addVerticalSpaceL(),
                    ],
                  );
                },
              ),
            ),

            // -------- FIXED INPUT AT BOTTOM --------
            AppTextInput(
              controller: _commentController,
              focusNode: _focusNode,
              onSend: () {
                postInfoViewModel.createComment(
                  _commentController.text.trim(),
                  widget.post.id,
                );
                _commentController.clear();
              },
              onAttach: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String relativeTime) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: AppDimens.radiusL,
          child: Text(
            widget.post.userName[0],
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        UiUtils.addHorizontalSpaceM(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.userName,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              relativeTime,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textDisabled,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.post.title, style: AppTextStyles.heading3),
        UiUtils.addVerticalSpaceS(),
        Text(widget.post.description, style: AppTextStyles.body),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _iconLabel(FontAwesomeIcons.thumbsUp, AppStrings.like),
        _iconLabel(FontAwesomeIcons.comment, AppStrings.comment),
        _iconLabel(FontAwesomeIcons.share, AppStrings.share),
      ],
    );
  }

  Widget _iconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textDisabled, size: AppDimens.dimen16),
        UiUtils.addHorizontalSpaceS(),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textDisabled,
          ),
        ),
      ],
    );
  }

  Widget _buildLikesAndShares() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.solidThumbsUp,
              color: AppColors.info,
              size: AppDimens.dimen12,
            ),
            UiUtils.addHorizontalSpaceS(),
            Text(
              '${widget.post.likesCount}',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          '${widget.post.sharesCount} ${AppStrings.shares}',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
