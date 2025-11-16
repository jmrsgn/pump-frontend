import 'package:pump/core/data/dto/result.dart';
import 'package:pump/core/data/repositories/user_repository_impl.dart';
import 'package:pump/core/domain/entities/authenticated_user.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/core/utils/secure_storage.dart';
import 'package:pump/features/posts/data/dto/create_post_request_dto.dart';
import 'package:pump/features/posts/data/services/post_service.dart';
import 'package:pump/features/posts/domain/entities/post.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/utilities/logger_utility.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostService _postService;
  final SecureStorage _secureStorage;
  final UserRepositoryImpl _userRepositoryImpl;

  PostRepositoryImpl(
    this._postService,
    this._userRepositoryImpl, {
    SecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? SecureStorage();

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
          AppError(
            error: AppStrings.userIsNotAuthenticated,
            message: AppStrings.userIsNotAuthenticated,
          ),
        );
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      return Result.failure(
        AppError(
          error: AppStrings.anUnexpectedErrorOccurred,
          message: AppStrings.anUnexpectedErrorOccurred,
        ),
      );
    }
  }

  @override
  Future<Result<List<Post>, AppError>> getAllPosts() async {
    try {
      final Result<AuthenticatedUser, AppError> userResult =
          await _userRepositoryImpl.getAuthenticatedCurrentUser();
      if (userResult.isSuccess) {
        // Get all posts request
        final result = await _postService.getAllPosts(userResult.data!.token);

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
          AppError(
            error: AppStrings.userIsNotAuthenticated,
            message: AppStrings.userIsNotAuthenticated,
          ),
        );
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      return Result.failure(
        AppError(
          error: AppStrings.anUnexpectedErrorOccurred,
          message: AppStrings.anUnexpectedErrorOccurred,
        ),
      );
    }
  }
}
