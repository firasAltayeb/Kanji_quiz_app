import 'package:flutter/material.dart';

import 'package:Kanji_quiz_app/main_body.dart';
import 'widgets/misc_pages/user_page.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Home is called');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Kanji Quiz App'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage())),
            ),
          ],
        ),
        body: MainBody());
  }
}
