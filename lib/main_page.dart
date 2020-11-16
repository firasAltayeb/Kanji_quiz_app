import 'package:Kanji_quiz_app/home_page.dart';
import 'package:flutter/material.dart';

const int _blackPrimaryValue = 0xFF000000;

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      title: 'Kanji Quiz App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kanji Quiz App'),
        ),
        body: HomePage(),
      ),
    );
  }
}
