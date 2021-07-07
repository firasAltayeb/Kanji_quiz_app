import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/item_details/item_detail_app_bar.dart';
import '../widgets/item_details/item_difficulty_row.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/bottom_row_buttons.dart';
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

  void _showHandler(BuildContext context, bool value) {
    context.read(btnBottomRowProvider).state = value;
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final _showButtonRow = watch(btnBottomRowProvider).state;
    final _targetItem = watch(targetItemProvider).state;
    final _showAlert = watch(showAlertProvider).state;

    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ItemDetailAppBar(
        appBar: AppBar(),
        showAlert: _showAlert,
        targetKanji: _targetItem,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.03,
              color: Colors.grey[300],
            ),
            TopKanjiRow(
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              targetItem: _targetItem,
            ),
            SizedBox(
              height: screenHeight * 0.08,
              child: KeyTextContainer(
                _targetItem.itemType == "Hiragana" ||
                        _targetItem.itemType == "Katakana"
                    ? 'Reading: ' + _targetItem.itemReadings[0]
                    : 'Keyword: ' + _targetItem.keyword,
              ),
            ),
            SizedBox(height: 20),
            KeyTextContainer(
              'Last level change date: ' +
                  '${_fixTimeZone(_targetItem.dateLastLevelChanged)}',
            ),
            SizedBox(height: 20),
            TextContainer(
              passedText: _targetItem.levelTranslation(),
              widgetColor: Theme.of(context).accentColor,
              widgetHeight: screenHeight * 0.04,
            ),
            SizedBox(height: 20),
            if (_targetItem.learningStatus != "Acquired")
              KeyTextContainer(
                'Next review date: ' +
                    '${_fixTimeZone(_targetItem.nextReviewDate())}',
              ),
            SizedBox(height: 20),
            ItemDifficultyRow(),
            SizedBox(height: 20),
            ScrollableContainer(
              targetItem: _targetItem,
              showHandler: (value) => _showHandler(context, value),
            ),
            SizedBox(height: 30),
            BuildingBlockRow(
              targetItem: _targetItem,
            ),
            SizedBox(height: 30),
            if (_showButtonRow)
              ItemBottomRow(
                itemDetailScreen: true,
                passedItem: _targetItem,
                showBottomRow: (value) => _showHandler(context, value),
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
