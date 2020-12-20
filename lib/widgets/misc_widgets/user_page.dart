import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
            onPressed: null,
          ),
        ],
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
