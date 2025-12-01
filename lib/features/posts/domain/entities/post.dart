class Post {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String userName;
  final String? userProfileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final List<Comment?>? comments;

  const Post({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      userName: json['userName'],
      userProfileImageUrl: json['userProfileImageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      sharesCount: json['sharesCount'],
      comments: json['comments'] != null
          ? (json['comments'] as List)
                .map((commentJson) => Comment.fromJson(commentJson))
                .toList()
          : null,
    );
  }

  Post copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userProfileImageUrl,
    String? title,
    String? description,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    List<Comment?>? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, description: $description, userId: $userId, userName: $userName, userProfileImageUrl: $userProfileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, comments: $comments}';
  }
}

class Comment {
  final String userName;
  final String? userProfileImageUrl;
  final String comment;
  final int likesCount;
  final int repliesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Comment({
    required this.userName,
    required this.userProfileImageUrl,
    required this.comment,
    required this.likesCount,
    required this.repliesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: json['userName'],
      userProfileImageUrl: json['userProfileImageUrl'],
      comment: json['comment'],
      likesCount: json['likesCount'],
      repliesCount: json['repliesCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
