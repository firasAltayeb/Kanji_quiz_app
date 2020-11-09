import 'package:flutter/material.dart';

import 'widgets/quiz_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji Quiz App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kanji Quiz App'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Click button to move to SubPage'),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Go to SubPage'),
                onPressed: () {
                  navigateToSubPage(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuizManager()));
  }
}
