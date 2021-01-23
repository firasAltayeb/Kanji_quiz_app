import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../widgets/item_details/next_review_date.dart';
import '../widgets/item_details/srs_difficulty_row.dart';
import '../widgets/lesson/building_block_row.dart';
import '../widgets/lesson/mnemonic_handler.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/main_app_bar.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/lesson/scrollable_container.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/item-details';

  final Function reAllocateMaps;
  final List<dynamic> kanjiMapList;

  ItemDetailScreen(this.reAllocateMaps, this.kanjiMapList);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  Map<String, Object> selectedItem;

  void updateMnemonicField(String input) {
    if (input == null || input != '')
      setState(() {
        selectedItem['mnemonicStory'] = input;
        print('mnemonicStory input is ${selectedItem['mnemonicStory']}');
        widget.reAllocateMaps();
      });
  }

  @override
  Widget build(BuildContext context) {
    var selectedIndex = ModalRoute.of(context).settings.arguments;
    var dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    var screenHeight = MediaQuery.of(context).size.height;

    selectedItem = widget.kanjiMapList[selectedIndex];

    var levelChangeDate =
        dateFormater.format(selectedItem['dateLastLevelChanged']);

    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopKanjiRow(
              kanjiSpriteAddress: selectedItem['colorPhotoAddress'],
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: null,
              rightWidgetHandler: null,
            ),
            SizedBox(
              height: screenHeight * 0.08,
              child: KeyTextContainer(
                'Keyword: ' + selectedItem['keyword'],
              ),
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'SRS Level change date: $levelChangeDate',
            ),
            SizedBox(height: 20),
            coloredTextContainer(
              screenHeight,
              selectedItem['progressLevel'],
              Theme.of(context).accentColor,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: screenHeight * 0.06,
              child: NextReviewDate(selectedItem),
            ),
            SizedBox(height: 20),
            SrsDifficultyRow(),
            SizedBox(height: 20),
            ScrollableContainer(selectedItem),
            SizedBox(height: 30),
            BuildingBlockRow(selectedItem),
            SizedBox(height: 30),
            MnemonicHandler(selectedItem, updateMnemonicField),
          ],
        ),
      ),
    );
  }

  Widget coloredTextContainer(height, itemLvl, color) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: color,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        'Current SRS level is $itemLvl',
        style: TextStyle(
          fontSize: height * 0.04,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
