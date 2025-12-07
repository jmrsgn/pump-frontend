import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:pump/features/posts/presentation/providers/main_feed_state.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/utilities/logger_utility.dart';

class MainFeedViewmodel extends StateNotifier<MainFeedState> {
  final GetPostsUseCase _getAllPostsUseCase;

  MainFeedViewmodel(this._getAllPostsUseCase) : super(MainFeedState.initial());

  void emitError(String errorMessage) async {
    state = state.copyWith(isLoading: false, errorMessage: errorMessage);
  }

  Future<void> getPosts() async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _getAllPostsUseCase.execute();
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

  void incrementCommentCount(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(commentsCount: post.commentsCount + 1);
      }
      return post;
    }).toList();

    state = state.copyWith(posts: updatedPosts);
  }
}
