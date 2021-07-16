import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/study_item_model.dart';

class StatusInfoColumn extends StatelessWidget {
  final StudyItem targetItem;
  final keywordPressed;
  final screenHeight;
  final screenWidth;

  StatusInfoColumn({
    @required this.keywordPressed,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.targetItem,
  });

  String _fixTimeZone(DateTime time) {
    final _dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    // if (currentTimeZone == 'Asia/Tokyo' &&
    //     DateTime.now().timeZoneName != 'JST') {
    //   time.add(Duration(hours: 9));
    // }
    return _dateFormater.format(time);
  }

  Widget richStatusTxt(txtTodisplay, txtToBold) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: screenWidth * 0.05,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: txtTodisplay,
          ),
          TextSpan(
            text: txtToBold,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (keywordPressed)
      return SizedBox(
        height: screenHeight * 0.2,
      );

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            richStatusTxt(
              "Item status: ",
              targetItem.levelTranslation(),
            ),
            richStatusTxt(
              targetItem.learningStatus == "Acquired"
                  ? "Next review date: already Acquired"
                  : 'Next review date: ',
              '${_fixTimeZone(targetItem.nextReviewDate())}',
            ),
            richStatusTxt(
              'Last change date: ',
              '${_fixTimeZone(targetItem.dateLastLevelChanged)}',
            ),
            richStatusTxt(
              "Number of times reviewed correctly: ",
              "${targetItem.correctReviewNumber()}",
            ),
            richStatusTxt(
              "Number of times practiced correctly: ",
              "${targetItem.correctPracticeNumber()}",
            ),
          ],
        ),
      ),
    );
  }
}
