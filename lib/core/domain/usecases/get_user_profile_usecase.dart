import 'package:pump/core/domain/entities/authenticated_user.dart';
import 'package:pump/core/errors/app_error.dart';

import '../../data/dto/result.dart';
import '../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository _userRepository;

  GetUserProfileUseCase(this._userRepository);

  Future<Result<AuthenticatedUser, AppError>> execute() async {
    return await _userRepository.getAuthenticatedCurrentUser();
  }
}
