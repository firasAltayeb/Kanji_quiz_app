import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class ItemBottomRow extends ConsumerWidget {
  final bool showResetButton;
  final Function showHandler;
  final List<Kanji> lessonList;
  final mnemonicController = TextEditingController();

  ItemBottomRow({
    this.lessonList,
    @required this.showHandler,
    @required this.showResetButton,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final targetKanji = watch(targetKanjiProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        if (showResetButton)
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => openChoiceDialog(
                watch,
                context,
                targetKanji,
                resetItemStatus,
                "This item will be sent back to the lesson queue!!",
              ),
              "Reset status",
              Colors.red,
            ),
          ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            targetKanji.progressLevel == 6
                ? null
                : () => openChoiceDialog(
                      watch,
                      context,
                      targetKanji,
                      markAsComplete,
                      targetKanji.itemType != "Kanji"
                          ? "This item will be marked as learned"
                          : "This item will be sent to the practice queue!!",
                      lessonList,
                    ),
            "Mark Complete",
            targetKanji.progressLevel == 6 ? Colors.grey : Colors.green,
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
        padding: btnText == "Kanji Koohii"
            ? const EdgeInsets.all(15)
            : const EdgeInsets.all(5),
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
