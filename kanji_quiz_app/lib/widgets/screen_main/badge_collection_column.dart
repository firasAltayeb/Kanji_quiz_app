import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../widgets/shared/interactive_grid_view.dart';
import '../../widgets/shared/text_container.dart';
import '../../main_providers.dart';

class InteractiveRowColumn extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextContainer(
          passedText: 'Review Level 1 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(1)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Review Level 2 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(2)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Review Level 3 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(3)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Practice Level 1 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(4)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Practice Level 2 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(5)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Practice Level 3 Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(chosenlvlListProvider(6)),
          widgetHeight: screenHeight * 0.2,
        ),
        TextContainer(
          passedText: 'Acquired Items',
          widgetHeight: screenHeight * 0.04,
        ),
        InteractiveGrid(
          itemList: watch(acquiredListProvider),
          widgetHeight: screenHeight * 0.2,
        ),
      ],
    );
  }
}
