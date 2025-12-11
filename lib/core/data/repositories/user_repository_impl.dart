import 'package:pump/core/constants/app/app_error_strings.dart';
import 'package:pump/core/data/dto/result.dart';
import 'package:pump/core/domain/entities/authenticated_user.dart';
import 'package:pump/core/domain/exceptions/data_provider_exception.dart';
import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/core/utilities/logger_utility.dart';
import 'package:pump/core/utils/secure_storage.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final SecureStorage _secureStorage;

  UserRepositoryImpl({SecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? SecureStorage();

  // getAuthenticatedCurrentUser -----------------------------------------------
  @override
  Future<Result<AuthenticatedUser, AppError>>
  getAuthenticatedCurrentUser() async {
    LoggerUtility.d(
      runtimeType.toString(),
      "Execute method: [getAuthenticatedCurrentUser]",
    );

    return AsyncHelper.runRepo<AuthenticatedUser>(() async {
      // Check for the token
      final token = await _secureStorage.getToken();
      if (token == null || token.isEmpty) {
        LoggerUtility.e(
          runtimeType.toString(),
          AppErrorStrings.tokenIsMissingWillNotProceedWithApiCall,
        );
        throw DataProviderException(
          message: AppErrorStrings.tokenIsMissingWillNotProceedWithApiCall,
        );
      }

      // Check for stored user
      final user = await _secureStorage.getCurrentLoggedInUser();
      if (user == null) {
        LoggerUtility.e(runtimeType.toString(), AppErrorStrings.userIsMissing);
        throw DataProviderException(
          message: AppErrorStrings.userIsNotAuthenticated,
        );
      }
      return AuthenticatedUser(user: user, token: token);
    }, tag: "${runtimeType.toString()}.getAuthenticatedCurrentUser");
  }
}
