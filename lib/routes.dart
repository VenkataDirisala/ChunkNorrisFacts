
import 'package:flutter/cupertino.dart';
import 'package:technical_test/pages/details/details_page.dart';
import 'package:technical_test/pages/home/home_page.dart';

class ChucknorrisRoutes {
  static const home = '/home';
  static const details = '/details';
}

final routes = {
  ChucknorrisRoutes.home: (dynamic _) => HomePage(),
  ChucknorrisRoutes.details: (dynamic _) => DetailsPage(),
};

PageRoute getRoute(String route) {
  return CupertinoPageRoute<dynamic>(
    builder: routes[route],
  );
}
