import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/item_details/item_detail_app_bar.dart';
import '../widgets/item_details/item_difficulty_row.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/item_bottom_row.dart';
import '../widgets/shared/text_container.dart';
import '../widgets/shared/top_picture_row.dart';
import '../main_providers.dart';

class ItemDetailScreen extends ConsumerWidget {
  static const routeName = '/item-details';

  String _fixTimeZone(DateTime time) {
    final _dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    // if (currentTimeZone == 'Asia/Tokyo' &&
    //     DateTime.now().timeZoneName != 'JST') {
    //   time.add(Duration(hours: 9));
    // }
    return _dateFormater.format(time);
  }

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final _showButtonRow = watch(btnBottomRowProvider).state;
    final _targetKanji = watch(targetItemProvider).state;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: ItemDetailAppBar(
        appBar: AppBar(),
        targetKanji: _targetKanji,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopKanjiRow(
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
            ),
            SizedBox(
              height: screenHeight * 0.08,
              child: KeyTextContainer(
                _targetKanji.itemType == "Hiragana" ||
                        _targetKanji.itemType == "Katakana"
                    ? 'Reading: ' + _targetKanji.itemReadings[0]
                    : 'Keyword: ' + _targetKanji.keyword,
              ),
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'Last level change date: ' +
                  '${_fixTimeZone(_targetKanji.dateLastLevelChanged)}',
            ),
            SizedBox(height: 20),
            TextContainer(
              passedText: 'Current SRS level is ${_targetKanji.progressLevel}',
              screenHeight: screenHeight,
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'Next review date: ' +
                  '${_fixTimeZone(_targetKanji.nextReviewDate())}',
            ),
            SizedBox(height: 20),
            ItemDifficultyRow(),
            SizedBox(height: 20),
            ScrollableContainer(
              showHandler: (value) => _showHandler(context, value),
            ),
            SizedBox(height: 30),
            BuildingBlockRow(),
            SizedBox(height: 30),
            if (_showButtonRow)
              ItemBottomRow(
                itemDetailScreen: true,
                showHandler: (value) => _showHandler(context, value),
              ),
            if (!_showButtonRow)
              SizedBox(
                height: screenHeight * 0.135,
              ),
          ],
        ),
      ),
    );
  }
}
