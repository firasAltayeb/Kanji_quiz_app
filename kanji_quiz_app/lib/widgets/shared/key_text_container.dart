import 'package:flutter/material.dart';
import 'package:kanji_quiz_app/model/study_item_model.dart';

class KeyTextContainer extends StatelessWidget {
  final Function passedFunction;
  final StudyItem targetItem;
  final double widgetHeight;

  KeyTextContainer({
    @required this.targetItem,
    this.passedFunction,
    this.widgetHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textToDisplay =
        targetItem.itemType == "Hiragana" || targetItem.itemType == "Katakana"
            ? 'Reading: ' + targetItem.itemReadings[0]
            : 'Keyword: ' + targetItem.keyword;
    return InkWell(
      onLongPress: passedFunction,
      child: Container(
        width: double.infinity,
        height: widgetHeight,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3.0,
              color: Colors.black,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: FittedBox(
          child: Text(
            textToDisplay,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
