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
import '../model/study_item_model.dart';
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
    final _keywordNotPressed = watch(keywordNotPressedProvider).state;
    final _showButtonRow = watch(showBottomRowProvider).state;
    final _screenHeight = MediaQuery.of(context).size.height;
    final _showAlert = watch(showAlertProvider).state;

    StudyItem _argumentItem = ModalRoute.of(context).settings.arguments;
    StudyItem _targetItem = watch(targetItemProvider).state;
    bool _argumentItemIsNotNull = _argumentItem != null;

    if (_argumentItemIsNotNull) {
      _targetItem = _argumentItem;
    }

    final isKana = _targetItem.itemType == "Hiragana" ||
        _targetItem.itemType == "Katakana";

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
              leftWidgetHandler: _argumentItemIsNotNull
                  ? null
                  : prevItemDetail(
                      ctx: context,
                      watch: watch,
                      item: _targetItem,
                    ),
              rightWidgetHandler: _argumentItemIsNotNull
                  ? null
                  : nextItemDetail(
                      ctx: context,
                      watch: watch,
                      item: _targetItem,
                    ),
              leftWidgetText: _argumentItemIsNotNull ? "" : "Prev",
              rightWidgetText: _argumentItemIsNotNull ? "" : "Next",
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
            BuildingBlockRow(
              targetItem: _targetItem,
            ),
            ScrollableContainer(
              targetItem: _targetItem,
            ),
            if (_keywordNotPressed) infoColumn(_targetItem, _screenHeight),
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

  Widget infoColumn(_targetItem, _screenHeight) {
    return Column(
      children: [
        SizedBox(height: 30),
        KeyTextContainer(
          textToDisplay: "Item status: " + _targetItem.levelTranslation(),
          widgetHeight: _screenHeight * 0.045,
        ),
        SizedBox(height: 20),
        KeyTextContainer(
          textToDisplay: _targetItem.learningStatus == "Acquired"
              ? "already Acquired"
              : 'Next review date: ' +
                  '${_fixTimeZone(_targetItem.nextReviewDate())}',
          widgetHeight: _screenHeight * 0.045,
        ),
        SizedBox(height: 20),
        KeyTextContainer(
          textToDisplay: 'Last level change date: ' +
              '${_fixTimeZone(_targetItem.dateLastLevelChanged)}',
          widgetHeight: _screenHeight * 0.05,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
