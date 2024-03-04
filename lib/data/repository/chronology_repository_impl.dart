import 'package:test4/data/local/app_database.dart';
import 'package:test4/data/model/local/chronology.dart';
import 'package:test4/data/model/local/command.dart';
import 'package:test4/domain/entity/chronology.dart';
import 'package:test4/domain/entity/command.dart';
import 'package:test4/domain/repository/abstract_chronology_repository.dart';

class ChronologyRepositoryImpl implements ChronologyRepository {
  final AppDatabase _appDatabase;

  ChronologyRepositoryImpl(this._appDatabase);

  @override
  Future<List<ChronologyEntity>> getChronology() async {
    return await _appDatabase.chronologyDAO.getChronology();
  }

  @override
  Future<void> save(ChronologyEntity chronology) {
    return _appDatabase.chronologyDAO
        .insertChronology(ChronologyModel.fromEntity(chronology));
  }

  @override
  Future<void> deleteAll() {
    return _appDatabase.chronologyDAO.deleteAll();
  }
}
