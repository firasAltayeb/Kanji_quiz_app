import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/helper_functions.dart';
import '../../model/study_item_model.dart';

class ScrollableContainer extends ConsumerWidget {
  final Function showHandler;
  final StudyItem targetItem;
  final ScrollController _scrollController = ScrollController();

  ScrollableContainer({
    @required this.targetItem,
    @required this.showHandler,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, watch, _) {
      return InkWell(
        onLongPress: () {
          editMnemonicHandler(
            studyItem: targetItem,
            buildContext: context,
            bottomRowHandler: showHandler,
          );
        },
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
              child: targetItem.mnemonicStory == ''
                  ? _instructionTextWidget(screenHeight, targetItem)
                  : _mnemonicTextWidget(screenHeight, targetItem),
            ),
          ),
        ),
      );
    });
  }

  Widget _instructionTextWidget(screenHeight, StudyItem item) {
    var itemType = item.itemType;
    var temp = item.buildingBlockKeywords.length > 1 ? "blocks" : "block";
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: screenHeight * 0.035,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Please create a mnemonic for the above $itemType '),
          if (itemType != 'Hiragana' && itemType != 'Katakana')
            TextSpan(
              text: '${item.keyword} ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          if (item.buildingBlockKeywords.isNotEmpty)
            TextSpan(
              text: 'using its building $temp ' +
                  '${item.buildingBlockKeywords} ',
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

  Widget _mnemonicTextWidget(var screenHeight, StudyItem targetKanji) {
    return Text(
      targetKanji.mnemonicStory,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: screenHeight * 0.035,
      ),
    );
  }
}
