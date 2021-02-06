import 'package:flutter/material.dart';

class BuildingBlockRow extends StatelessWidget {
  final Map<String, Object> kanjiMap;

  BuildingBlockRow(this.kanjiMap);

  @override
  Widget build(BuildContext context) {
    List<dynamic> addressList = kanjiMap['buildBlocksId'];
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: screenHeight * 0.175,
      child: addressList.isEmpty
          ? textWidget(
              'Item type:  ${kanjiMap['itemType']}',
              screenWidth * 0.08,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'Building blocks: ',
                  screenWidth * 0.06,
                ),
                if (addressList.length == 1)
                  Container(
                    width: screenWidth * 0.3,
                    child: kanjiBlockRow(addressList, screenHeight * 0.125),
                  ),
                if (addressList.length == 2)
                  Container(
                    width: screenWidth * 0.5,
                    child: kanjiBlockRow(addressList, screenHeight * 0.1),
                  ),
                if (addressList.length > 2)
                  Expanded(
                    child: kanjiBlockRow(addressList, screenHeight * 0.1),
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

  Widget kanjiBlockRow(blockAddresses, containerHeight) {
    return Row(
      children: [
        ...(blockAddresses)
            .map(
              (blockAddress) => Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/Colored_template_xl.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: containerHeight,
                      child: Text(
                        blockAddress,
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
