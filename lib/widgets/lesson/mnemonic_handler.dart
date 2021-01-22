import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../misc/bottom_model_sheet.dart';

class MnemonicHandler extends StatefulWidget {
  final Function reAllocateMaps;
  final Map<String, Object> _itemDetails;

  MnemonicHandler(this._itemDetails, this.reAllocateMaps);

  @override
  _MnemonicHandlerState createState() => _MnemonicHandlerState();
}

class _MnemonicHandlerState extends State<MnemonicHandler> {
  final mnemonicController = TextEditingController();

  Widget build(BuildContext context) {
    return Row(
      children: [
        gestureContainer(context, _launchURL, "Kanji Koohii"),
        gestureContainer(
            context, () => BottomModelSheet().show(context), "Edit Mnemonic"),
      ],
    );
  }

  Widget gestureContainer(BuildContext ctx, Function handler, String btnText) {
    return GestureDetector(
      onTap: handler,
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.135,
        width: MediaQuery.of(ctx).size.width * 0.5,
        padding:
            btnText == "Kanji Koohii" ? EdgeInsets.all(15) : EdgeInsets.all(5),
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

  void _launchURL() async {
    String url = 'https://kanji.koohii.com/study/kanji/' +
        '${widget._itemDetails['frameNumber']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
