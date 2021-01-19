import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FetchButton extends StatelessWidget {
  final Map<String, Object> itemDetails;

  FetchButton({@required this.itemDetails});

  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Fetch From KanjiKoohii",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: launchURL,
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
