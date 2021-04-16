import '../widgets/item_details/srs_difficulty_row.dart';
import '../widgets/item_details/next_review_date.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/item-details';
  final String currentTimeZone;

  ItemDetailScreen({
    @required this.currentTimeZone,
  });

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  var _showHandler = true;

  @override
  Widget build(BuildContext context) {
    Kanji selectedKanji = ModalRoute.of(context).settings.arguments;
    var dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    var screenHeight = MediaQuery.of(context).size.height;
    var levelChangeDate = _fixTimeZone(selectedKanji);

    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopKanjiRow(
              targetKanji: selectedKanji,
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: null,
              rightWidgetHandler: null,
            ),
            SizedBox(
              height: screenHeight * 0.08,
              child: KeyTextContainer(
                'Keyword: ' + selectedKanji.keyword,
              ),
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'SRS Level change date: ' +
                  '${dateFormater.format(levelChangeDate)}',
            ),
            SizedBox(height: 20),
            _coloredTextContainer(
              screenHeight,
              selectedKanji.progressLevel,
              Theme.of(context).accentColor,
            ),
            SizedBox(height: 20),
            Container(
              height: screenHeight * 0.06,
              child: NextReviewDate(
                selectedKanji,
                levelChangeDate,
              ),
            ),
            SizedBox(height: 20),
            SrsDifficultyRow(),
            SizedBox(height: 20),
            ScrollableContainer(
              itemDetails: selectedKanji,
            ),
            SizedBox(height: 30),
            BuildingBlockRow(
              selectedKanji,
            ),
            SizedBox(height: 30),
            if (_showHandler)
              MnemonicHandler(
                itemDetails: selectedKanji,
                resetItemStatus: () {
                  selectedKanji.learningStatus = 'Lesson';
                  selectedKanji.progressLevel = 0;
                  selectedKanji.mnemonicStory = '';
                },
              ),
            if (!_showHandler)
              SizedBox(
                height: screenHeight * 0.135,
              ),
          ],
        ),
      ),
    );
  }

  DateTime _fixTimeZone(selectedKanji) {
    print('${widget.currentTimeZone}');
    print('${DateTime.now().timeZoneName}');
    if (widget.currentTimeZone == 'Asia/Tokyo' &&
        DateTime.now().timeZoneName != 'JST') {
      return DateTime.now().add(Duration(hours: 9));
    }
    return selectedKanji.dateLastLevelChanged;
  }

  Widget _coloredTextContainer(height, itemLvl, color) {
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
