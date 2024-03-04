import 'package:get_it/get_it.dart';
import 'package:test4/app/utils/constants.dart';
import 'package:test4/data/local/app_database.dart';
import 'package:test4/data/repository/chronology_repository_impl.dart';
import 'package:test4/data/repository/command_repository_impl.dart';
import 'package:test4/data/repository/user_repository_impl.dart';
import 'package:test4/domain/repository/abstract_chronology_repository.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';
import 'package:test4/domain/repository/abstract_user_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client

  // Data - Remote

  // Data - Local
  final database =
      await $FloorAppDatabase.databaseBuilder(databaseName).build();

  injector.registerSingleton<AppDatabase>(database);

  // Data - Repository
  injector.registerSingleton<UserRepository>(UserRepositoryImpl(injector()));
  injector
      .registerSingleton<CommandRepository>(CommandRepositoryImpl(injector()));
  injector.registerSingleton<ChronologyRepository>(
      ChronologyRepositoryImpl(injector()));

  // Domain

  // ViewModel
}
