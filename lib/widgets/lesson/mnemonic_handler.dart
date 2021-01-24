import 'package:Kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MnemonicHandler extends StatelessWidget {
  final Function hideHandler;
  final Function updateHandler;
  final Map<String, Object> itemDetails;

  MnemonicHandler(this.itemDetails, this.updateHandler, this.hideHandler);

  final mnemonicController = TextEditingController();

  Widget build(BuildContext context) {
    return Row(
      children: [
        gestureContainer(context, _launchURL, "Kanji Koohii"),
        gestureContainer(context, _editMnemonicClicked, "Edit Mnemonic"),
      ],
    );
  }

  Widget gestureContainer(ctx, handler, btnText) {
    return GestureDetector(
      onTap: () => handler(ctx),
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.135,
        width: MediaQuery.of(ctx).size.width * 0.5,
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
          color: btnText == "Kanji Koohii"
              ? Theme.of(ctx).accentColor
              : Colors.green,
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
    hideHandler();
    if (itemDetails['mnemonicStory'] == '') {
      if (itemDetails['itemType'] == 'Kanji') {
        updateHandler('Please create a mnemonic for the kanji ' +
            '${itemDetails['itemId']} using its bulidng blocks: ' +
            '${itemDetails['buildingBlocks']}');
      } else if (itemDetails['itemType'] == 'Primitive Kanji') {
        updateHandler('Please create a mnemonic for the kanji ' +
            '${itemDetails['itemId']}');
      } else {
        updateHandler('Please create a mnemonic for the item ' +
            '${itemDetails['itemId']}');
      }
    }
    Navigator.of(context)
        .push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return InputDialogScreen(
              itemDetails['mnemonicStory'],
            );
          }),
    )
        .then((_) {
      hideHandler();
    });
  }
}
