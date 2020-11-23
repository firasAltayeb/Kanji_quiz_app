import 'package:flutter/material.dart';

import './main_body.dart';
import './widgets/misc_pages/user_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji Quiz App',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage())),
            ),
          ],
        ),
        body: MainBody());
  }
}
