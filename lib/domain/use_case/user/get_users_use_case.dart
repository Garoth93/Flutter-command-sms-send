import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository = injector<UserRepository>();

  Future<List<UserEntity>> getUsers() async {
    return await _userRepository.getUsers();
  }
}
