import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Map<String, Object> _itemDetails;
  final ScrollController _scrollController = ScrollController();

  ScrollableContainer(this._itemDetails);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.175,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[900],
          width: 3,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Scrollbar(
        //isAlwaysShown: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: _itemDetails['mnemonicStory'] == ''
              ? keywordRichText(screenHeight)
              : mnemonicTextWidget(screenHeight),
        ),
      ),
    );
  }

  RichText keywordRichText(var screenHeight) {
    var itemType = _itemDetails['itemType'];
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: screenHeight * 0.035,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Please create a mnemonic for the above $itemType '),
          TextSpan(
            text: '${_itemDetails['keyword']} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (_itemDetails['itemType'] == 'Kanji')
            TextSpan(text: 'using its bulidng blocks: '),
          if (itemType == 'Kanji')
            TextSpan(
              text: '${_itemDetails['buildingBlocks']} ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          TextSpan(text: 'by clicking on the green button below'),
        ],
      ),
    );
  }

  Widget mnemonicTextWidget(var screenHeight) {
    return Text(
      _itemDetails['mnemonicStory'],
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: screenHeight * 0.035,
      ),
    );
  }
}
