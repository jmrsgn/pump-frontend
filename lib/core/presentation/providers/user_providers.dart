import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump/core/domain/usecases/get_user_profile_usecase.dart';
import 'package:pump/core/presentation/providers/user_state.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/user_service.dart';
import '../viewmodels/user_viewmodel.dart';

// Services
final userServiceProvider = Provider<UserService>((ref) => UserService());

// Repositories
final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});

// UseCases
final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>(
  (ref) => GetUserProfileUseCase(ref.watch(userRepositoryProvider)),
);

// ViewModels
final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>((
  ref,
) {
  final repo = ref.watch(userRepositoryProvider);
  final getUserProfileUseCase = GetUserProfileUseCase(repo);
  return UserViewModel(getUserProfileUseCase);
});
