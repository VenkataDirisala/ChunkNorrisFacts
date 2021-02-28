import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:technical_test/common/constants/general_constants.dart';
import 'package:technical_test/services/home/dto/number_dto.dart';

import '../../service_factory.dart';
import '../number_service.dart';

class NumberServiceImpl extends NumberService {
  ServiceFactory factory = ServiceFactory.instance;

  // save number dtos to memory once and use many times.
  // because data never changes from remote and less operations are made
  List<NumberDto> numberDtos;

  @override
  Future<List<NumberDto>> getNumberDtos() async {
    if (numberDtos != null && numberDtos.isNotEmpty) {
      debugPrint('numberDtos retreived from saved memory, length => ${numberDtos.length}');
      return numberDtos;
    }

    numberDtos = [];

    // get data from 'data'
    HashMap<int, bool> clickedNumbers =
        await factory.getClickedMemoryData().getClickedNumbersAsMap();
    List<bool> isPrime =
        await factory.getPrimeNumberGenerator().getPrimeNumberList(GeneralConstants.END_NUMBER);

    for (int i = GeneralConstants.START_NUMBER; i <= GeneralConstants.END_NUMBER; i++) {
      numberDtos.add(
        NumberDto(
          i,
          isPrime[i],
          clickedNumbers[i] != null && clickedNumbers[i],
        ),
      );
    }
    return numberDtos;
  }

  @override
  Future<bool> addNewClickedNumber(int newNumber) async {
    // if number is already clicked,inform bloc
    if (numberDtos[newNumber - 1].isAlreadyClicked) {
      return false;
    }

    // if number not clicked, add it to clicked memory and inform bloc
    if (await factory.getClickedMemoryData().addClickedNumber(newNumber)) {
      numberDtos[newNumber - 1] = NumberDto(
        numberDtos[newNumber - 1].number,
        numberDtos[newNumber - 1].isPrime,
        true,
      );
      return true;
    }
    // if number is already clicked,inform bloc
    else {
      return false;
    }
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
