import 'package:flutter/material.dart';

class MnemonicField extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, String>> lessonMap;

  final Function nextKanji;
  final bool initialtextCleared;
  final Function clearInitialText;
  final Function updateTempText;
  final String textFieldtemp;
  final mnemonicController = TextEditingController();

  MnemonicField({
    @required this.lessonMap,
    @required this.queueIndex,
    @required this.nextKanji,
    @required this.initialtextCleared,
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

    // print(keyword);
    // print(mnemonicStory);

    if (mnemonicStory != '') {
      mnemonicController.text = mnemonicStory;
    } else if (initialtextCleared) {
      if (textFieldtemp != '') {
        mnemonicController.text = textFieldtemp;
      } else {
        mnemonicController.text = '';
      }
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
        onSubmitted: (_) {
          print('mnemonicController.text is ' + mnemonicController.text);
          lessonMap[queueIndex]['mnemonicStory'] = mnemonicController.text;
          nextKanji();
        },
        onTap: () => clearInitialText(),
        onChanged: (_) => updateTempText(mnemonicController.text),
      ),
    );
  }
}
