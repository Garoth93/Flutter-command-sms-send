import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class GetUsersByUsernameUseCase {
  final UserRepository _userRepository = injector<UserRepository>();

  Future<UserEntity?> getUserByUsername(String username) async {
    return await _userRepository.getByUsername(username);
  }
}
