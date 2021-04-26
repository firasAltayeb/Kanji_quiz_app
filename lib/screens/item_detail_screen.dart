import 'package:kanji_quiz_app/widgets/shared/text_container.dart';
import '../widgets/item_details/item_difficulty_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/shared/scrollable_container.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/shared/building_block_row.dart';
import '../widgets/shared/item_bottom_row.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-details';
  final String currentTimeZone;

  ItemDetailScreen({@required this.currentTimeZone});

  String _fixTimeZone(DateTime time) {
    // print('$currentTimeZone');
    // print('${DateTime.now().timeZoneName}');
    final _dateFormater = DateFormat('dd/MM/yyyy HH:mm');

    if (currentTimeZone == 'Asia/Tokyo' &&
        DateTime.now().timeZoneName != 'JST') {
      time.add(Duration(hours: 9));
    }
    return _dateFormater.format(time);
  }

  void _showHandler(BuildContext context, bool trueFalse) {
    context.read(btnBottomRowProvider).state = trueFalse;
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MainAppBar(
        passedTitle: 'Item Detail',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _showButtonRow = watch(btnBottomRowProvider).state;
        final _targetKanji = watch(targetKanjiProvider).state;
        return SingleChildScrollView(
          child: Column(
            children: [
              TopKanjiRow(
                leftWidgetText: "Prev",
                rightWidgetText: "Next",
              ),
              SizedBox(
                height: screenHeight * 0.08,
                child: KeyTextContainer(
                  'Keyword: ' + _targetKanji.keyword,
                ),
              ),
              SizedBox(height: 20),
              KeyTextContainer(
                'Last level change date: ' +
                    '${_fixTimeZone(_targetKanji.dateLastLevelChanged)}',
              ),
              SizedBox(height: 20),
              TextContainer(
                passedText:
                    'Current SRS level is ${_targetKanji.progressLevel}',
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
                  showResetButton: true,
                  showHandler: (value) => _showHandler(context, value),
                ),
              if (!_showButtonRow)
                SizedBox(
                  height: screenHeight * 0.135,
                ),
            ],
          ),
        );
      }),
    );
  }
}
