import 'dart:collection';
import 'package:technical_test/data/details/asset_json_data.dart';
import 'package:technical_test/data/home/clicked_memory_data.dart';
import 'package:technical_test/data/home/prime_number_generator.dart';

import 'details/chucknorris_service.dart';
import 'details/impl/chucknorris_service_impl.dart';
import 'home/impl/number_service_impl.dart';
import 'home/number_service.dart';

class ServiceFactory {
  static ServiceFactory instance = ServiceFactory();
  static HashMap services = HashMap<Type, Object>();

  ChucknorrisService getChucknorrisService() {
    if (!services.containsKey(ChucknorrisServiceImpl)) {
      services[ChucknorrisService] = ChucknorrisServiceImpl();
    }

    return services[ChucknorrisService] as ChucknorrisService;
  }

  AssetJsonData getAssetJsonData() {
    if (!services.containsKey(AssetJsonData)) {
      services[AssetJsonData] = AssetJsonData();
    }

    return services[AssetJsonData] as AssetJsonData;
  }

  ClickedMemoryData getClickedMemoryData() {
    if (!services.containsKey(ClickedMemoryData)) {
      services[ClickedMemoryData] = ClickedMemoryData();
    }

    return services[ClickedMemoryData] as ClickedMemoryData;
  }

  PrimeNumberGenerator getPrimeNumberGenerator() {
    if (!services.containsKey(PrimeNumberGenerator)) {
      services[PrimeNumberGenerator] = PrimeNumberGenerator();
    }

    return services[PrimeNumberGenerator] as PrimeNumberGenerator;
  }

  NumberService getNumberService() {
    if (!services.containsKey(NumberService)) {
      services[NumberService] = NumberServiceImpl();
    }

    return services[NumberService] as NumberService;
  }
}
