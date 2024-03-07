import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/chronology.dart';
import 'package:test4/domain/repository/abstract_chronology_repository.dart';

class GetChronologyUseCase {
  final ChronologyRepository _chronologyRepository =
      injector<ChronologyRepository>();

  Future<bool> saveChronology(ChronologyEntity chronology) async {
    try {
      await _chronologyRepository.save(chronology);
      return true;
    } catch (error) {
      return false;
    }
  }
}
