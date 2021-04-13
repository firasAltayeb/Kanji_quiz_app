import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/widgets/misc/back_pressed_alert.dart';
import 'package:kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class MnemonicHandler extends StatelessWidget {
  final Kanji itemDetails;
  final Function showHandler;

  final mnemonicController = TextEditingController();

  final Function resetItemStatus;

  MnemonicHandler({
    @required this.itemDetails,
    @required this.showHandler,
    this.resetItemStatus,
  });

  Widget build(BuildContext context) {
    return Row(
      children: [
        if (resetItemStatus != null)
          Expanded(
            child: bottomButton(
              context,
              _resetItem,
              "Reset item",
              Colors.red,
            ),
          ),
        Expanded(
          child: bottomButton(
            context,
            _launchURL,
            "Kanji Koohii",
            Colors.green,
          ),
        ),
        Consumer(builder: (context, watch, _) {
          return Expanded(
            child: bottomButton(
              context,
              (ctx) {
                showHandler(false);
                _editMnemonicHandler(ctx);
              },
              "Edit Mnemonic",
              Theme.of(context).accentColor,
            ),
          );
        }),
      ],
    );
  }

  Widget bottomButton(ctx, handler, btnText, color) {
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
      resetItemStatus();
      Navigator.of(context).pop();
    }
  }

  void _launchURL(BuildContext context) async {
    String url =
        'https://kanji.koohii.com/study/kanji/' + '${itemDetails.frameNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _editMnemonicHandler(BuildContext context) {
    Navigator.of(context)
        .push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return InputDialogScreen(itemDetails);
          }),
    )
        .then((passedText) {
      showHandler(true);
    });
  }
}
