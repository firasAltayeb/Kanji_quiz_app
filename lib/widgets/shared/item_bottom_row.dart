import 'package:kanji_quiz_app/widgets/misc/back_pressed_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class MnemonicHandler extends ConsumerWidget {
  final Function showHandler;
  final Function resetItemStatus;
  final mnemonicController = TextEditingController();

  MnemonicHandler({
    @required this.showHandler,
    this.resetItemStatus,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final targetKanji = watch(targetKanjiProvider).state;
    var screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        if (resetItemStatus != null)
          Expanded(
            child: _bottomButton(
              screenHeight,
              () => _resetItem(context),
              "Reset item",
              Colors.red,
            ),
          ),
        Expanded(
          child: _bottomButton(
            screenHeight,
            () => launchURL(targetKanji),
            "Kanji Koohii",
            Colors.green,
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

  void _resetItem(BuildContext context) async {
    var dialogChoice = await BackPressedAlert().dialog(
          parentCtx: context,
          alertMsg: "The item will be sent back to the lesson queue!!",
        ) ??
        false;
    if (dialogChoice) {
      resetItemStatus();
      Navigator.of(context).pop();
    }
  }
}
