import 'package:pump/core/errors/app_error.dart';
import 'package:pump/features/posts/domain/entities/post.dart';

import '../../../../core/data/dto/result.dart';

abstract class CommentRepository {
  Future<Result<Comment, AppError>> createComment(
    String comment,
    String postId,
  );

  Future<Result<List<Comment>, AppError>> getComments(String postId);
}
