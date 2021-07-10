import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/screen_item_details/item_detail_app_bar.dart';
import '../widgets/screen_item_details/item_difficulty_row.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/bottom_row_buttons.dart';
import '../widgets/shared/top_picture_row.dart';
import '../widgets/shared/text_container.dart';
import '../helper_functions.dart';
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

  Widget build(BuildContext context, ScopedReader watch) {
    final _showScrollCon = watch(showScrollConProvider).state;
    final _showButtonRow = watch(showBottomRowProvider).state;
    final _screenHeight = MediaQuery.of(context).size.height;
    final _targetItem = watch(targetItemProvider).state;
    final _showAlert = watch(showAlertProvider).state;
    final isKana = _targetItem.itemType == "Hiragana" ||
        _targetItem.itemType == "Katakana";
    final _sameLevelItems =
        watch(chosenlvlListProvider(_targetItem.progressLevel));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ItemDetailAppBar(
        appBar: AppBar(),
        showAlert: _showAlert,
        targetKanji: _targetItem,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _screenHeight * 0.03,
              color: Colors.grey[300],
            ),
            TopKanjiRow(
              // leftWidgetHandler: prevItemDetail(
              //   ctx: context,
              //   targetItem: _targetItem,
              //   sameLevelItems: _sameLevelItems,
              // ),
              // rightWidgetHandler: nextItemDetail(
              //   ctx: context,
              //   targetItem: _targetItem,
              //   sameLevelItems: _sameLevelItems,
              // ),
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              targetItem: _targetItem,
            ),
            if (!isKana)
              KeyTextContainer(
                passedFunction: () => editDataHandler(
                  studyItem: _targetItem,
                  buildContext: context,
                  forKeyword: true,
                ),
                textToDisplay: 'Keyword: ' + _targetItem.keyword,
                widgetHeight: _screenHeight * 0.08,
              ),
            if (isKana)
              KeyTextContainer(
                textToDisplay: 'Reading: ' + _targetItem.itemReadings[0],
                widgetHeight: _screenHeight * 0.08,
              ),
            SizedBox(height: 20),
            KeyTextContainer(
              textToDisplay: 'Last level change date: ' +
                  '${_fixTimeZone(_targetItem.dateLastLevelChanged)}',
            ),
            SizedBox(height: 20),
            TextContainer(
              passedText: _targetItem.levelTranslation(),
              widgetHeight: _screenHeight * 0.04,
            ),
            SizedBox(height: 20),
            if (_targetItem.learningStatus != "Acquired")
              KeyTextContainer(
                textToDisplay: 'Next review date: ' +
                    '${_fixTimeZone(_targetItem.nextReviewDate())}',
              ),
            BuildingBlockRow(
              targetItem: _targetItem,
            ),
            if (_showScrollCon)
              ScrollableContainer(
                targetItem: _targetItem,
              ),
            if (!_showScrollCon)
              SizedBox(
                height: _screenHeight * 0.175,
              ),
            SizedBox(height: 20),
            ItemDifficultyRow(),
            SizedBox(height: 20),
            if (_showButtonRow)
              ItemBottomRow(
                itemDetailScreen: true,
                passedItem: _targetItem,
              ),
            if (!_showButtonRow)
              SizedBox(
                height: _screenHeight * 0.135,
              ),
          ],
        ),
      ),
    );
  }
}
