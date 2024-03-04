import 'package:floor/floor.dart';
import 'package:test4/data/model/local/chronology.dart';

@dao
abstract class ChronologyDao {
  @Insert()
  Future<void> insertChronology(ChronologyModel chronology);

  @Query('SELECT * FROM chronology')
  Future<List<ChronologyModel>> getChronology();

  @Query('DELETE FROM chronology')
  Future<void> deleteAll();
}
