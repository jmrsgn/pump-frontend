import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/core/presentation/providers/user_state.dart';
import 'package:pump/core/domain/usecases/get_user_profile_usecase.dart';

import '../../constants/app/app_strings.dart';

class UserViewModel extends StateNotifier<UserState> {
  final GetUserProfileUseCase _getCurrentUserUseCase;

  UserViewModel(this._getCurrentUserUseCase) : super(UserState.initial());

  Future<void> initializeCurrentUser() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _getCurrentUserUseCase.execute();

    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        user: result.data?.user,
        errorMessage: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.error?.message ?? AppStrings.failedToFetchUserData,
      );
    }
  }
}
