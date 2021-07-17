import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_item_details/status_info_column.dart';
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
            KeyTextContainer(
              passedFunction: () => editDataHandler(
                studyItem: _targetItem,
                buildContext: context,
                forKeyword: true,
              ),
              targetItem: _targetItem,
              widgetHeight: _screenHeight * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: BuildingBlockRow(
                targetItem: _targetItem,
                screenWidth: _screenWidth,
                screenHeight: _screenHeight,
                keywordPressed: _keywordPressed,
              ),
            ),
            ScrollableContainer(
              targetItem: _targetItem,
            ),
            StatusInfoColumn(
              targetItem: _targetItem,
              screenWidth: _screenWidth,
              screenHeight: _screenHeight,
              keywordPressed: _keywordPressed,
            ),
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
