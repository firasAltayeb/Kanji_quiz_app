import 'package:flutter/material.dart';

import 'fetch_button.dart';

class MnemonicField extends StatelessWidget {
  final Function nextKanji;
  final Function updateTempText;
  final Function clearInitialText;
  final Map<String, Object> lessonMap;

  final bool clearText;
  final String textFieldtemp;

  MnemonicField({
    @required this.nextKanji,
    @required this.lessonMap,
    @required this.clearText,
    @required this.textFieldtemp,
    @required this.updateTempText,
    @required this.clearInitialText,
  });

  RichText keywordRichText() {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Please create a mnemonic for the above kanji '),
          new TextSpan(
            text: '${lessonMap['keyword']} ',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          new TextSpan(text: 'using its bulidng blocks: '),
          new TextSpan(
            text: '${lessonMap['buildingBlocks']}',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget mnemonicTextWidget() {
    return Text(
      lessonMap['mnemonicStory'],
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mnemonicStory = lessonMap['mnemonicStory'];
    //var mnemonicController = TextEditingController();

    print("Keyword is " + lessonMap['keyword']);
    print("mnemonicStory is " + mnemonicStory);
    print("textFieldtemp is " + textFieldtemp);
    print("clearText is " + clearText.toString());

    // if (textFieldtemp != '') {
    //   mnemonicController.text = textFieldtemp;
    // } else if (mnemonicStory != '') {
    //   mnemonicController.text = mnemonicStory;
    // } else if (clearText) {
    //   mnemonicController.text = '';
    // } else {
    //   mnemonicController.text = intialText;
    // }

    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green[900],
                width: 3,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: lessonMap['mnemonicStory'] == ''
                ? keywordRichText()
                : mnemonicTextWidget(),
            // TextField(
            //   textInputAction: TextInputAction.go,
            //   keyboardType: TextInputType.multiline,
            //   maxLines: null,
            //   controller: mnemonicController,
            //   onSubmitted: (_) => nextKanji(),
            //   onTap: () => (textFieldtemp == '' && mnemonicStory == '')
            //       ? clearInitialText()
            //       : null,
            //   onChanged: (_) => mnemonicController.text != intialText
            //       ? updateTempText(mnemonicController.text)
            //       : null,
            // ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: FetchButton(
            itemDetails: lessonMap,
          ),
        ),
      ],
    );
  }
}
