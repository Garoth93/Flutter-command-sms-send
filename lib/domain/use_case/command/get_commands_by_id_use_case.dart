import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_command_repository.dart';

class GetCommandByIdUseCase {
  final CommandRepository _commandRepository = injector<CommandRepository>();

  Future<CommandEntity?> getCommandById(int id) async {
    return await _commandRepository.getById(id);
  }
}
