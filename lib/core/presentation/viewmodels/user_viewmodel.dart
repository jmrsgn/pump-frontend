import 'package:pump/core/domain/helpers/async_helper.dart';
import 'package:pump/core/domain/usecases/get_user_profile_usecase.dart';
import 'package:pump/core/presentation/providers/user_state.dart';
import 'package:pump/core/presentation/viewmodels/base_viewmodel.dart';
import 'package:pump/core/utilities/logger_utility.dart';

class UserViewModel extends BaseViewmodel<UserState> {
  final GetUserProfileUseCase _getCurrentUserUseCase;

  UserViewModel(this._getCurrentUserUseCase) : super(UserState.initial());

  @override
  UserState copyWithState({bool? isLoading, String? errorMessage}) {
    return state.copyWith(isLoading: isLoading, errorMessage: errorMessage);
  }

  // initializeCurrentUser -----------------------------------------------------
  Future<void> initializeCurrentUser() async {
    LoggerUtility.d(
      runtimeType.toString(),
      "Execute method: [initializeCurrentUser]",
    );

    // Prevent double taps
    if (state.isLoading) return;

    setLoading(true);

    await AsyncHelper.runUI(
      () async {
        final result = await _getCurrentUserUseCase.execute();

        if (result.isSuccess) {
          state = state.copyWith(
            isLoading: false,
            user: result.data?.user,
            errorMessage: null,
          );
        } else {
          emitError(result.error!.message);
        }
      },
      onError: emitError,
      tag: "${runtimeType.toString()}.initializeCurrentUser",
    );
  }
}
