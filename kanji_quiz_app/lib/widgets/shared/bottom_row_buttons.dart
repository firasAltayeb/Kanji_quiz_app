import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import '../../main_providers.dart';

class ItemBottomRow extends ConsumerWidget {
  final mnemonicController = TextEditingController();

  final List<StudyItem> lessonList;
  final Function showBottomRow;
  final bool itemDetailScreen;
  final StudyItem passedItem;
  final int lsnQueueIdx;

  ItemBottomRow({
    @required this.itemDetailScreen,
    @required this.showBottomRow,
    this.lsnQueueIdx,
    this.passedItem,
    this.lessonList,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final showAlert = watch(showAlertProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    StudyItem targetItem =
        passedItem != null ? passedItem : lessonList[lsnQueueIdx];
    print(targetItem.learningStatus);
    return Row(
      children: [
        if (itemDetailScreen || targetItem.learningStatus != "Lesson")
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => resetChoiceDialog(
                context: context,
                showAlert: showAlert,
                targetItem: targetItem,
                lsnQueueIdx: lsnQueueIdx,
                alertMessage: "All your changes will be undo",
                naviPop: itemDetailScreen ? true : false,
              ),
              "Undo Changes",
              Colors.red,
            ),
          ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            targetItem.learningStatus == "Acquired"
                ? () => null
                : () => completeChoiceDialog(
                      context: context,
                      lsnList: lessonList,
                      showAlert: showAlert,
                      targetItem: targetItem,
                      lsnQueueIdx: lsnQueueIdx,
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
              showBottomRow(false);
              editMnemonicHandler(
                context,
                targetItem,
                showBottomRow,
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
      onTap: () => handler(),
      child: Container(
        height: screenHeight * 0.135,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 3.0, color: Colors.black),
            left: BorderSide(width: 1.0, color: Colors.black),
            right: BorderSide(width: 1.0, color: Colors.black),
            bottom: BorderSide(width: 3.0, color: Colors.black),
          ),
          color: color,
        ),
        child: FittedBox(
          child: Text(
            btnText,
            style: TextStyle(
              fontFamily: 'Anton',
            ),
          ),
        ),
      ),
    );
  }
}
