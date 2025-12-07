import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/core/domain/usecases/get_user_profile_usecase.dart';
import 'package:pump/features/posts/domain/entities/post.dart';
import 'package:pump/features/posts/domain/usecases/create_comment_usecase.dart';
import 'package:pump/features/posts/domain/usecases/get_comments_usecase.dart';
import 'package:pump/features/posts/presentation/providers/post_info_state.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/domain/entities/user.dart';
import '../../../../core/utilities/logger_utility.dart';
import '../providers/post_providers.dart';

class PostInfoViewModel extends StateNotifier<PostInfoState> {
  final Ref ref;
  final CreateCommentUseCase _createCommentUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetCommentsUseCase _getCommentsUseCase;

  PostInfoViewModel(
    this.ref,
    this._createCommentUseCase,
    this._getUserProfileUseCase,
    this._getCommentsUseCase,
  ) : super(PostInfoState.initial());

  void emitError(String errorMessage) async {
    state = state.copyWith(isLoading: false, errorMessage: errorMessage);
  }

  void loadInitialComments(List<Comment> initialComments) {
    state = state.copyWith(comments: initialComments);
  }

  void _addLocalComment(Comment tempComment) {
    state = state.copyWith(comments: [...state.comments, tempComment]);
  }

  void _rollbackLocalComment(Comment tempComment) {
    final updated = state.comments.where((c) => c != tempComment).toList();
    state = state.copyWith(comments: updated);
  }

  void clearComments() {
    state = state.copyWith(comments: []);
  }

  /// Create comment
  Future<void> createComment(String comment, String postId) async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    final userResponse = await _getUserProfileUseCase.execute();
    if (userResponse.isSuccess) {
      final User? authenticatedUser = userResponse.data?.user;

      // Create temporary comment
      final tempComment = Comment(
        userName:
            "${authenticatedUser?.firstName} ${authenticatedUser?.lastName}",
        userProfileImageUrl: authenticatedUser?.profileImageUrl,
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
    } else {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
      );
      emitError(AppStrings.anUnexpectedErrorOccurred);
    }
  }

  /// Get comments
  Future<void> getComments(String postId) async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _getCommentsUseCase.execute(postId);
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          comments: response.data,
          errorMessage: null,
        );
      } else {
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

  Future<void> likePost(String postId) async {
    // TODO:
  }
}
