import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/grid_view_container.dart';
import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class ResultPage extends ConsumerWidget {
  final List<StudyItem> itemList;
  final List<bool> sessionChoices;

  final Function wrapSession;
  final Function undoLastAnswer;

  ResultPage({
    @required this.itemList,
    @required this.sessionChoices,
    @required this.wrapSession,
    @required this.undoLastAnswer,
  });

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final incorrectRecallList = incorrectItemList(itemList, sessionChoices);
    final correctRecallList = correctItemList(itemList, sessionChoices);
    final sessionScore = watch(sessionScoreProvider).state;
    final screenHeight = MediaQuery.of(bldCtx).size.height;

    return Column(children: [
      SizedBox(height: screenHeight * 0.03),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Your session score is $sessionScore',
            style: TextStyle(
              fontSize: screenHeight * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: Text(
              "Undo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: undoLastAnswer,
          ),
        ],
      ),
      SizedBox(height: screenHeight * 0.05),
      textContainer(
        'Recalled Correctly',
        Colors.green,
        screenHeight,
      ),
      GridViewContainer(
        itemList: correctRecallList,
        widgetHeight: screenHeight * 0.175,
        selectHandler: null,
      ),
      textContainer(
        'Recalled Incorrectly',
        Colors.red,
        screenHeight,
      ),
      GridViewContainer(
        itemList: incorrectRecallList,
        widgetHeight: screenHeight * 0.175,
        selectHandler: null,
      ),
      SizedBox(height: screenHeight * 0.05),
      wrapUpButton(screenHeight),
    ]);
  }

  Widget wrapUpButton(double screenHeight) {
    return Container(
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.yellow[700],
            Colors.orange[300],
          ],
        ),
      ),
      child: ElevatedButton(
        child: Text(
          ' Wrap up session ',
          style: TextStyle(
            fontSize: screenHeight * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          HapticFeedback.vibrate();
          wrapSession();
        },
      ),
    );
  }

  Widget textContainer(String txt, Color backColor, double height) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: backColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: height * 0.035,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
