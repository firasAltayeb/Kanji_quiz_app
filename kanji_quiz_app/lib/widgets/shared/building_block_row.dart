import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import 'interactive_grid_view.dart';
import '../../main_providers.dart';

class BuildingBlockRow extends ConsumerWidget {
  final StudyItem targetItem;

  BuildingBlockRow({
    @required this.targetItem,
  });

  double widthToCenter(numberOfItems, screenWidth) {
    if (numberOfItems == 1) return screenWidth * 0.5;
    if (numberOfItems == 2) return screenWidth * 0.6;
    if (numberOfItems == 3) return screenWidth * 0.9;
    return screenWidth;
  }

  Widget build(BuildContext ctx, ScopedReader watch) {
    var buildingBlockIDList = targetItem.buildingBlocksID;
    var screenHeight = MediaQuery.of(ctx).size.height;
    var screenWidth = MediaQuery.of(ctx).size.width;
    if (buildingBlockIDList.isEmpty) {
      return _textWidget(
        textToDisplayed: 'Item type: ${targetItem.itemType}',
        widgetHeight: screenHeight * 0.175,
        widgetWidth: screenWidth * 0.8,
        fontSize: screenWidth * 0.075,
      );
    } else {
      return Container(
        width: widthToCenter(buildingBlockIDList.length, screenWidth),
        child: InteractiveGrid(
          itemList: watch(buildingBlocksProvider(targetItem)),
          widgetHeight: screenHeight * 0.175,
          passedWidget: _textWidget(
            textToDisplayed: 'Building blocks: ',
            fontSize: screenWidth * 0.055,
          ),
        ),
      );
    }
  }

  Widget _textWidget({textToDisplayed, widgetHeight, widgetWidth, fontSize}) {
    return Container(
      alignment: Alignment.center,
      height: widgetHeight,
      width: widgetWidth,
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
