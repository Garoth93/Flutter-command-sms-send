import 'package:floor/floor.dart';
import 'package:test4/data/model/local/user.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> insertUser(UserModel user);

  @delete
  Future<void> deleteUser(UserModel user);

  @Query('SELECT * FROM user')
  Future<List<UserModel>> getUsers();

  @Query('SELECT * FROM user where username = :username')
  Future<UserModel?> getByUsername(String username);

  @Query('DELETE FROM user')
  Future<void> deleteAll();
}
