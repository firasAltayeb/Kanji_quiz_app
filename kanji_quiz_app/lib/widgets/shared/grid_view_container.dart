import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class GridViewContainer extends ConsumerWidget {
  final List<StudyItem> itemList;
  final Function selectHandler;
  final double widgetHeight;
  final double widgetWidth;

  GridViewContainer({
    this.widgetWidth,
    @required this.itemList,
    @required this.widgetHeight,
    this.selectHandler = pushToItemDetailScreen,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    final routeName = ModalRoute.of(context).settings.name;
    final addressProvider = routeName == "/lesson-screen"
        ? coloredAddressProvider
        : templateAddressProvider;
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      padding: EdgeInsets.all(widgetHeight * 0.03),
      child: GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return InkWell(
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
                  Container(
                    decoration: BoxDecoration(
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
