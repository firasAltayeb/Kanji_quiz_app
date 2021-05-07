import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../../main_providers.dart';

class BuildingBlockRow extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final targetKanji = watch(targetKanjiProvider).state;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var bbKanjiList = targetKanji.buildingBlockKeywords;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: bbKanjiList.isEmpty
          ? textWidget(
              'Item type: ${targetKanji.itemType}',
              screenWidth * 0.08,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'Building blocks: ',
                  screenWidth * 0.06,
                ),
                if (bbKanjiList.length == 1)
                  Container(
                    width: screenWidth * 0.3,
                    child:
                        kanjiBlockRow(screenHeight * 0.1, watch, targetKanji),
                  ),
                if (bbKanjiList.length == 2)
                  Container(
                    width: screenWidth * 0.5,
                    child:
                        kanjiBlockRow(screenHeight * 0.1, watch, targetKanji),
                  ),
                if (bbKanjiList.length > 2)
                  Expanded(
                    child:
                        kanjiBlockRow(screenHeight * 0.1, watch, targetKanji),
                  ),
              ],
            ),
    );
  }

  Widget textWidget(String displayedText, double height) {
    return Text(
      displayedText,
      style: TextStyle(
        fontSize: height,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget kanjiBlockRow(double height, ScopedReader watch, Kanji targetKanji) {
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
                            fontFamily: 'Lato',
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
