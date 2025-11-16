import 'package:pump/features/posts/domain/entities/post.dart';

class PostResponse {
  final String id;
  final String title;
  final String? description;
  final String userId;
  final String userName;
  final String? userProfileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final List<CommentResponse?>? comments;

  const PostResponse({
    required this.id,
    required this.title,
    this.description,
    required this.userId,
    required this.userName,
    this.userProfileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.comments,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userProfileImageUrl: json['userProfileImageUrl'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      sharesCount: json['sharesCount'] ?? 0,
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((c) => CommentResponse.fromJson(c))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'comments': comments?.map((c) => c?.toJson()).toList(),
    };
  }

  /// Converts the API model into your domain entity
  Post toPost() {
    return Post(
      id: id,
      title: title,
      description: description ?? '',
      userId: userId,
      userName: userName,
      userProfileImageUrl: userProfileImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      likesCount: likesCount,
      commentsCount: commentsCount,
      sharesCount: sharesCount,
      comments: comments?.map((c) => c?.toComment()).toList(),
    );
  }
}

class CommentResponse {
  final String userName;
  final String? userProfileImageUrl;
  final String comment;
  final int likesCount;
  final int repliesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CommentResponse({
    required this.userName,
    this.userProfileImageUrl,
    required this.comment,
    required this.likesCount,
    required this.repliesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      userName: json['userName'] ?? '',
      userProfileImageUrl: json['userProfileImageUrl'],
      comment: json['comment'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      repliesCount: json['repliesCount'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'comment': comment,
      'likesCount': likesCount,
      'repliesCount': repliesCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Comment toComment() {
    return Comment(
      userName: userName,
      userProfileImageUrl: userProfileImageUrl ?? "",
      comment: comment,
      likesCount: likesCount,
      repliesCount: repliesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
