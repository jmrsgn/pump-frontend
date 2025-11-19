import 'package:pump/core/presentation/providers/ui_state.dart';

import '../../domain/entities/post.dart';

class PostInfoState extends UiState {
  final Comment? comment;

  const PostInfoState({super.isLoading, super.errorMessage, this.comment});

  @override
  PostInfoState copyWith({bool? isLoading, String? errorMessage, Post? post}) {
    return PostInfoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      comment: comment ?? comment,
    );
  }

  factory PostInfoState.initial() {
    return const PostInfoState(
      isLoading: false,
      errorMessage: null,
      comment: null,
    );
  }
}
