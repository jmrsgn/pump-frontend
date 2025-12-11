import 'package:pump/core/constants/app/app_error_strings.dart';
import 'package:pump/core/domain/exceptions/data_provider_exception.dart';
import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/core/utilities/logger_utility.dart';
import 'package:pump/core/utils/secure_storage.dart';

import '../../../../core/data/dto/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../dto/auth_response_dto.dart';
import '../dto/login_request_dto.dart';
import '../dto/register_request_dto.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._authService, {SecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? SecureStorage();

  // login ---------------------------------------------------------------------
  @override
  Future<Result<AuthResponse, AppError>> login(LoginRequest request) async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [login]");

    return AsyncHelper.runRepo<AuthResponse>(() async {
      final result = await _authService.login(request);

      if (result.isSuccess) {
        final auth = result.data!;

        // Save tokens & user
        if (auth.token != null) {
          await _secureStorage.saveToken(auth.token!);
          await _secureStorage.saveCurrentLoggedInUser(
            auth.userResponse!.toUser(),
          );
        }

        return auth;
      } else {
        throw DataProviderException(
          message: result.error!.message ?? AppErrorStrings.userLoginFailed,
          statusCode: result.error?.status,
        );
      }
    }, tag: "${runtimeType.toString()}.login");
  }

  // register ------------------------------------------------------------------
  @override
  Future<Result<AuthResponse, AppError>> register(
    RegisterRequest request,
  ) async {
    return AsyncHelper.runRepo<AuthResponse>(() async {
      final result = await _authService.register(request);

      if (result.isSuccess) {
        return result.data!;
      } else {
        throw DataProviderException(
          message:
              result.error!.message ?? AppErrorStrings.userRegistrationFailed,
          statusCode: result.error?.status,
        );
      }
    }, tag: "${runtimeType.toString()}.register");
  }

  @override
  Future<void> logout() async {
    await _secureStorage.deleteCurrentLoggedInUser();
    await _secureStorage.deleteToken();
  }
}
