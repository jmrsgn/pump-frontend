import '../entities/post.dart';

class PostLikeHelpers {
  /// Apply local like to a specific post in the list using postId
  static List<Post> applyLocalLikeToList(List<Post> posts, String postId) {
    return posts.map((p) {
      if (p.id == postId) {
        return p.copyWith(
          likesCount: p.likesCount + 1,
          isLikedByCurrentUser: true,
        );
      }
      return p;
    }).toList();
  }

  /// Apply local unlike
  static List<Post> applyLocalUnlikeToList(List<Post> posts, String postId) {
    return posts.map((p) {
      if (p.id == postId) {
        return p.copyWith(
          likesCount: p.likesCount > 0 ? p.likesCount - 1 : 0,
          isLikedByCurrentUser: false,
        );
      }
      return p;
    }).toList();
  }

  /// Apply local like for a single post
  static Post applyLocalLikeSingle(Post post) {
    return post.copyWith(
      likesCount: post.likesCount + 1,
      isLikedByCurrentUser: true,
    );
  }

  /// Apply local unlike for a single post
  static Post applyLocalUnlikeSingle(Post post) {
    return post.copyWith(
      likesCount: post.likesCount > 0 ? post.likesCount - 1 : 0,
      isLikedByCurrentUser: false,
    );
  }
}
