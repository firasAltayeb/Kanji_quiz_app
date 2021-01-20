import 'package:flutter/material.dart';

class MnemonicScrollDisplay extends StatelessWidget {
  final Map<String, Object> _lessonMap;
  final ScrollController _scrollController = ScrollController();

  MnemonicScrollDisplay(this._lessonMap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[900],
          width: 3,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: _lessonMap['mnemonicStory'] == ''
              ? keywordRichText()
              : mnemonicTextWidget(),
        ),
      ),
    );
  }

  RichText keywordRichText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Please create a mnemonic for the above kanji '),
          TextSpan(
            text: '${_lessonMap['keyword']} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(text: 'using its bulidng blocks: '),
          TextSpan(
            text: '${_lessonMap['buildingBlocks']}',
            style: TextStyle(
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
      _lessonMap['mnemonicStory'],
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 22,
      ),
    );
  }
}
