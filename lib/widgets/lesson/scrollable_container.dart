import 'package:Kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Function updateHandler;
  final Function hideShowHandler;
  final Map<String, Object> itemDetails;
  final ScrollController _scrollController = ScrollController();

  ScrollableContainer({
    @required this.itemDetails,
    @required this.updateHandler,
    @required this.hideShowHandler,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onLongPress: () => _editMnemonicHandler(context),
      child: Container(
        height: screenHeight * 0.175,
        width: screenWidth * 0.95,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[900],
            width: 3,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: itemDetails['mnemonicStory'] == ''
                ? _instructionTextWidget(screenHeight)
                : _mnemonicTextWidget(screenHeight),
          ),
        ),
      ),
    );
  }

  void _editMnemonicHandler(BuildContext context) {
    hideShowHandler();
    Navigator.of(context)
        .push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return InputDialogScreen(itemDetails);
          }),
    )
        .then((passedText) {
      if (passedText != null) {
        updateHandler(passedText);
      }
      hideShowHandler();
    });
  }

  Widget _instructionTextWidget(var screenHeight) {
    var itemType = itemDetails['itemType'];
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
            text: '${itemDetails['keyword']} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (itemDetails['itemType'] == 'Kanji')
            TextSpan(text: 'using its bulidng blocks: '),
          if (itemType == 'Kanji')
            TextSpan(
              text: '${itemDetails['buildingBlocks']} ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          TextSpan(text: 'by long pressing here'),
        ],
      ),
    );
  }

  Widget _mnemonicTextWidget(var screenHeight) {
    return Text(
      itemDetails['mnemonicStory'],
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: screenHeight * 0.035,
      ),
    );
  }
}
