
import 'package:flutter/cupertino.dart';
import 'package:technical_test/data/details/model/chucknorris_response.dart';
import 'package:technical_test/services/details/dto/chuck_norris_dto.dart';

import '../../service_factory.dart';
import '../chucknorris_service.dart';

class ChucknorrisServiceImpl implements ChucknorrisService {
  ServiceFactory factory = ServiceFactory.instance;

  // save Chucknorris list to memory once and use many times.
  // because data never changes and less operations are made
  List<ChucknorrisDto> chucknorrisDtos;

  @override
  Future<List<ChucknorrisDto>> getChucknorrisList() async {
    if (chucknorrisDtos != null && chucknorrisDtos.isNotEmpty) {
      debugPrint(
          'chucknorrisDtos retrieved from saved memory, length => ${chucknorrisDtos.length}');
      return chucknorrisDtos;
    }

    chucknorrisDtos = [];
    List<ChucknorrisResponse> list = await factory.getAssetJsonData().getChucknorrisList();

    for (int i = 0; i < list.length; i++) {
      chucknorrisDtos.add(ChucknorrisDto.fromResponse(list[i], i + 1));
    }

    debugPrint('chucknorrisDtos being retrived from assets, length => ${chucknorrisDtos.length}');
    return chucknorrisDtos;
  }
}
