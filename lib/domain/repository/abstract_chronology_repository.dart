import 'package:test4/domain/entity/chronology.dart';

abstract class ChronologyRepository {
  Future<List<ChronologyEntity>> getChronology();

  Future<void> save(ChronologyEntity command);

  Future<void> deleteAll();
}
