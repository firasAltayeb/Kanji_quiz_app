import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FetchButton extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, Object>> learnQueue;

  FetchButton({
    @required this.learnQueue,
    @required this.queueIndex,
  });

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          right: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 3.0, color: Colors.black),
          bottom: BorderSide(width: 5, color: Colors.black),
        ),
      ),
      child: FlatButton(
        textColor: Colors.black,
        child: Text(
          "Fetch From KanjiKoohii",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: launchURL,
      ),
    );
  }

  void launchURL() async {
    String url = 'https://kanji.koohii.com/study/kanji/' +
        '${learnQueue[queueIndex]['frameNumber']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
