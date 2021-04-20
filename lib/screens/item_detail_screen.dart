import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/item_details/srs_difficulty_row.dart';
import '../widgets/item_details/next_review_date.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/mnemonic_handler.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../model/kanji_model.dart';
import '../main_providers.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-details';
  final String currentTimeZone;

  ItemDetailScreen({@required this.currentTimeZone});

  DateTime _fixTimeZone(Kanji targetKanji) {
    print('$currentTimeZone');
    print('${DateTime.now().timeZoneName}');
    if (currentTimeZone == 'Asia/Tokyo' &&
        DateTime.now().timeZoneName != 'JST') {
      return DateTime.now().add(Duration(hours: 9));
    }
    return targetKanji.dateLastLevelChanged;
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

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext context) {
    final _dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _showButtonRow = watch(btnBottomRowProvider).state;
        final _targetKanji = watch(targetKanjiProvider).state;
        final _levelChangeDate = _fixTimeZone(_targetKanji);
        return SingleChildScrollView(
          child: Column(
            children: [
              TopKanjiRow(
                leftWidgetText: "Prev",
                rightWidgetText: "Next",
                leftWidgetHandler: null,
                rightWidgetHandler: null,
              ),
              SizedBox(
                height: _screenHeight * 0.08,
                child: KeyTextContainer(
                  'Keyword: ' + _targetKanji.keyword,
                ),
              ),
              SizedBox(height: 20),
              KeyTextContainer(
                'SRS Level change date: ' +
                    '${_dateFormater.format(_levelChangeDate)}',
              ),
              SizedBox(height: 20),
              _coloredTextContainer(
                _screenHeight,
                _targetKanji.progressLevel,
                Theme.of(context).accentColor,
              ),
              SizedBox(height: 20),
              Container(
                height: _screenHeight * 0.06,
                child: NextReviewDate(
                  _targetKanji,
                  _levelChangeDate,
                ),
              ),
              SizedBox(height: 20),
              SrsDifficultyRow(),
              SizedBox(height: 20),
              ScrollableContainer(
                showHandler: (trueFalse) => _showHandler(context, trueFalse),
              ),
              SizedBox(height: 30),
              BuildingBlockRow(),
              SizedBox(height: 30),
              if (_showButtonRow)
                MnemonicHandler(
                  showHandler: (trueFalse) => _showHandler(context, trueFalse),
                  resetItemStatus: () {
                    _targetKanji.learningStatus = 'Lesson';
                    _targetKanji.progressLevel = 0;
                    _targetKanji.mnemonicStory = '';
                    context
                        .read(kanjiListProvider.notifier)
                        .editKanji(_targetKanji);
                  },
                ),
              if (!_showButtonRow)
                SizedBox(
                  height: _screenHeight * 0.135,
                ),
            ],
          ),
        );
      }),
    );
  }
}
