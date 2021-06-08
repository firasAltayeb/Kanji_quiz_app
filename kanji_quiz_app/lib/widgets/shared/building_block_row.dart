import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/learning_item_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class BuildingBlockRow extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final targetItem = watch(targetItemProvider).state;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var buildingBlockIDList = targetItem.buildingBlocksID;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: buildingBlockIDList.isEmpty
          ? _textWidget(
              'Item type: ${targetItem.itemType}',
              screenWidth * 0.08,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _textWidget(
                  'Building blocks: ',
                  screenWidth * 0.06,
                ),
                if (buildingBlockIDList.length == 1)
                  Container(
                    width: screenWidth * 0.3,
                    child:
                        _kanjiBlockRow(screenHeight * 0.1, watch, targetItem),
                  ),
                if (buildingBlockIDList.length == 2)
                  Container(
                    width: screenWidth * 0.5,
                    child:
                        _kanjiBlockRow(screenHeight * 0.1, watch, targetItem),
                  ),
                if (buildingBlockIDList.length > 2)
                  Expanded(
                    child:
                        _kanjiBlockRow(screenHeight * 0.1, watch, targetItem),
                  ),
              ],
            ),
    );
  }

  Widget _textWidget(String displayedText, double height) {
    return Text(
      displayedText,
      style: TextStyle(
        fontSize: height,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _kanjiBlockRow(
      double height, ScopedReader watch, LearningItem targetKanji) {
    return Row(
      children: [
        ...(watch(buildingBlocksProvider(targetKanji)))
            .map(
              (bbKanji) => Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            watch(templateAddressProvider(bbKanji)),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (bbKanji.itemType != "Primitive")
                      Container(
                        height: height,
                        child: Text(
                          bbKanji.characterID,
                          style: TextStyle(
                            fontSize: height * 0.6,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
