import 'package:flutter/material.dart';

class MnemonicField extends StatelessWidget {
  final int queueIndex;
  final List<Map<String, Object>> learnQueue;

  final bool textCleared;
  final Function nextKanji;
  final mnemonicController = TextEditingController();

  MnemonicField({
    @required this.learnQueue,
    @required this.queueIndex,
    @required this.nextKanji,
    @required this.textCleared,
  });

  @override
  Widget build(BuildContext context) {
    String keyword = learnQueue[queueIndex]['keyword'];
    String intialText =
        'Please create a mnemonic for the above kanji $keyword' +
            ' using its bulidng blocks a and b';

    textCleared
        ? mnemonicController.text = 'txt cleared'
        : mnemonicController.text = intialText;

    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: TextField(
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: mnemonicController,
        onSubmitted: (_) {
          print('on submitted clicked');
          nextKanji();
        },
        onTap: () {
          if (textCleared == false) {
            // mnemonicController.clear();
          }
        },
      ),
    );
  }
}
