import 'package:pump/core/data/dto/result.dart';
import 'package:pump/core/domain/exceptions/data_provider_exception.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../constants/app/app_error_strings.dart';

class AsyncHelper {
  AsyncHelper._();

  static Future<void> runUI(
    Future<void> Function() action, {
    required void Function(String message) onError,
    required String tag,
  }) async {
    try {
      await action();
    } catch (e, stack) {
      LoggerUtility.e("AsyncHelper.runUI", tag, e, stack);
      onError(AppErrorStrings.anUnexpectedErrorOccurred);
    }
  }

  static Future<Result<T, AppError>> runRepo<T>(
    Future<T> Function() action, {
    required String tag,
  }) async {
    try {
      final data = await action();
      return Result.success(data);
    } catch (e, stack) {
      LoggerUtility.e("AsyncHelper.runRepo", tag, e, stack);

      // Message will be shown displayed in UI

      if (e is DataProviderException) {
        return Result.failure(AppError(message: e.message));
      } else {
        return Result.failure(
          AppError(message: AppErrorStrings.anUnexpectedErrorOccurred),
        );
      }
    }
  }
}
