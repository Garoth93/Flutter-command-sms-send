import 'package:floor/floor.dart';
import 'package:test4/data/model/local/command.dart';

@dao
abstract class CommandDao {
  @Insert()
  Future<void> insertCommand(CommandModel command);

  @Update()
  Future<void> updateCommand(CommandModel command);

  @delete
  Future<void> deleteCommand(CommandModel command);

  @Query('SELECT * FROM comandi')
  Future<List<CommandModel>> getCommands();

  @Query('SELECT * FROM comandi where id = :id')
  Future<CommandModel?> getById(int id);

  @Query('DELETE FROM comandi')
  Future<void> deleteAll();
}
