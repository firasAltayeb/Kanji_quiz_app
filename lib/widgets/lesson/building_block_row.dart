import 'package:flutter/material.dart';

class BuildingBlockRow extends StatelessWidget {
  final Map<String, Object> kanjiMap;

  BuildingBlockRow(this.kanjiMap);

  @override
  Widget build(BuildContext context) {
    List<dynamic> addressList = kanjiMap['buildBlocksAddress'];
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.175,
      child: addressList.isEmpty
          ? textWidget(
              'Item type:  ${kanjiMap['itemType']}',
              MediaQuery.of(context).size.height * 0.04,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'Building blocks: ',
                  MediaQuery.of(context).size.height * 0.035,
                ),
                Container(
                  width: addressList.length == 1
                      ? MediaQuery.of(context).size.width * 0.25
                      : MediaQuery.of(context).size.width * 0.55,
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
