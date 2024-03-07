import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';

class UpdateCommandUseCase {
  final CommandRepository _commandRepository = injector<CommandRepository>();

  Future<bool> UpdateCommand(CommandEntity command) async {
    try {
      await _commandRepository.update(command);
      return true;
    } catch (error) {
      return false;
    }
  }
}
