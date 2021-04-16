import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class CorrectIncorrectButton extends ConsumerWidget {
  final Kanji reviewItem;
  final bool selectChoice;
  final Function answerQuestion;

  CorrectIncorrectButton({
    @required this.reviewItem,
    @required this.selectChoice,
    @required this.answerQuestion,
  });

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    var screenHeight = MediaQuery.of(bldCtx).size.height;
    var screenWidth = MediaQuery.of(bldCtx).size.width;
    return Container(
      height: screenHeight * 0.38,
      width: screenWidth * 0.5,
      decoration: BoxDecoration(
        color: selectChoice ? Colors.green : Colors.red,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 1.0, color: Colors.black),
          right: BorderSide(width: 1.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
      ),
      child: TextButton(
        child: Text(
          selectChoice ? "Correct" : "Incorrect",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          //_openCustomDialog(bldCtx, reviewItem, screenHeight);
          bldCtx.read(recallButtonVisibleProvider).state = true;
          answerQuestion(selectChoice);
        },
      ),
    );
  }

  // void _openCustomDialog(context, Kanji questionItem, height) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.2),
  //     barrierDismissible: true,
  //     barrierLabel: '',
  //     pageBuilder: (context, animation1, animation2) {
  //       return null;
  //     },
  //     transitionBuilder: (context, a1, a2, widget) {
  //       return Transform.scale(
  //         scale: a1.value,
  //         child: Opacity(
  //           opacity: a1.value,
  //           child: AlertDialog(
  //             backgroundColor:
  //                 selectChoice ? Colors.green[700] : Colors.red[700],
  //             shape:
  //                 OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
  //             content: Text(
  //               'The item ${questionItem.characterLook} SRS' +
  //                   ' level is now ${questionItem.progressLevel}',
  //               style: TextStyle(
  //                 fontSize: height * 0.04,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //     transitionDuration: Duration(milliseconds: 100),
  //   );
  // }
}
