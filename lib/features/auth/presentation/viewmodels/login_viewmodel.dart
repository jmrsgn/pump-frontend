import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/providers/ui_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginViewModel extends StateNotifier<UiState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(UiState.initial());

  void emitError(String errorMessage) async {
    state = state.copyWith(isLoading: false, errorMessage: errorMessage);
  }

  Future<void> login(String email, String password) async {
    // Reset state
    state = state.copyWith(isLoading: true, errorMessage: null);

    if (email.trim().isEmpty || password.trim().isEmpty) {
      emitError(AppStrings.emailAndPasswordAreRequired);
      return;
    }

    // Call API
    try {
      final response = await _loginUseCase.execute(email, password);
      if (response.isSuccess) {
        state = state.copyWith(isLoading: false, errorMessage: null);
      } else {
        LoggerUtility.d(runtimeType.toString(), response.error);
        emitError(response.error!.message);
      }
    } catch (e, stackTrace) {
      LoggerUtility.e(
        runtimeType.toString(),
        AppStrings.anUnexpectedErrorOccurred,
        e.toString(),
        stackTrace,
      );
      emitError(AppStrings.anUnexpectedErrorOccurred);
    }
  }
}
