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
          body: mainBody(context)),
    );
  }

  Widget mainBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            progressButton(context, "Lesson", "10"),
            progressButton(context, "Review", "30"),
          ],
        ),
      ],
    );
  }

  Widget progressButton(context, String label, String progress) {
    return Column(
      children: [
        Text(
          label + ": " + progress,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 75,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: RaisedButton(
            color: Colors.yellow,
            textColor: Colors.black,
            child: Text(label,
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            onPressed: () {
              navigateToSubPage(context);
            },
          ),
        )
      ],
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => QuizManager()));
  }
}
