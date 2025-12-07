import 'package:pump/core/errors/app_error.dart';
import 'package:pump/features/posts/domain/entities/post.dart';

import '../../../../core/data/dto/result.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  Future<Result<List<Post>, AppError>> execute() async {
    return await _postRepository.getPosts();
  }
}
