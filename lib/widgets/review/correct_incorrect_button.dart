import 'package:flutter/material.dart';

class CorrectIncorrectButton extends StatelessWidget {
  final bool selectChoice;
  final Function answerQuestion;
  final Function showRecallButton;
  final Map<String, Object> questionItem;

  CorrectIncorrectButton({
    @required this.selectChoice,
    @required this.answerQuestion,
    @required this.showRecallButton,
    @required this.questionItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        color: selectChoice ? Colors.green : Colors.red,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.white,
        child: Text(
          selectChoice ? "Correct" : "Incorrect",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          answerQuestion(selectChoice, context);
          _openCustomDialog(
              context,
              'The item ${questionItem['itemId']} SRS' +
                  ' level is now ${questionItem['progressLevel']}');
          showRecallButton();
        },
      ),
    );
  }

  void _openCustomDialog(BuildContext context, String dialogText) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return null;
      },
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor:
                  selectChoice ? Colors.green[700] : Colors.red[700],
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              content: Text(
                dialogText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 100),
    );
  }
}
