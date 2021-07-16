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
    final _keywordPressed = watch(keywordPressedProvider).state;
    final _showButtonRow = watch(showBottomRowProvider).state;
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
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
                widgetHeight: _screenHeight * 0.07,
              ),
            if (isKana)
              KeyTextContainer(
                textToDisplay: 'Reading: ' + _targetItem.itemReadings[0],
                widgetHeight: _screenHeight * 0.07,
              ),
            SizedBox(height: 20),
            BuildingBlockRow(
              targetItem: _targetItem,
              keywordPressed: _keywordPressed,
            ),
            SizedBox(height: 20),
            ScrollableContainer(
              targetItem: _targetItem,
            ),
            SizedBox(height: 30),
            infoColumn(
              _targetItem,
              _screenHeight,
              _screenWidth,
              _keywordPressed,
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

  Widget infoColumn(targetItem, screenHeight, screenWidth, keywordPressed) {
    return keywordPressed
        ? SizedBox(
            height: screenHeight * 0.2,
          )
        : Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Item status: " + targetItem.levelTranslation(),
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: 20),
                Text(
                  targetItem.learningStatus == "Acquired"
                      ? "already Acquired"
                      : 'Next review date: ' +
                          '${_fixTimeZone(targetItem.nextReviewDate())}',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: 20),
                Text(
                  'Last change date: ' +
                      '${_fixTimeZone(targetItem.dateLastLevelChanged)}',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
              ],
            ),
          );
  }
}
