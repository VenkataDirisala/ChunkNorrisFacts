import 'dto/number_dto.dart';

abstract class NumberService {
  Future<List<NumberDto>> getNumberDtos();

  Future<bool> addNewClickedNumber(int newNumber);
}
