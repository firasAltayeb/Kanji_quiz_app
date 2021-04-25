import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';

import '../../main_providers.dart';

class ScrollableContainer extends ConsumerWidget {
  final Function showHandler;
  final ScrollController _scrollController = ScrollController();

  ScrollableContainer({@required this.showHandler});

  Widget build(BuildContext context, ScopedReader watch) {
    final targetKanji = watch(targetKanjiProvider).state;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer(builder: (context, watch, _) {
      return InkWell(
        onLongPress: () {
          showHandler(false);
          editMnemonicHandler(
            context,
            targetKanji,
            showHandler,
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
              child: targetKanji.mnemonicStory == ''
                  ? _instructionTextWidget(screenHeight, targetKanji)
                  : _mnemonicTextWidget(screenHeight, targetKanji),
            ),
          ),
        ),
      );
    });
  }

  Widget _instructionTextWidget(screenHeight, Kanji targetKanji) {
    var itemType = targetKanji.itemType;
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
            text: '${targetKanji.keyword} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (targetKanji.itemType == 'Kanji')
            TextSpan(text: 'using its bulidng blocks: '),
          if (itemType == 'Kanji')
            TextSpan(
              text: '${targetKanji.buildingBlockKeywords} ',
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

  Widget _mnemonicTextWidget(var screenHeight, Kanji targetKanji) {
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
