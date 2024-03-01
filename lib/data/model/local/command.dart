import 'package:floor/floor.dart';
import 'package:test4/domain/entity/command.dart';

@Entity(tableName: 'comandi', primaryKeys: ['id'])
class CommandModel extends CommandEntity {
  const CommandModel({
    int? id,
    required String phoneNumber,
    required String description,
    required String command,
  }) : super(
          id: id,
          phoneNumber: phoneNumber,
          description: description,
          command: command,
        );

  factory CommandModel.fromJson(Map<String, dynamic> map) {
    return CommandModel(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      description: map['description'],
      command: map['command'],
    );
  }

  factory CommandModel.fromEntity(CommandEntity entity) {
    return CommandModel(
        id: entity.id,
        phoneNumber: entity.phoneNumber,
        description: entity.description,
        command: entity.command);
  }
}
