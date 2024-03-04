import 'package:floor/floor.dart';
import 'package:test4/domain/entity/chronology.dart';

@Entity(tableName: 'chronology', primaryKeys: ['id'])
class ChronologyModel extends ChronologyEntity {
  const ChronologyModel({
    int? id,
    required String phoneNumber,
    required String description,
    required String command,
    required String date,
  }) : super(
            id: id,
            phoneNumber: phoneNumber,
            description: description,
            command: command,
            date: date);

  factory ChronologyModel.fromJson(Map<String, dynamic> map) {
    return ChronologyModel(
        id: map['id'],
        phoneNumber: map['phoneNumber'],
        description: map['description'],
        command: map['command'],
        date: map['date']);
  }

  factory ChronologyModel.fromEntity(ChronologyEntity entity) {
    return ChronologyModel(
        id: entity.id,
        phoneNumber: entity.phoneNumber,
        description: entity.description,
        command: entity.command,
        date: entity.date);
  }
}
