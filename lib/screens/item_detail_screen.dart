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
            'Keyword: ' + selectedItem['keyword'],
          ),
          SizedBox(
            height: 50,
          ),
          KeyTextContainer(
            'Keyword: ' + selectedItem['keyword'],
          ),
        ],
      ),
    );
  }
}
