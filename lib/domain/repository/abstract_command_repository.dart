import 'package:test4/domain/entity/command.dart';

abstract class CommandRepository {
  Future<List<CommandEntity>> getCommands();

  Future<CommandEntity?> getById(int id);

  Future<void> save(CommandEntity command);

  Future<void> update(CommandEntity command);

  Future<void> remove(CommandEntity command);

  Future<void> deleteAll();
}
