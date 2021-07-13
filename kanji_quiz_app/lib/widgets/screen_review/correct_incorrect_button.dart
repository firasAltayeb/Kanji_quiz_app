import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/study_item_model.dart';
import '../../main_providers.dart';

class CorrectIncorrectButton extends ConsumerWidget {
  final Function answerQuestion;
  final StudyItem targetItem;
  final bool selectChoice;

  CorrectIncorrectButton({
    @required this.answerQuestion,
    @required this.selectChoice,
    @required this.targetItem,
  });

  Widget build(BuildContext buildContex, ScopedReader watch) {
    final showSrsPop = watch(showSrsPopUpProvider).state;
    var screenHeight = MediaQuery.of(buildContex).size.height;
    var screenWidth = MediaQuery.of(buildContex).size.width;

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
          selectChoice ? "Yes" : "No",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          HapticFeedback.vibrate();
          var characterLook =
              targetItem.itemType != "Primitive" ? targetItem.characterID : "";
          var currentProgressLevel = selectChoice
              ? targetItem.progressLevel + 1
              : targetItem.lapsePenalty();
          if (showSrsPop)
            _openCustomDialog(
              buildContex,
              screenHeight,
              characterLook,
              currentProgressLevel,
            );
          buildContex.read(showAnsBtnVisibleProvider).state = true;
          answerQuestion(selectChoice);
        },
      ),
    );
  }

  void _openCustomDialog(BuildContext ctx, height, kanjiLook, newLvl) {
    showGeneralDialog(
      context: ctx,
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
                'The item $kanjiLook SRS level is now $newLvl',
                style: TextStyle(
                  fontSize: height * 0.04,
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
