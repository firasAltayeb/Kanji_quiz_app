import 'package:kanji_quiz_app/widgets/shared/corner_button.dart';
import 'package:kanji_quiz_app/widgets/shared/corner_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class TopKanjiRow extends ConsumerWidget {
  final String leftWidgetText;
  final String rightWidgetText;
  final Function leftWidgetHandler;
  final Function rightWidgetHandler;

  TopKanjiRow({
    @required this.leftWidgetText,
    @required this.rightWidgetText,
    this.leftWidgetHandler,
    this.rightWidgetHandler,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final targetKanji = watch(targetKanjiProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final templateAddress = watch(templateAddressProvider(targetKanji));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidgetText == 'Prev'
            ? CornerButton(
                passedText: leftWidgetText,
                handler: leftWidgetHandler,
                height: screenHeight,
              )
            : CornerWidget(
                passedText: leftWidgetText,
                height: screenHeight,
              ),
        kanjiPicture(screenHeight, templateAddress, targetKanji),
        (rightWidgetText == 'Undo' || rightWidgetText == 'Next')
            ? CornerButton(
                passedText: rightWidgetText,
                handler: rightWidgetHandler,
                height: screenHeight,
              )
            : CornerWidget(
                passedText: rightWidgetText,
                height: screenHeight,
              ),
      ],
    );
  }

  Widget kanjiPicture(
      double height, String templateAddress, Kanji targetKanji) {
    return Expanded(
      flex: 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height * 0.275,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  templateAddress,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (targetKanji.itemType != "Primitive")
            Container(
              height: height * 0.18,
              child: Text(
                targetKanji.characterID,
                style: TextStyle(
                  fontSize: height * 0.11,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
