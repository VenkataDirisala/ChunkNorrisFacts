import 'package:flutter/material.dart';

Color getTopColor(int number, bool isPrime) {
  // if number is even set color to red else to green
  Color _topColor = number % 2 == 0 ? Colors.red : Colors.green;

  if (isPrime) {
    _topColor = number % 2 == 0 ? Colors.red : Colors.green;
  }

  return _topColor;
}

Color getBottomColor(int number, bool isPrime) {
  Color _bottomColor = number % 2 == 0 ? Colors.red : Colors.green;
  if (isPrime) {
    _bottomColor = Colors.blue;
  }
  return _bottomColor;
}
