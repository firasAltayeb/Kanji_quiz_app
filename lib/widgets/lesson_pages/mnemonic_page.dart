import 'package:flutter/material.dart';

class MnemonicPage extends StatelessWidget {
  final List<Map<String, Object>> learnQueue;
  final int queueIndex;

  final Function mnemonicProvided;

  MnemonicPage(this.learnQueue, this.queueIndex, this.mnemonicProvided);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kanjiPicture(context),
        RaisedButton(
          child: Text('Restart Quiz'),
          textColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Text('Sub Page'),
      ],
    );
  }

  Widget kanjiPicture(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            learnQueue[queueIndex]['kanjiPicture'],
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
