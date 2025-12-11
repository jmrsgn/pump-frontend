import 'package:pump/core/domain/entities/user.dart';
import 'package:pump/core/presentation/providers/ui_state.dart';

class UserState extends UiState {
  final User? user;

  const UserState({required super.isLoading, super.errorMessage, this.user});

  @override
  UserState copyWith({bool? isLoading, String? errorMessage, User? user}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }

  factory UserState.initial() {
    return const UserState(isLoading: false, errorMessage: null, user: null);
  }
}
