import 'dto/chuck_norris_dto.dart';

abstract class ChucknorrisService {
  Future<List<ChucknorrisDto>> getChucknorrisList();
}
