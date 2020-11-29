import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:Kanji_quiz_app/main_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('MaterialApp is called');
    return MaterialApp(
      title: 'Kanji Quiz App',
      home: FutureBuilder(
        future: Hive.openBox('kanjiMap'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return MyHome();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    print('hive disposed');
    Hive.close();
    super.dispose();
  }
}
