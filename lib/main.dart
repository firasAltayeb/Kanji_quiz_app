import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:Kanji_quiz_app/main_home.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('kanjiBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji Quiz App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: primaryBlack,
        accentColor: Colors.yellow[700],
        fontFamily: 'Lato',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            side: BorderSide(width: 3, color: Colors.black),
            primary: Colors.yellow[700],
            padding: const EdgeInsets.all(10),
            minimumSize: Size(30, 30),
            onPrimary: Colors.black,
          ),
        ),
      ),
      home: MyHome(),
    );
  }
}
