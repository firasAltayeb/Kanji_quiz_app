import 'package:flutter/material.dart';

class SrsDifficultyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'SRS difficulty is: Easy',
          style: TextStyle(
            fontSize: screenHeight * 0.035,
            fontFamily: 'Anton',
          ),
        ),
        CircleAvatar(
          radius: (screenHeight * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (screenHeight * 0.03) + 4,
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: () {},
              iconSize: screenHeight * 0.04,
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: (screenHeight * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (screenHeight * 0.03) + 4,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () {},
              iconSize: screenHeight * 0.04,
              icon: Icon(
                Icons.arrow_upward,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
