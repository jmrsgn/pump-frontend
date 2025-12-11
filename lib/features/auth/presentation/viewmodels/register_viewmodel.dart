import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/presentation/viewmodels/base_viewmodel.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/constants/app/ui_constants.dart';
import '../../../../core/presentation/providers/ui_state.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterViewmodel extends BaseViewmodel<UiState> {
  final RegisterUseCase _registerUseCase;

  RegisterViewmodel(this._registerUseCase) : super(UiState.initial());

  @override
  UiState copyWithState({bool? isLoading, String? errorMessage}) {
    return state.copyWith(isLoading: isLoading, errorMessage: errorMessage);
  }

  // Register ------------------------------------------------------------------
  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    int role,
    String password,
  ) async {
    LoggerUtility.d(
      runtimeType.toString(),
      "Execute method: [register] firstName: $firstName, lastName: $lastName email: $email phone: $phone role: $role password: $password",
    );

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    if ([
      firstName,
      lastName,
      email,
      phone,
      password,
    ].any((e) => e.trim().isEmpty)) {
      emitError(AppStrings.allFieldsAreRequired);
      return;
    }

    if (!UIConstants.emailRegex.hasMatch(email.trim())) {
      return emitError(AppStrings.enterAValidEmail);
    }

    if (password.length < UIConstants.minimumPasswordLength) {
      return emitError(AppStrings.passwordMustBeAtLeast6Characters);
    }

    await AsyncHelper.runUI(
      () async {
        final response = await _registerUseCase.execute(
          firstName,
          lastName,
          email,
          phone,
          role,
          password,
        );

        if (response.isSuccess) {
          state = state.copyWith(isLoading: false, errorMessage: null);
        } else {
          LoggerUtility.d(runtimeType.toString(), response.error);
          emitError(response.error!.message);
        }
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.register",
    );
  }
}
