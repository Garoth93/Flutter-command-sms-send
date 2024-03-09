import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';

class DeleteAllCommandsUseCase {
  final CommandRepository _commandRepository = injector<CommandRepository>();

  Future<bool> deleteAllCommand() async {
    try {
      await _commandRepository.deleteAll();
      return true;
    } catch (error) {
      return false;
    }
  }
}
