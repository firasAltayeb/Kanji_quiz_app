import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class InteractiveGrid extends ConsumerWidget {
  final double widgetHeight;
  final Widget passedWidget;
  final Function selectHandler;
  final List<StudyItem> itemList;

  InteractiveGrid({
    this.passedWidget,
    @required this.itemList,
    @required this.widgetHeight,
    this.selectHandler = pushToItemDetailScreen,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final temp = passedWidget == null ? 0 : 1;
    final numberOfWidgets = itemList.length + temp;
    final routeName = ModalRoute.of(context).settings.name;
    final addressProvider = routeName == "/lesson-screen"
        ? coloredAddressProvider
        : templateAddressProvider;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300],
          width: 5,
        ),
      ),
      height: widgetHeight,
      child: GridView.builder(
          itemCount: numberOfWidgets,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, idx) {
            var i = idx - temp;
            return passedWidget != null && i == -1
                ? passedWidget
                : InkWell(
                    onTap: selectHandler == null
                        ? null
                        : () => selectHandler(
                              context,
                              itemList[i],
                              routeName,
                            ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Ink(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: AssetImage(
                                watch(addressProvider(itemList[i])),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        if (itemList[i].itemType != "Primitive")
                          Container(
                            height: itemList[i].characterID.length > 1
                                ? widgetHeight * 0.45
                                : widgetHeight * 0.65,
                            child: Text(
                              itemList[i].characterID,
                              style: TextStyle(
                                fontSize: itemList[i].characterID.length > 1
                                    ? widgetHeight * 0.25
                                    : widgetHeight * 0.4,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
          }),
    );
  }
}
