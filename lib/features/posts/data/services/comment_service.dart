import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pump/core/constants/api/api_constants.dart';
import 'package:pump/core/constants/app/app_strings.dart';
import 'package:pump/core/data/dto/api_error_response.dart';
import 'package:pump/core/data/dto/result.dart';
import 'package:pump/features/posts/data/dto/create_comment_request_dto.dart';

import '../../../../core/utilities/logger_utility.dart';
import '../dto/post_response_dto.dart';

class CommentService {
  Future<Result<CommentResponse, ApiErrorResponse>> createComment(
    String token,
    CreateCommentRequest request,
    String postId,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.getCommentUrl(postId)),
        headers: {...ApiConstants.headerType, 'Authorization': 'Bearer $token'},
        body: jsonEncode(request.toJson()),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Result.success(CommentResponse.fromJson(json['data']));
      } else {
        final error = ApiErrorResponse.fromJson(json['error']);
        return Result.failure(error);
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      final apiErrorResponse = ApiErrorResponse(
        status: HttpStatus.internalServerError,
        error: AppStrings.anUnexpectedErrorOccurred,
        message: '${AppStrings.anUnexpectedErrorOccurred}: $e',
      );
      return Result.failure(apiErrorResponse);
    }
  }
}
