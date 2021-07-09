import 'package:flutter/material.dart';

import '../widgets/screen_main/main_screen_app_bar.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user-screen';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainScreenAppBar(
        appBar: AppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
            size: MediaQuery.of(context).size.height * 0.3,
          ),
          Text(
            "James Jackson",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
