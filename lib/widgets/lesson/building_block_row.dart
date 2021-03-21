import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';

class BuildingBlockRow extends StatelessWidget {
  final List<Kanji> kanjiList;
  final Kanji itemToLearn;

  BuildingBlockRow(
    this.kanjiList,
    this.itemToLearn,
  );

  String determineTemplateAddress(buildingBlockId) {
    var buildingBlockIndex = kanjiList
        .indexWhere((element) => element.characterLook == buildingBlockId);
    switch (kanjiList[buildingBlockIndex].itemType) {
      case "Radical":
        return "assets/images/blue_badge_template.png";
      case "Primitive":
        return kanjiList[buildingBlockIndex].characterLook;
      default:
        return "assets/images/red_badge_template.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> buildingBlocks = itemToLearn.buildingBlockChatacters;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: buildingBlocks.isEmpty
          ? textWidget(
              'Item type:  ${itemToLearn.itemType}',
              screenWidth * 0.08,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'Building blocks: ',
                  screenWidth * 0.06,
                ),
                if (buildingBlocks.length == 1)
                  Container(
                    width: screenWidth * 0.3,
                    child: kanjiBlockRow(buildingBlocks, screenHeight * 0.125),
                  ),
                if (buildingBlocks.length == 2)
                  Container(
                    width: screenWidth * 0.5,
                    child: kanjiBlockRow(buildingBlocks, screenHeight * 0.1),
                  ),
                if (buildingBlocks.length > 2)
                  Expanded(
                    child: kanjiBlockRow(buildingBlocks, screenHeight * 0.1),
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

  Widget kanjiBlockRow(blockIds, containerHeight) {
    return Row(
      children: [
        ...(blockIds)
            .map(
              (buildingBlockId) => Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            determineTemplateAddress(buildingBlockId),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: containerHeight,
                      child: Text(
                        buildingBlockId,
                        style: TextStyle(
                          fontSize: containerHeight * 0.6,
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
