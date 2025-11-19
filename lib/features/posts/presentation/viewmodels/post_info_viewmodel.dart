import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/features/posts/domain/usecases/create_comment_usecase.dart';
import 'package:pump/features/posts/presentation/providers/post_info_state.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/utilities/logger_utility.dart';

class PostInfoViewModel extends StateNotifier<PostInfoState> {
  final CreateCommentUseCase _createCommentUseCase;

  PostInfoViewModel(this._createCommentUseCase)
    : super(PostInfoState.initial());

  void emitError(String errorMessage) async {
    state = state.copyWith(isLoading: false, errorMessage: errorMessage);
  }

  Future<void> createComment(String comment, String postId) async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _createCommentUseCase.execute(
        comment.trim(),
        postId,
      );
      if (response.isSuccess) {
        state = state.copyWith(isLoading: false, errorMessage: null);
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
}
