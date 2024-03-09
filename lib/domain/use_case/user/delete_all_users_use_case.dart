import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class DeleteAllUsersUseCase {
  final UserRepository _userRepository = injector<UserRepository>();

  Future<bool> deleteAllUser() async {
    try {
      await _userRepository.deleteAll();
      return true;
    } catch (error) {
      return false;
    }
  }
}
