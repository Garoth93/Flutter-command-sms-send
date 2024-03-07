import 'package:test4/app/di/injector.dart';
import 'package:test4/domain/entity/chronology.dart';
import 'package:test4/domain/repository/abstract_chronology_repository.dart';

class GetChronologyUseCase {
  final ChronologyRepository _chronologyRepository =
      injector<ChronologyRepository>();

  Future<List<ChronologyEntity>> getChronology() async {
    return await _chronologyRepository.getChronology();
  }
}
