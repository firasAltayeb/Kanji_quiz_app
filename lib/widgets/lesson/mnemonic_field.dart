import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    var keyword = lessonMap['keyword'];
    var mnemonicStory = lessonMap['mnemonicStory'];
    var buildingBlocks = lessonMap['buildingBlocks'];
    var mnemonicController = TextEditingController();
    String intialText =
        'Please create a mnemonic for the above kanji $keyword' +
            ' using its bulidng blocks: $buildingBlocks';

    print("Keyword is " + keyword);
    print("mnemonicStory is " + mnemonicStory);
    print("textFieldtemp is " + textFieldtemp);
    print("clearText is " + clearText.toString());

    if (textFieldtemp != '') {
      mnemonicController.text = textFieldtemp;
    } else if (mnemonicStory != '') {
      mnemonicController.text = mnemonicStory;
    } else if (clearText) {
      mnemonicController.text = '';
    } else {
      mnemonicController.text = intialText;
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
        onSubmitted: (_) => nextKanji(),
        onTap: () => (textFieldtemp == '' && mnemonicStory == '')
            ? clearInitialText()
            : null,
        onChanged: (_) => mnemonicController.text != intialText
            ? updateTempText(mnemonicController.text)
            : null,
      ),
    );
  }
}
