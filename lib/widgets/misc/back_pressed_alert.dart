import 'package:flutter/material.dart';

class BackPressedAlert {
  Future<bool> dialog(
      {@required BuildContext parentCtx, @required String alertMsg}) {
    return showDialog(
      context: parentCtx,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        title: Text(
          'Are you sure?',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.05,
            fontFamily: 'Anton',
          ),
        ),
        content: Text(
          alertMsg,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          _dialogButton('No', context, false),
          _dialogButton('Yes', context, true),
        ],
      ),
    );
  }

  Widget _dialogButton(
      String displayedText, BuildContext context, bool choice) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.all(15),
        shape: CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(choice),
      child: Text(
        displayedText,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
