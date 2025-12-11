import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pump/core/constants/api/api_error_strings.dart';
import 'package:pump/core/data/dto/api_error_response.dart';
import 'package:pump/core/data/exceptions/auth_exception.dart';
import 'package:pump/core/data/services/base_service.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../../../core/constants/api/api_constants.dart';
import '../../../../core/data/dto/result.dart';
import '../dto/auth_response_dto.dart';
import '../dto/login_request_dto.dart';
import '../dto/register_request_dto.dart';

class AuthService extends BaseService {
  // login ---------------------------------------------------------------------
  Future<Result<AuthResponse, ApiErrorResponse>> login(LoginRequest request) {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [login]");

    return callApi<AuthResponse>(() async {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: ApiConstants.headerType,
        body: jsonEncode(request.toJson()),
      );

      final json = jsonDecode(response.body);

      // Success
      if (response.statusCode == HttpStatus.ok) {
        return Result.success(AuthResponse.fromJson(json['data']));
      }

      final error = ApiErrorResponse.fromJson(json['error']);

      if (response.statusCode == HttpStatus.unauthorized) {
        throw AuthException(
          error: error.error,
          message: error.message ?? ApiErrorStrings.userIsNotAuthenticated,
          statusCode: HttpStatus.unauthorized,
        );
      }

      throwServerException(json, error.status);
    }, tag: "${runtimeType.toString()}.login");
  }

  // register ------------------------------------------------------------------
  Future<Result<AuthResponse, ApiErrorResponse>> register(
    RegisterRequest request,
  ) async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [register]");

    return callApi<AuthResponse>(() async {
      final response = await http.post(
        Uri.parse(ApiConstants.registerUrl),
        headers: ApiConstants.headerType,
        body: jsonEncode(request.toJson()),
      );

      final json = jsonDecode(response.body);

      // Success
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Result.success(AuthResponse.fromJson(json['data']));
      }

      final error = ApiErrorResponse.fromJson(json['error']);

      if (response.statusCode == HttpStatus.unauthorized) {
        throw AuthException(
          error: error.error,
          message: error.message ?? ApiErrorStrings.userIsNotAuthenticated,
          statusCode: HttpStatus.unauthorized,
        );
      }

      throwServerException(json, error.status);
    }, tag: "${runtimeType.toString()}.register");
  }
}
