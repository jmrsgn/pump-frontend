import 'package:pump/core/presentation/providers/ui_state.dart';

import '../../domain/entities/post.dart';

class CreatePostState extends UiState {
  final Post? post;

  const CreatePostState({super.isLoading, super.errorMessage, this.post});

  @override
  CreatePostState copyWith({
    bool? isLoading,
    String? errorMessage,
    Post? post,
  }) {
    return CreatePostState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      post: post ?? this.post,
    );
  }

  factory CreatePostState.initial() {
    return const CreatePostState(
      isLoading: false,
      errorMessage: null,
      post: null,
    );
  }
}
