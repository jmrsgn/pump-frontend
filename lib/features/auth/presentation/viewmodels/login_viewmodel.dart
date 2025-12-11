import 'package:pump/core/constants/app/ui_constants.dart';
import 'package:pump/core/presentation/viewmodels/base_viewmodel.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/domain/helpers/async_helper.dart';
import '../../../../core/presentation/providers/ui_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginViewModel extends BaseViewmodel<UiState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(UiState.initial());

  @override
  UiState copyWithState({bool? isLoading, String? errorMessage}) {
    return state.copyWith(isLoading: isLoading, errorMessage: errorMessage);
  }

  // login ---------------------------------------------------------------------
  Future<void> login(String email, String password) async {
    LoggerUtility.d(
      runtimeType.toString(),
      "Execute method: [login] email: $email, password: $password",
    );

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    if (email.trim().isEmpty || password.trim().isEmpty) {
      return emitError(AppStrings.emailAndPasswordAreRequired);
    }

    if (!UIConstants.emailRegex.hasMatch(email.trim())) {
      return emitError(AppStrings.enterAValidEmail);
    }

    if (password.length < UIConstants.minimumPasswordLength) {
      return emitError(AppStrings.passwordMustBeAtLeast6Characters);
    }

    await AsyncHelper.runUI(
      () async {
        final response = await _loginUseCase.execute(
          email.trim(),
          password.trim(),
        );

        if (response.isSuccess) {
          state = state.copyWith(isLoading: false, errorMessage: null);
        } else {
          emitError(response.error!.message);
        }
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.login",
    );
  }
}
