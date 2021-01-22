import 'package:flutter/material.dart';

class BuildingBlockRow extends StatelessWidget {
  final Map<String, Object> kanjiMap;

  BuildingBlockRow(this.kanjiMap);

  @override
  Widget build(BuildContext context) {
    List<dynamic> addressList = kanjiMap['buildBlocksAddress'];
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: addressList.isEmpty
          ? textWidget(
              'Item type:  ${kanjiMap['itemType']}',
              screenHeight * 0.04,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'Building blocks: ',
                  screenHeight * 0.035,
                ),
                Container(
                  width: addressList.length == 1
                      ? screenWidth * 0.25
                      : screenWidth * 0.55,
                  child: kanjiBlockRow(addressList),
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

  Widget kanjiBlockRow(List<dynamic> blockAddresses) {
    return Row(
      children: [
        ...(blockAddresses)
            .map(
              (blockAddress) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(blockAddress),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
