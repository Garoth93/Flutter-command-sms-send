import 'package:test4/data/local/app_database.dart';
import 'package:test4/data/model/local/command.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';

class CommandRepositoryImpl implements CommandRepository {
  final AppDatabase _appDatabase;

  CommandRepositoryImpl(this._appDatabase);

  @override
  Future<List<CommandEntity>> getCommands() async {
    return await _appDatabase.commandDAO.getCommands();
  }

  @override
  Future<void> remove(CommandEntity command) {
    return _appDatabase.commandDAO
        .deleteCommand(CommandModel.fromEntity(command));
  }

  @override
  Future<void> save(CommandEntity command) {
    return _appDatabase.commandDAO
        .insertCommand(CommandModel.fromEntity(command));
  }

  @override
  Future<void> update(CommandEntity command) {
    return _appDatabase.commandDAO
        .updateCommand(CommandModel.fromEntity(command));
  }

  @override
  Future<CommandEntity?> getById(int id) {
    return _appDatabase.commandDAO.getById(id);
  }

  @override
  Future<void> deleteAll() {
    return _appDatabase.commandDAO.deleteAll();
  }
}
