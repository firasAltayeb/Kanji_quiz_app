import 'package:Kanji_quiz_app/widgets/lesson/mnemonic_handler.dart';
import 'package:Kanji_quiz_app/widgets/shared/key_text_container.dart';
import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:Kanji_quiz_app/widgets/shared/top_kanji_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-details';

  final Function reAllocateMaps;

  ItemDetailScreen(this.reAllocateMaps);

  @override
  Widget build(BuildContext context) {
    final selectedItem =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm')
        .format(selectedItem['dateLastLevelChanged']);

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
              height: MediaQuery.of(context).size.height * 0.08,
              child: KeyTextContainer(
                'Keyword: ' + selectedItem['keyword'],
              ),
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'SRS Level change date: $formattedDate',
            ),
            SizedBox(height: 20),
            coloredTextContainer(context, selectedItem),
            SizedBox(height: 10),
            srsDifficultyRow(),
            SizedBox(height: 10),
            MnemonicHandler(selectedItem, reAllocateMaps),
          ],
        ),
      ),
    );
  }

  Widget srsDifficultyRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'SRS difficulty is: Easy',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Anton',
          ),
        ),
        CircleAvatar(
          radius: 23,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 20,
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
          radius: 23,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 20,
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

  Widget coloredTextContainer(BuildContext context, var selectedItem) {
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
        'Current SRS level is ${selectedItem['progressLevel']}',
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
