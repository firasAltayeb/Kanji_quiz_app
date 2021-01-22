import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:Kanji_quiz_app/widgets/lesson/building_block_row.dart';
import 'package:Kanji_quiz_app/widgets/lesson/mnemonic_scroll_display.dart';
import 'package:Kanji_quiz_app/widgets/lesson/mnemonic_handler.dart';
import 'package:Kanji_quiz_app/widgets/shared/key_text_container.dart';
import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:Kanji_quiz_app/widgets/shared/top_kanji_row.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-details';

  final Function reAllocateMaps;

  ItemDetailScreen(this.reAllocateMaps);

  @override
  Widget build(BuildContext context) {
    Map<String, Object> selectedItem =
        HashMap.from(ModalRoute.of(context).settings.arguments);
    var dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    var levelChangeDate =
        dateFormater.format(selectedItem['dateLastLevelChanged']);
    var screenHeight = MediaQuery.of(context).size.height;

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
              child: nextReviewDate(selectedItem, dateFormater),
            ),
            SizedBox(height: 20),
            srsDifficultyRow(screenHeight),
            SizedBox(height: 20),
            MnemonicScrollDisplay(selectedItem),
            SizedBox(height: 30),
            BuildingBlockRow(selectedItem),
            SizedBox(height: 30),
            MnemonicHandler(selectedItem, reAllocateMaps),
          ],
        ),
      ),
    );
  }

  Widget nextReviewDate(var selectedItem, var dateFormater) {
    Widget textContainer;
    var leadingText = 'Next review date: ';
    DateTime dateChanged = selectedItem['dateLastLevelChanged'];
    switch (selectedItem['progressLevel']) {
      case 1:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(hours: 4)))}',
        );
        break;
      case 2:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(hours: 12)))}',
        );
        break;
      case 3:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(days: 2)))}',
        );
        break;
      case 4:
        textContainer = KeyTextContainer(
          '$leadingText' +
              '${dateFormater.format(dateChanged.add(Duration(days: 4)))}',
        );
        break;
      default:
        textContainer = KeyTextContainer(
          '$leadingText Learned item',
        );
        break;
    }
    return textContainer;
  }

  Widget srsDifficultyRow(double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'SRS difficulty is: Easy',
          style: TextStyle(
            fontSize: height * 0.04,
            fontFamily: 'Anton',
          ),
        ),
        CircleAvatar(
          radius: (height * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (height * 0.03) + 4,
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: () {},
              iconSize: height * 0.04,
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: (height * 0.03) + 6,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (height * 0.03) + 4,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () {},
              iconSize: height * 0.04,
              icon: Icon(
                Icons.arrow_upward,
              ),
            ),
          ),
        ),
      ],
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
