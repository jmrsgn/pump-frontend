import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/features/posts/domain/entities/post.dart';
import 'package:pump/features/posts/domain/usecases/create_comment_usecase.dart';
import 'package:pump/features/posts/presentation/providers/post_info_state.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/utilities/logger_utility.dart';
import '../providers/post_providers.dart';

class PostInfoViewModel extends StateNotifier<PostInfoState> {
  final Ref ref;
  final CreateCommentUseCase _createCommentUseCase;

  PostInfoViewModel(this.ref, this._createCommentUseCase)
    : super(PostInfoState.initial());

  void emitError(String errorMessage) async {
    state = state.copyWith(isLoading: false, errorMessage: errorMessage);
  }

  void loadInitialComments(List<Comment> initialComments) {
    state = state.copyWith(comments: initialComments);
  }

  void _addLocalComment(Comment tempComment) {
    state = state.copyWith(comments: [...state.comments, tempComment]);
  }

  void _replaceLocalComment(Comment temp, Comment server) {
    final updated = state.comments.map((c) {
      return c == temp ? server : c;
    }).toList();

    state = state.copyWith(comments: updated);
  }

  void _rollbackLocalComment(Comment tempComment) {
    final updated = state.comments.where((c) => c != tempComment).toList();
    state = state.copyWith(comments: updated);
  }

  Future<void> createComment(String comment, String postId) async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Create temporary comment
    // TODO: get current user logged in
    final tempComment = Comment(
      userName: "You",
      userProfileImageUrl: "",
      comment: comment,
      likesCount: 0,
      repliesCount: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _addLocalComment(tempComment);

    // Call API
    try {
      final response = await _createCommentUseCase.execute(
        comment.trim(),
        postId,
      );
      if (response.isSuccess) {
        final serverComment = response.data!;

        _replaceLocalComment(tempComment, serverComment);

        // Update Feed comment count
        ref
            .read(mainFeedViewModelProvider.notifier)
            .incrementCommentCount(postId);

        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          createdComment: serverComment,
        );
      } else {
        _rollbackLocalComment(tempComment);
        LoggerUtility.d(runtimeType.toString(), response.error);
        emitError(response.error!.message);
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      emitError(AppStrings.anUnexpectedErrorOccurred);
    }
  }

  void clearCreatedComment() {
    state = state.copyWith(createdComment: null);
  }
}
