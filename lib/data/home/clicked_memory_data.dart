import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClickedMemoryData {
  // ignore: non_constant_identifier_names
  static String _SHARED_PREF_NUMBER_KEY =
      'lib/data/home/clicked_memory_data.dart:_SHARED_PREF_NUMBER_KEY';

  Future<HashMap<int, bool>> getClickedNumbersAsMap() async {
    HashMap<int, bool> clickedNumbers = HashMap();
    final prefs = await SharedPreferences.getInstance();
    String resStr = prefs.getString(_SHARED_PREF_NUMBER_KEY);

    if (resStr == null) resStr = '';

    resStr.split(' ').forEach((element) {
      if (element.isNotEmpty) {
        clickedNumbers[int.parse(element)] = true;
      }
    });
    return clickedNumbers;
  }

  Future<bool> addClickedNumber(int newNumber) async {
    final prefs = await SharedPreferences.getInstance();

    String resStr = await prefs.getString(_SHARED_PREF_NUMBER_KEY);

    if (resStr == null || resStr.isEmpty) {
      resStr = ' ${newNumber.toString()} ';
    } else {
      // if number already added return false
      if (resStr.contains(' ${newNumber.toString()} ')) {
        return false;
      }
      resStr += '${newNumber.toString()} ';
    }
    // add new number to memory
    debugPrint(
        'New clicked number being added in clicked_memory_data.dart -> $newNumber, resultingString = $resStr');
    prefs.setString(_SHARED_PREF_NUMBER_KEY, resStr);
    return true;
  }
}
