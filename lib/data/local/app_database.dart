import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test4/data/local/DAO/chronology_dao.dart';
import 'package:test4/data/local/DAO/command_dao.dart';
import 'package:test4/data/local/DAO/user_dao.dart';
import 'package:test4/data/model/local/chronology.dart';
import 'package:test4/data/model/local/command.dart';
import 'package:test4/data/model/local/user.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [UserModel, CommandModel, ChronologyModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDAO;

  CommandDao get commandDAO;

  ChronologyDao get chronologyDAO;
}
