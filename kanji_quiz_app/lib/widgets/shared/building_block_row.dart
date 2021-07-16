import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import '../../main_providers.dart';
import 'grid_view_container.dart';

class BuildingBlockRow extends ConsumerWidget {
  final StudyItem targetItem;
  final bool keywordPressed;
  final screenHeight;
  final screenWidth;

  BuildingBlockRow({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.targetItem,
    this.keywordPressed = false,
  });

  double widthToCenter(numberOfItems, screenWidth) {
    if (numberOfItems == 1) return screenWidth * 0.5;
    return screenWidth * 0.055;
  }

  Widget build(BuildContext ctx, ScopedReader watch) {
    var buildingBlockIDList = targetItem.buildingBlocksID;
    if (keywordPressed) return SizedBox(height: screenHeight * 0.125);
    if (buildingBlockIDList.isEmpty) {
      return _textWidget(
        textToDisplayed: 'Item type: ${targetItem.itemType}',
        fontSize: screenWidth * 0.065,
      );
    } else {
      return Row(
        children: [
          _textWidget(
            textToDisplayed: 'Building blocks: ',
            fontSize: screenWidth * 0.045,
            widgetWidth: screenWidth * 0.35,
          ),
          GridViewContainer(
            widgetWidth: screenWidth * 0.6,
            widgetHeight: screenHeight * 0.175,
            itemList: watch(buildingBlocksProvider(targetItem)),
          ),
        ],
      );
    }
  }

  Widget _textWidget({textToDisplayed, widgetWidth, fontSize}) {
    return Container(
      width: widgetWidth,
      height: screenHeight * 0.175,
      alignment: Alignment.center,
      child: Text(
        textToDisplayed,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
