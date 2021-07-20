import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class ItemBottomRow extends ConsumerWidget {
  final mnemonicController = TextEditingController();

  final List<StudyItem> lessonList;
  final bool itemDetailScreen;
  final StudyItem passedItem;
  final int lsnQueueIdx;

  ItemBottomRow({
    @required this.itemDetailScreen,
    this.lsnQueueIdx,
    this.passedItem,
    this.lessonList,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final screenHeight = MediaQuery.of(context).size.height;
    final showAlert = watch(showAlertProvider).state;

    //checks whether detail or lesson screen called
    StudyItem targetItem =
        passedItem != null ? passedItem : lessonList[lsnQueueIdx];
    return Row(
      children: [
        if (itemDetailScreen || targetItem.learningStatus != "Lesson")
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => resetChoiceDialog(
                watch: watch,
                context: context,
                showAlert: showAlert,
                targetItem: targetItem,
                naviPop: itemDetailScreen ? true : false,
                alertMessage: "All your changes will be undo",
              ),
              "Undo Changes",
              Colors.red,
            ),
          ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            targetItem.learningStatus == "Acquired"
                ? null
                : () => markAsPracticeDialog(
                      watch: watch,
                      context: context,
                      showAlert: showAlert,
                      targetItem: targetItem,
                      wrapSession: lessonList.length <= lsnQueueIdx + 1,
                      alertMessage: targetItem.itemType == "Kanji" &&
                              targetItem.learningStatus != "Practice"
                          ? "This item will be moved to the practice queue"
                          : "This item will be marked as acquired",
                      naviPop: itemDetailScreen ? true : false,
                    ),
            //button label text
            targetItem.learningStatus != "Practice" &&
                    targetItem.itemType == "Kanji" &&
                    targetItem.learningStatus != "Acquired"
                ? "Practice Ready"
                : "Mark As Acquired",
            //button background color
            targetItem.learningStatus == "Acquired"
                ? Colors.grey
                : Colors.green,
          ),
        ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            () {
              editDataHandler(
                studyItem: targetItem,
                buildContext: context,
                forKeyword: false,
              );
            },
            "Edit Mnemonic",
            Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  Widget _bottomButton(screenHeight, handler, btnText, color) {
    return GestureDetector(
      onTap: handler,
      child: Container(
        height: screenHeight * 0.125,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.black),
            left: BorderSide(width: 0.5, color: Colors.black),
            right: BorderSide(width: 0.5, color: Colors.black),
            bottom: BorderSide(width: 1.0, color: Colors.black),
          ),
          color: color,
        ),
        child: FittedBox(
          child: Text(
            btnText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
