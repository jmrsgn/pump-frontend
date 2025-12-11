import 'package:pump/core/errors/app_error.dart';
import 'package:pump/features/posts/domain/entities/post.dart';

import '../../../../core/data/dto/result.dart';

abstract class PostRepository {
  Future<Result<List<Post>, AppError>> getPosts();

  Future<Result<Post, AppError>> createPost(String title, String description);

  Future<Result<Post, AppError>> likePost(String postId);
}
