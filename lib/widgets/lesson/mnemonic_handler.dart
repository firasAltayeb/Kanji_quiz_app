import 'package:Kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:Kanji_quiz_app/widgets/misc/back_pressed_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MnemonicHandler extends StatelessWidget {
  final Function updateHandler;
  final Function hideShowHandler;
  final Map<String, Object> itemDetails;
  final mnemonicController = TextEditingController();

  final Function resetItemStatus;

  MnemonicHandler({
    @required this.itemDetails,
    @required this.updateHandler,
    @required this.hideShowHandler,
    this.resetItemStatus,
  });

  Widget build(BuildContext context) {
    return Row(
      children: [
        if (resetItemStatus != null)
          Expanded(
            child: gestureContainer(
              context,
              _resetItem,
              "Reset item",
              Colors.red,
            ),
          ),
        Expanded(
          child: gestureContainer(
            context,
            _launchURL,
            "Kanji Koohii",
            Colors.green,
          ),
        ),
        Expanded(
          child: gestureContainer(
            context,
            _editMnemonicClicked,
            "Edit Mnemonic",
            Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }

  Widget gestureContainer(ctx, handler, btnText, color) {
    return GestureDetector(
      onTap: () => handler(ctx),
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.135,
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
      resetItemStatus(itemDetails);
      Navigator.of(context).pop();
    }
  }

  void _launchURL(BuildContext context) async {
    String url = 'https://kanji.koohii.com/study/kanji/' +
        '${itemDetails['frameNumber']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _editMnemonicClicked(BuildContext context) {
    hideShowHandler();
    Navigator.of(context)
        .push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return InputDialogScreen(itemDetails);
          }),
    )
        .then((passedText) {
      if (passedText != null) {
        updateHandler(passedText);
      }
      hideShowHandler();
    });
  }
}
