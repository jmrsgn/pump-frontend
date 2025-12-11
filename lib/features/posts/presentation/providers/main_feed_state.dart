import 'package:pump/core/presentation/providers/ui_state.dart';

import '../../domain/entities/post.dart';

class MainFeedState extends UiState {
  final List<Post> posts;
  final Post post;

  const MainFeedState({
    required super.isLoading,
    super.errorMessage,
    required this.posts,
    required this.post,
  });

  @override
  MainFeedState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Post>? posts,
    Post? post,
  }) {
    return MainFeedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      posts: posts ?? this.posts,
      post: post ?? this.post,
    );
  }

  factory MainFeedState.initial() {
    return MainFeedState(
      isLoading: false,
      errorMessage: null,
      posts: const [],
      post: Post.empty(),
    );
  }
}
