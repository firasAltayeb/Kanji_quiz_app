import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MnemonicHandler extends StatelessWidget {
  final Map<String, Object> itemDetails;

  MnemonicHandler(this.itemDetails);

  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: launchURL,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 3.0, color: Colors.black),
                left: BorderSide(width: 1.0, color: Colors.black),
                right: BorderSide(width: 1.0, color: Colors.black),
                bottom: BorderSide(width: 3.0, color: Colors.black),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: FittedBox(
              child: Text(
                "Kanji Koohii",
                style: TextStyle(
                  fontFamily: 'Anton',
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: null,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 3.0, color: Colors.black),
                left: BorderSide(width: 1.0, color: Colors.black),
                right: BorderSide(width: 1.0, color: Colors.black),
                bottom: BorderSide(width: 3.0, color: Colors.black),
              ),
              color: Colors.green,
            ),
            child: FittedBox(
              child: Text(
                "Edit Mnemonic",
                style: TextStyle(
                  fontFamily: 'Anton',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void launchURL() async {
    String url = 'https://kanji.koohii.com/study/kanji/' +
        '${itemDetails['frameNumber']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
