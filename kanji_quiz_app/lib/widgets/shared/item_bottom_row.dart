import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ItemBottomRow extends ConsumerWidget {
  final int lsnQueueIdx;
  final List<StudyItem> lessonList;

  final Function showHandler;
  final bool itemDetailScreen;
  final mnemonicController = TextEditingController();

  ItemBottomRow({
    this.lessonList,
    this.lsnQueueIdx,
    @required this.showHandler,
    @required this.itemDetailScreen,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final showAlert = watch(showAlertProvider).state;
    final targetKanji = watch(targetItemProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        if (itemDetailScreen)
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => resetChoiceDialog(
                context: context,
                targetKanji: targetKanji,
                showAlert: showAlert,
                alertMessage:
                    "This item will be sent back to the lesson queue!!",
              ),
              "Reset status",
              Colors.red,
            ),
          ),
        if (!itemDetailScreen && targetKanji.progressLevel >= 6)
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => resetChoiceDialog(
                context: context,
                targetKanji: targetKanji,
                alertMessage: "All your changes will be undo",
                showAlert: showAlert,
                naviPop: false,
              ),
              "Undo Changes",
              Colors.red,
            ),
          ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            targetKanji.progressLevel >= 6
                ? null
                : () => completeChoiceDialog(
                      context: context,
                      targetKanji: targetKanji,
                      alertMessage: targetKanji.itemType != "Kanji"
                          ? "This item will be marked as learned"
                          : "This item will be sent to the practice queue!!",
                      lsnQueueIdx: lsnQueueIdx,
                      lsnList: lessonList,
                      showAlert: showAlert,
                    ),
            "Mark Complete",
            targetKanji.progressLevel >= 6 ? Colors.grey : Colors.green,
          ),
        ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            () {
              showHandler(false);
              editMnemonicHandler(
                context,
                targetKanji,
                showHandler,
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
