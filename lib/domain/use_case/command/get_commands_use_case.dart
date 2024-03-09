import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';

class GetCommandsUseCase {
  final CommandRepository _commandRepository = injector<CommandRepository>();

  Future<List<CommandEntity>> getCommands() async {
    return await _commandRepository.getCommands();
  }
}
