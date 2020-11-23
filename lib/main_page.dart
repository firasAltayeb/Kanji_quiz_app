import 'package:Kanji_quiz_app/main_body.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji Quiz App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Kanji Quiz App'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 40,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 40,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: HomePage(),
      ),
    );
  }
}
