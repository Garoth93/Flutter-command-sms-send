import 'package:test4/data/local/app_database.dart';
import 'package:test4/data/model/local/user.dart';
import 'package:test4/domain/entity/user.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AppDatabase _appDatabase;

  UserRepositoryImpl(this._appDatabase);

  @override
  Future<List<UserEntity>> getUsers() async {
    return await _appDatabase.userDAO.getUsers();
  }

  @override
  Future<void> remove(UserEntity user) {
    return _appDatabase.userDAO.deleteUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> save(UserEntity user) {
    return _appDatabase.userDAO.insertUser(UserModel.fromEntity(user));
  }

  @override
  Future<UserEntity?> getByUsername(String username)
  {
    return _appDatabase.userDAO.getByUsername(username);
  }

  @override
  Future<void> deleteAll()
  {
    return _appDatabase.userDAO.deleteAll();
  }

}