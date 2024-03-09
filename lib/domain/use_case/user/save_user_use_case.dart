import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class SaveUserUseCase {
  final UserRepository _userRepository = injector<UserRepository>();

  Future<bool> saveUSer(UserEntity user) async {
    try {
      await _userRepository.save(user);
      return true;
    } catch (error) {
      return false;
    }
  }
}
