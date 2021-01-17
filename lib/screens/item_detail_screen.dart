import 'package:Kanji_quiz_app/widgets/shared/key_text_container.dart';
import 'package:Kanji_quiz_app/widgets/shared/main_app_bar.dart';
import 'package:Kanji_quiz_app/widgets/shared/top_kanji_row.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final dynamic selectedItem;

  ItemDetailScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          TopKanjiRow(
            kanjiSpriteAddress: selectedItem['colorPhotoAddress'],
            leftWidgetText: "Prev",
            rightWidgetText: "Next",
            leftWidgetHandler: null,
            rightWidgetHandler: null,
          ),
          SizedBox(
            height: 20,
          ),
          KeyTextContainer(
            passedText: 'Keyword: ' + selectedItem['keyword'],
            alignment: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          KeyTextContainer(
            passedText:
                'SRS Level change date: ${selectedItem['dateLastLevelChanged']}',
            fontSize: 20,
          ),
          SizedBox(
            height: 40,
          ),
          textContainer('Current SRS level is ${selectedItem['progressLevel']}',
              Theme.of(context).accentColor),
        ],
      ),
    );
  }

  Widget textContainer(String txt, Color accentColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: accentColor,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Anton',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
