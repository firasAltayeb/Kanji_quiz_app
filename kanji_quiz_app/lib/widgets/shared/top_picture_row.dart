import 'package:kanji_quiz_app/widgets/shared/corner_button.dart';
import 'package:kanji_quiz_app/widgets/shared/corner_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/learning_item_model.dart';
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
    final targetItem = watch(targetItemProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final templateAddress = watch(templateAddressProvider(targetItem));
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
        _itemPicture(screenHeight, templateAddress, targetItem),
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

  Widget _itemPicture(
      double height, String templateAddress, LearningItem targetItem) {
    bool plusChara = targetItem.characterID.length > 1;
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
          if (targetItem.itemType != "Primitive")
            Container(
              height: plusChara ? height * 0.13 : height * 0.18,
              child: Text(
                targetItem.characterID,
                style: TextStyle(
                  fontSize: plusChara ? height * 0.07 : height * 0.11,
                  fontFamily: 'Anton',
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
