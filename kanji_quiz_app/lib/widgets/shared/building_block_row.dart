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

  Widget build(BuildContext ctx, ScopedReader watch) {
    var buildingBlockIDList = targetItem.buildingBlocksID;
    var screenHeight = MediaQuery.of(ctx).size.height;
    var screenWidth = MediaQuery.of(ctx).size.width;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: buildingBlockIDList.isEmpty
          ? _textWidget(
              textToDisplayed: 'Item type: ${targetItem.itemType}',
              widgetWidth: screenWidth * 0.8,
              fontSize: screenWidth * 0.075,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _textWidget(
                  textToDisplayed: 'Building blocks: ',
                  widgetWidth: screenWidth * 0.25,
                  fontSize: screenWidth * 0.06,
                ),
                Expanded(
                  child: InteractiveGrid(
                    itemList: watch(buildingBlocksProvider(targetItem)),
                    widgetHeight: screenHeight * 0.175,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _textWidget({textToDisplayed, widgetWidth, fontSize}) {
    return Container(
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
