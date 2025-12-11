import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/presentation/viewmodels/base_viewmodel.dart';
import 'package:pump/core/utilities/logger_utility.dart';

import '../../../../core/presentation/providers/ui_state.dart';
import '../../domain/usecases/logout_usecase.dart';

class LogoutViewmodel extends BaseViewmodel<UiState> {
  final LogoutUseCase _logoutUseCase;

  LogoutViewmodel(this._logoutUseCase) : super(UiState.initial());

  @override
  UiState copyWithState({bool? isLoading, String? errorMessage}) {
    return state.copyWith(isLoading: isLoading, errorMessage: errorMessage);
  }

  // logout --------------------------------------------------------------------
  Future<void> logout() async {
    LoggerUtility.d(runtimeType.toString(), "Execute method: [logout]");

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    AsyncHelper.runUI(
      () async {
        await _logoutUseCase.execute();
        state = state.copyWith(isLoading: false);
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.logout",
    );
  }
}
