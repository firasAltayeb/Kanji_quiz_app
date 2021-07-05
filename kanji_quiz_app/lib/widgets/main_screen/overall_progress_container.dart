import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class OverallProgressContainer extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          child: _bottomButton(
            screenHeight,
            "Learned: ",
            10,
            Colors.red[400],
          ),
        ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            "Reviewed: ",
            10,
            Colors.orange[400],
          ),
        ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            "Practiced: ",
            10,
            Colors.blue[400],
          ),
        ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            "Acquired: ",
            10,
            Colors.green[400],
          ),
        ),
      ],
    );
  }

  Widget _bottomButton(screenHeight, labelTxt, counterTxt, color) {
    return Container(
      height: screenHeight * 0.175,
      padding: const EdgeInsets.only(top: 5, left: 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
        color: color,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              labelTxt,
              style: TextStyle(
                fontSize: screenHeight * 0.02,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Text(
            "$counterTxt",
            style: TextStyle(
              fontSize: screenHeight * 0.05,
              fontFamily: 'Anton',
            ),
          ),
        ],
      ),
    );
  }
}