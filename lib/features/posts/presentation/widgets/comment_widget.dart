import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/constants/app/app_strings.dart';
import 'package:pump/core/utils/time_utils.dart';
import 'package:pump/features/posts/domain/entities/post.dart';
import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/utils/ui_utils.dart';

class CommentWidget extends ConsumerStatefulWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends ConsumerState<CommentWidget>
    with RebuildEveryMinute {
  @override
  void initState() {
    super.initState();
    startMinuteRebuild();
  }

  @override
  void dispose() {
    stopMinuteRebuild();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final relativeTime = TimeUtils.timeAgo(widget.comment.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          widget.comment.userProfileImageUrl == null ||
                  widget.comment.userProfileImageUrl!.isEmpty
              ? CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: AppDimens.radiusL,
                  child: Text(
                    widget.comment.userName[0],
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(
                    widget.comment.userProfileImageUrl!,
                  ),
                  radius: AppDimens.radiusL,
                ),

          UiUtils.addHorizontalSpaceM(),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comment.userName,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
                UiUtils.addVerticalSpaceXS(),
                Text(widget.comment.comment, style: AppTextStyles.bodySmall),
                UiUtils.addVerticalSpaceXS(),
                Row(
                  children: [
                    Text(
                      relativeTime,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                    UiUtils.addHorizontalSpaceXL(),
                    Text(
                      AppStrings.like,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                    UiUtils.addHorizontalSpaceXL(),
                    Text(
                      AppStrings.reply,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.solidThumbsUp,
                      color: AppColors.info,
                      size: AppDimens.dimen12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
