import 'package:test4/domain/entity/user.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();

  Future<UserEntity?> getByUsername(String username);

  Future<void> save(UserEntity user);

  Future<void> remove(UserEntity user);

  Future<void> deleteAll();
}
