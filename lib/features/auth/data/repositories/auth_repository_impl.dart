import 'package:pump/core/data/dto/api_error_response.dart';
import 'package:pump/core/errors/app_error.dart';
import 'package:pump/core/utilities/logger_utility.dart';
import 'package:pump/core/utils/api_error_utils.dart';
import 'package:pump/core/utils/secure_storage.dart';

import '../../../../core/data/dto/result.dart';
import '../../../../core/data/dto/user_response_dto.dart';
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

  @override
  Future<Result<AuthResponse, AppError>> login(LoginRequest request) async {
    final Result<AuthResponse, ApiErrorResponse> result = await _authService
        .login(request);

    // If token is present, save it to secure storage
    if (result.isSuccess && result.data?.token != null) {
      LoggerUtility.d(runtimeType.toString(), 'Token: ${result.data?.token}');
      await _secureStorage.saveToken(result.data!.token!);
    }

    final UserResponse userResponse = result.data!.userResponse!;
    await _secureStorage.saveCurrentLoggedInUser(userResponse.toUser());

    if (result.isSuccess) {
      return Result.success(result.data!);
    } else {
      LoggerUtility.d(
        runtimeType.toString(),
        "Failed to login user. error: ${result.error}",
      );
      return Result.failure(
        ApiErrorUtils.mapApiErrorResponseToAppError(result.error!),
      );
    }
  }

  @override
  Future<Result<AuthResponse, AppError>> register(
    RegisterRequest request,
  ) async {
    final Result<AuthResponse, ApiErrorResponse> result = await _authService
        .register(request);

    if (result.isSuccess) {
      return Result.success(result.data!);
    } else {
      LoggerUtility.d(
        runtimeType.toString(),
        "Failed to login user. error: ${result.error}",
      );
      return Result.failure(
        ApiErrorUtils.mapApiErrorResponseToAppError(result.error!),
      );
    }
  }

  @override
  Future<String?> getSavedToken() async {
    return _secureStorage.getToken();
  }

  @override
  Future<void> logout() async {
    await _secureStorage.deleteCurrentLoggedInUser();
    await _secureStorage.deleteToken();
  }
}
