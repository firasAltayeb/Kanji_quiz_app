import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../shared/colored_text_container.dart';
import '../shared/grid_view_container.dart';
import '../../main_providers.dart';

class BadgeCollectionColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final lvlOneItems = watch(chosenlvlListProvider(1));
    final lvlTwoItems = watch(chosenlvlListProvider(2));
    final lvlThreeItems = watch(chosenlvlListProvider(3));
    final lvlFourItems = watch(chosenlvlListProvider(4));
    final lvlFiveItems = watch(chosenlvlListProvider(5));
    final lvlSixItems = watch(chosenlvlListProvider(6));
    final inPracticeList = watch(inPracticeListProvider);
    final acquiredList = watch(acquiredListProvider);
    final inReviewList = watch(inReviewListProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: screenWidth * 0.025,
        ),
        color: Colors.grey[300],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Badge Collection",
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (lvlOneItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 1 review badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlOneItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlOneItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (lvlTwoItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 2 review badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlTwoItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlTwoItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (lvlThreeItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 3 review badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlThreeItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlThreeItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (lvlFourItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 1 practice badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlFourItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlFourItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (lvlFiveItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 2 practice badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlFiveItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlFiveItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (lvlSixItems.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Level 3 practice badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (lvlSixItems.isNotEmpty)
              GridViewContainer(
                itemList: lvlSixItems,
                widgetHeight: screenHeight * 0.2,
              ),
            if (acquiredList.isNotEmpty)
              ColoredTextContainer(
                passedText: 'Acquired badges',
                widgetHeight: screenHeight * 0.04,
              ),
            if (acquiredList.isNotEmpty)
              GridViewContainer(
                itemList: acquiredList,
                widgetHeight: screenHeight * 0.2,
              ),
            if (inReviewList.isEmpty &&
                inPracticeList.isEmpty &&
                acquiredList.isEmpty)
              Container(
                height: screenHeight * 0.2,
              ),
          ],
        ),
      ),
    );
  }
}
