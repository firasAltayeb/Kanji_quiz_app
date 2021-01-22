import 'dart:collection';
import 'package:Kanji_quiz_app/widgets/lesson/mnemonic_scroll_display.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
            coloredTextContainer(context, selectedItem['progressLevel']),
            SizedBox(height: 20),
            nextReviewDate(selectedItem, dateFormater),
            SizedBox(height: 20),
            srsDifficultyRow(screenHeight),
            SizedBox(height: 20),
            MnemonicScrollDisplay(selectedItem),
            SizedBox(height: 20),
            MnemonicHandler(selectedItem, reAllocateMaps),
          ],
        ),
      ),
    );
  }

  Widget nextReviewDate(var selectedItem, var dateFormater) {
    return KeyTextContainer(
      'Next review date: ${dateFormater.format(selectedItem['dateLastLevelChanged'])}',
    );
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
          radius: (height * 0.01) + 23,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (height * 0.01) + 20,
            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: (height * 0.01) + 23,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: (height * 0.01) + 20,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_upward,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget coloredTextContainer(BuildContext context, var itemLvl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Theme.of(context).accentColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        'Current SRS level is $itemLvl',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.035,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
