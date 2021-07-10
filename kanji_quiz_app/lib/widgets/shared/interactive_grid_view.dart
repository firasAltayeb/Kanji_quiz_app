import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../model/study_item_model.dart';
import '../../helper_functions.dart';
import '../../main_providers.dart';

class InteractiveGrid extends ConsumerWidget {
  final double widgetHeight;
  final Function selectHandler;
  final List<StudyItem> itemList;

  InteractiveGrid({
    @required this.itemList,
    @required this.widgetHeight,
    this.selectHandler = pushToItemDetailScreen,
  });

  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: EdgeInsets.only(
        top: widgetHeight * 0.05,
        bottom: widgetHeight * 0.05,
      ),
      height: widgetHeight,
      child: GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            bool plusChara = itemList[i].characterID.length > 1;
            return InkWell(
              onTap: selectHandler == null
                  ? null
                  : () => selectHandler(
                        context,
                        itemList[i],
                        ModalRoute.of(context).settings.name,
                      ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          watch(templateAddressProvider(itemList[i])),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  if (itemList[i].itemType != "Primitive")
                    Container(
                      height:
                          plusChara ? widgetHeight * 0.45 : widgetHeight * 0.65,
                      child: Text(
                        itemList[i].characterID,
                        style: TextStyle(
                          fontSize: plusChara
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
