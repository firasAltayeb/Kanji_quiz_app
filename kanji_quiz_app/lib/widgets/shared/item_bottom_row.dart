import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ItemBottomRow extends ConsumerWidget {
  final int lsnQueueIdx;
  final List<StudyItem> lessonList;

  final Function showBottomRow;
  final bool itemDetailScreen;
  final mnemonicController = TextEditingController();

  ItemBottomRow({
    this.lessonList,
    this.lsnQueueIdx,
    @required this.showBottomRow,
    @required this.itemDetailScreen,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final showAlert = watch(showAlertProvider).state;
    final targetItem = watch(targetItemProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        if (itemDetailScreen || targetItem.progressLevel == 7)
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => resetChoiceDialog(
                context: context,
                targetItem: targetItem,
                showAlert: showAlert,
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
            targetItem.progressLevel == 7
                ? null
                : () => completeChoiceDialog(
                      context: context,
                      targetItem: targetItem,
                      alertMessage: "This item will be marked as learned",
                      lsnQueueIdx: lsnQueueIdx,
                      lsnList: lessonList,
                      showAlert: showAlert,
                      naviPop: itemDetailScreen ? true : false,
                    ),
            "Mark Complete",
            targetItem.progressLevel == 7 ? Colors.grey : Colors.green,
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
