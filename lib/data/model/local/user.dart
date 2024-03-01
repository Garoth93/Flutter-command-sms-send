import 'package:floor/floor.dart';
import 'package:test4/domain/entity/user.dart';

@Entity(tableName: 'user',primaryKeys: ['username'])
class UserModel extends UserEntity {

  const UserModel({
    required String username,
    required String password,
  }): super(
    username: username,
    password: password,
  );

  factory UserModel.fromJson(Map < String, dynamic > map) {
    return UserModel(
      username: map['username'],
      password: map['password'],
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        username: entity.username,
        password: entity.password
    );
  }
}