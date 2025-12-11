import 'dart:io';

import 'package:pump/core/constants/api/api_error_strings.dart';
import 'package:pump/core/data/exceptions/auth_exception.dart';
import 'package:pump/core/data/exceptions/server_exception.dart';

import '../../utilities/logger_utility.dart';
import '../dto/api_error_response.dart';
import '../dto/result.dart';

abstract class BaseService {
  /// Wraps HTTP calls with try/catch + logging + generic error handling
  Future<Result<T, ApiErrorResponse>> callApi<T>(
    Future<Result<T, ApiErrorResponse>> Function() action, {
    required String tag,
  }) async {
    try {
      return await action();
    } catch (e, stackTrace) {
      if (e is ServerException) {
        LoggerUtility.e(
          tag,
          "Status: ${e.statusCode}",
          e.toString(),
          stackTrace,
        );
        return Result.failure(
          parseError(e.message, e.statusCode!, error: e.error!),
        );
      } else if (e is AuthException) {
        LoggerUtility.e(
          tag,
          "Status: ${e.statusCode}",
          e.toString(),
          stackTrace,
        );
        return Result.failure(
          parseError(e.message, e.statusCode!, error: e.error),
        );
      } else {
        LoggerUtility.e(tag, "Unexpected Error", e.toString(), stackTrace);
      }

      return Result.failure(
        ApiErrorResponse(
          status: HttpStatus.internalServerError,
          message: ApiErrorStrings.anUnexpectedErrorOccurred,
          error: ApiErrorStrings.anUnexpectedErrorOccurred,
        ),
      );
    }
  }

  /// Helper when backend returns an error JSON map
  ApiErrorResponse parseError(String message, int status, {String? error}) {
    return ApiErrorResponse(
      message: message,
      error: error ?? ApiErrorStrings.anUnexpectedErrorOccurred,
      status: status,
    );
  }

  /// Helper to throw a consistent ServerException from backend error JSON
  Never throwServerException(ApiErrorResponse error, int statusCode) {
    throw ServerException(
      message: error.message ?? ApiErrorStrings.anUnexpectedErrorOccurred,
      error: error.error,
      statusCode: statusCode,
    );
  }
}
