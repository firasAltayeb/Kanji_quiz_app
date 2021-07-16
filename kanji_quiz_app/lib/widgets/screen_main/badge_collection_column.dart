import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../widgets/shared/interactive_grid_view.dart';
import '../shared/colored_text_container.dart';
import '../../main_providers.dart';

class InteractiveRowColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: screenWidth * 0.025,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.grey[300],
            child: Text(
              "Badge Collection",
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ColoredTextContainer(
            passedText: 'Level 1 review badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(1)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Level 2 review badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(2)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Level 3 review badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(3)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Level 1 practice badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(4)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Level 2 practice badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(5)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Level 3 practice badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(chosenlvlListProvider(6)),
            widgetHeight: screenHeight * 0.2,
          ),
          ColoredTextContainer(
            passedText: 'Acquired badges',
            widgetHeight: screenHeight * 0.04,
          ),
          InteractiveGrid(
            itemList: watch(acquiredListProvider),
            widgetHeight: screenHeight * 0.2,
          ),
        ],
      ),
    );
  }
}
