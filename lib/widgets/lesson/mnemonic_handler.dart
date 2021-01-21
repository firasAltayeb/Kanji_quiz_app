import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mnemonic_scroll_display.dart';

class MnemonicHandler extends StatelessWidget {
  final Map<String, Object> _itemDetails;

  final Function reAllocateMaps;

  MnemonicHandler(this._itemDetails, this.reAllocateMaps);

  Widget build(BuildContext context) {
    return Column(
      children: [
        MnemonicScrollDisplay(_itemDetails),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.024,
        ),
        Row(
          children: [
            gestureContainer(context, _launchURL, "Kanji Koohii"),
            gestureContainer(context, _editMnemonicField, "Edit Mnemonic"),
          ],
        ),
      ],
    );
  }

  Widget gestureContainer(BuildContext ctx, Function handler, String btnText) {
    return GestureDetector(
      onTap: btnText == "Kanji Koohii" ? handler : () => handler(ctx),
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.175,
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
        '${_itemDetails['frameNumber']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _editMnemonicField(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Text('edit'),
        );
      },
    );
  }
}
