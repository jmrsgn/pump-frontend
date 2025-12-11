import 'package:pump/core/constants/app/app_error_strings.dart';
import 'package:pump/core/data/dto/result.dart';
import 'package:pump/core/data/repositories/user_repository_impl.dart';
import 'package:pump/core/domain/entities/authenticated_user.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/features/posts/data/dto/create_post_request_dto.dart';
import 'package:pump/features/posts/data/services/post_service.dart';
import 'package:pump/features/posts/domain/entities/post.dart';

import '../../../../core/utilities/logger_utility.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService _postService;
  final UserRepositoryImpl _userRepositoryImpl;

  PostRepositoryImpl(this._postService, this._userRepositoryImpl);

  @override
  Future<Result<Post, AppError>> createPost(
    String title,
    String description,
  ) async {
    try {
      final Result<AuthenticatedUser, AppError> userResult =
          await _userRepositoryImpl.getAuthenticatedCurrentUser();
      if (userResult.isSuccess) {
        final request = CreatePostRequest(
          title: title,
          description: description,
          userId: userResult.data!.user.id,
        );

        // Create Post Request
        final result = await _postService.createPost(
          userResult.data!.token,
          request,
        );

        if (result.isSuccess && result.data != null) {
          LoggerUtility.v(
            runtimeType.toString(),
            'Created post: ${result.data?.toPost()}',
          );
          return Result.success(result.data?.toPost());
        }
        return Result.failure(userResult.error);
      } else {
        LoggerUtility.e(
          runtimeType.toString(),
          "User id is missing, will not proceed with API call",
        );
        return Result.failure(
          AppError(message: AppErrorStrings.userIsNotAuthenticated),
        );
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppErrorStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      return Result.failure(
        AppError(message: AppErrorStrings.anUnexpectedErrorOccurred),
      );
    }
  }

  @override
  Future<Result<List<Post>, AppError>> getPosts() async {
    try {
      final Result<AuthenticatedUser, AppError> userResult =
          await _userRepositoryImpl.getAuthenticatedCurrentUser();
      if (userResult.isSuccess) {
        // Get all posts request
        final result = await _postService.getPosts(userResult.data!.token);

        if (result.isSuccess && result.data != null) {
          final posts = result.data!.map((e) => e.toPost()).toList();
          LoggerUtility.v(runtimeType.toString(), 'Posts fetched: $posts');
          return Result.success(posts);
        } else {
          return Result.failure(userResult.error);
        }
      } else {
        LoggerUtility.e(
          runtimeType.toString(),
          "User id is missing, will not proceed with API call",
        );
        return Result.failure(
          AppError(message: AppErrorStrings.userIsNotAuthenticated),
        );
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppErrorStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      return Result.failure(
        AppError(message: AppErrorStrings.anUnexpectedErrorOccurred),
      );
    }
  }

  @override
  Future<Result<Post, AppError>> likePost(String postId) async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [likePost]");
    try {
      final Result<AuthenticatedUser, AppError> userResult =
          await _userRepositoryImpl.getAuthenticatedCurrentUser();
      if (userResult.isSuccess) {
        final result = await _postService.likePost(
          userResult.data!.token,
          postId,
        );
        if (result.isSuccess && result.data != null) {
          return Result.success(result.data?.toPost());
        } else {
          return Result.failure(
            AppError(message: AppErrorStrings.anUnexpectedErrorOccurred),
          );
        }
      } else {
        LoggerUtility.e(
          runtimeType.toString(),
          "User id is missing, will not proceed with API call",
        );
        return Result.failure(
          AppError(message: AppErrorStrings.userIsNotAuthenticated),
        );
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppErrorStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      return Result.failure(
        AppError(message: AppErrorStrings.anUnexpectedErrorOccurred),
      );
    }
  }
}
