import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:Kanji_quiz_app/main_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('kanjiBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    print('MaterialApp is called');
    return MaterialApp(
      title: 'Kanji Quiz App',
      home: MyHome(),
    );
  }
}
