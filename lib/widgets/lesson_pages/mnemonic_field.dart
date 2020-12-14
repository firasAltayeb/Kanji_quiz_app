import 'package:flutter/material.dart';

class MnemonicField extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, Object>> lessonMap;

  final Function nextKanji;
  final bool clearText;
  final Function clearInitialText;
  final Function updateTempText;
  final String textFieldtemp;
  final mnemonicController = TextEditingController();

  MnemonicField({
    @required this.lessonMap,
    @required this.queueIndex,
    @required this.nextKanji,
    @required this.clearText,
    @required this.clearInitialText,
    @required this.updateTempText,
    @required this.textFieldtemp,
  });

  @override
  Widget build(BuildContext context) {
    String keyword = lessonMap[queueIndex]['keyword'];
    String mnemonicStory = lessonMap[queueIndex]['mnemonicStory'];
    String intialText =
        'Please create a mnemonic for the above kanji $keyword' +
            ' using its bulidng blocks a and b';

    print("Keyword is " + keyword);
    print("mnemonicStory is " + mnemonicStory);
    print("textFieldtemp is " + textFieldtemp);
    print("clearText is " + clearText.toString());

    if (textFieldtemp != '') {
      mnemonicController.text = textFieldtemp;
    } else if (mnemonicStory != '') {
      mnemonicController.text = mnemonicStory;
    } else if (!clearText) {
      mnemonicController.text = intialText;
    } else {
      mnemonicController.text = '';
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextField(
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: mnemonicController,
        onSubmitted: (_) {
          print('mnemonicController.text is ' + mnemonicController.text);
          lessonMap[queueIndex]['mnemonicStory'] = mnemonicController.text;
          nextKanji();
        },
        onTap: () => textFieldtemp == '' && mnemonicStory == ''
            ? clearInitialText()
            : null,
        onChanged: (_) => mnemonicController.text != intialText
            ? updateTempText(mnemonicController.text)
            : null,
      ),
    );
  }
}
