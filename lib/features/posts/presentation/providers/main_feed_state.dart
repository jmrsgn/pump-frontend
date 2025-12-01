import 'package:pump/core/presentation/providers/ui_state.dart';

import '../../domain/entities/post.dart';

class MainFeedState extends UiState {
  final List<Post> posts;

  const MainFeedState({
    super.isLoading,
    super.errorMessage,
    required this.posts,
  });

  @override
  MainFeedState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Post>? posts,
  }) {
    return MainFeedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
    );
  }

  factory MainFeedState.initial() {
    return const MainFeedState(isLoading: false, errorMessage: null, posts: []);
  }
}
