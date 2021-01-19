import 'package:flutter/material.dart';

class BackPressedAlert {
  Future<bool> dialog(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        actionsPadding: const EdgeInsets.fromLTRB(0, 0, 45, 20),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        title: Text(
          'Are you sure?',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Anton',
          ),
        ),
        content: Text(
          "Your current session changes will not be saved!!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          _dialogButton('No', () => Navigator.of(context).pop(false)),
          SizedBox(width: 30),
          _dialogButton('Yes', () => Navigator.of(context).pop(true)),
        ],
      ),
    );
  }

  Widget _dialogButton(String displayedText, Function selectHandler) {
    return RaisedButton(
      shape: CircleBorder(
        side: BorderSide(color: Colors.black, width: 2),
      ),
      padding: EdgeInsets.all(15),
      color: Colors.black,
      onPressed: () => selectHandler(),
      child: Text(
        displayedText,
        style: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
