
import 'package:flutter/material.dart';
import 'package:technical_test/pages/home/home_page.dart';

import 'common/constants/general_constants.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: GeneralConstants.APP_TITLE,
      home: HomePage(),
    );
  }
}
