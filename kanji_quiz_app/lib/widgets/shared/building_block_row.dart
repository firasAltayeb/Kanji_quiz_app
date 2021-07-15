import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import 'interactive_grid_view.dart';
import '../../main_providers.dart';

class BuildingBlockRow extends ConsumerWidget {
  final StudyItem targetItem;
  final bool keywordPressed;

  BuildingBlockRow({
    @required this.targetItem,
    this.keywordPressed = false,
  });

  double widthToCenter(numberOfItems, screenWidth) {
    if (numberOfItems == 1) return screenWidth * 0.5;
    return screenWidth * 0.055;
  }

  Widget build(BuildContext ctx, ScopedReader watch) {
    var buildingBlockIDList = targetItem.buildingBlocksID;
    var screenHeight = MediaQuery.of(ctx).size.height;
    var screenWidth = MediaQuery.of(ctx).size.width;
    if (keywordPressed) return SizedBox(height: screenHeight * 0.125);
    if (buildingBlockIDList.isEmpty) {
      return _textWidget(
        textToDisplayed: 'Item type: ${targetItem.itemType}',
        widgetHeight: screenHeight * 0.175,
        fontSize: screenWidth * 0.06,
      );
    } else {
      return InteractiveGrid(
        itemList: watch(buildingBlocksProvider(targetItem)),
        widgetHeight: screenHeight * 0.175,
        passedWidget: _textWidget(
          textToDisplayed: 'Building blocks: ',
          fontSize: screenWidth * 0.055,
        ),
      );
    }
  }

  Widget _textWidget({textToDisplayed, widgetHeight, fontSize}) {
    return Container(
      height: widgetHeight,
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
