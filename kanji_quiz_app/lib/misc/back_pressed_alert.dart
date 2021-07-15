import 'package:flutter/material.dart';

class BackPressedAlert {
  Future<bool> dialog({@required parentCtx, @required alertMsg}) {
    var screenHeight = MediaQuery.of(parentCtx).size.height;
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
            fontSize: screenHeight * 0.05,
          ),
        ),
        content: Text(
          alertMsg,
          style: TextStyle(
            fontSize: screenHeight * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          _dialogButton('No', context, false, screenHeight),
          _dialogButton('Yes', context, true, screenHeight),
        ],
      ),
    );
  }

  Widget _dialogButton(displayedText, context, choice, height) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.all(height * 0.02),
        shape: CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(choice),
      child: Text(
        displayedText,
        style: TextStyle(
          fontSize: height * 0.035,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
