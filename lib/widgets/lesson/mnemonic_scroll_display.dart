import 'package:flutter/material.dart';

class MnemonicScrollDisplay extends StatelessWidget {
  final Map<String, Object> _itemDetails;
  final ScrollController _scrollController = ScrollController();

  MnemonicScrollDisplay(this._itemDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.165,
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
          child: _itemDetails['mnemonicStory'] == ''
              ? keywordRichText(context)
              : mnemonicTextWidget(context),
        ),
      ),
    );
  }

  RichText keywordRichText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height * 0.035,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Please create a mnemonic for the above kanji '),
          TextSpan(
            text: '${_itemDetails['keyword']} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(text: 'using its bulidng blocks: '),
          TextSpan(
            text: '${_itemDetails['buildingBlocks']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget mnemonicTextWidget(BuildContext context) {
    return Text(
      _itemDetails['mnemonicStory'],
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.height * 0.035,
      ),
    );
  }
}
