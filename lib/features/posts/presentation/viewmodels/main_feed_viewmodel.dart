import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/presentation/viewmodels/base_viewmodel.dart';
import 'package:pump/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:pump/features/posts/domain/usecases/like_post_usecase.dart';
import 'package:pump/features/posts/presentation/providers/main_feed_state.dart';

import '../../../../core/utilities/logger_utility.dart';
import '../../domain/helpers/post_like_helpers.dart';

class MainFeedViewmodel extends BaseViewmodel<MainFeedState> {
  final GetPostsUseCase _getPostsUseCase;
  final LikePostUseCase _likePostUseCase;

  MainFeedViewmodel(this._getPostsUseCase, this._likePostUseCase)
    : super(MainFeedState.initial());

  @override
  MainFeedState copyWithState({bool? isLoading, String? errorMessage}) {
    return state.copyWith(isLoading: isLoading, errorMessage: errorMessage);
  }

  // Helper methods ------------------------------------------------------------
  void incrementCommentCount(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(commentsCount: post.commentsCount + 1);
      }
      return post;
    }).toList();

    state = state.copyWith(posts: updatedPosts);
  }

  // getPosts ------------------------------------------------------------------
  Future<void> getPosts() async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [getPosts]");

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    await AsyncHelper.runUI(
      () async {
        final response = await _getPostsUseCase.execute();
        if (response.isSuccess) {
          state = state.copyWith(
            isLoading: false,
            posts: response.data,
            errorMessage: null,
          );
        } else {
          LoggerUtility.d(runtimeType.toString(), response.error);
          emitError(response.error!.message);
        }
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.getPosts",
    );
  }

  // likePost ------------------------------------------------------------------
  Future<void> likePost(String postId) async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [likePost]");

    final post = state.posts.firstWhere((p) => p.id == postId);
    final wasLiked = post.isLikedByCurrentUser;

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    state = state.copyWith(
      posts: wasLiked
          ? PostLikeHelpers.applyLocalUnlikeToList(state.posts, postId)
          : PostLikeHelpers.applyLocalLikeToList(state.posts, postId),
    );

    await AsyncHelper.runUI(
      () async {
        final response = await _likePostUseCase.execute(postId);

        if (response.isSuccess) {
          state = state.copyWith(
            post: response.data,
            isLoading: false,
            errorMessage: null,
          );
        } else {
          LoggerUtility.d(runtimeType.toString(), response.error);
          emitError(response.error!.message);
        }
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.likePost",
    );
  }
}
