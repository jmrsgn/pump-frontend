import 'package:pump/core/presentation/providers/ui_state.dart';

import '../../domain/entities/post.dart';

class PostInfoState extends UiState {
  final List<Comment> comments;
  final Comment? createdComment;

  const PostInfoState({
    super.isLoading,
    super.errorMessage,
    required this.comments,
    this.createdComment,
  });

  @override
  PostInfoState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Comment>? comments,
    Comment? createdComment,
  }) {
    return PostInfoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      comments: comments ?? this.comments,
      createdComment: createdComment ?? this.createdComment,
    );
  }

  factory PostInfoState.initial() {
    return const PostInfoState(
      isLoading: false,
      errorMessage: null,
      comments: [],
      createdComment: null,
    );
  }
}
