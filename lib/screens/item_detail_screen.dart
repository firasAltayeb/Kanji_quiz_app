import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../widgets/shared/main_app_bar.dart';
import '../widgets/shared/top_kanji_row.dart';
import '../widgets/lesson/mnemonic_handler.dart';
import '../widgets/shared/key_text_container.dart';
import '../widgets/lesson/building_block_row.dart';
import '../widgets/lesson/scrollable_container.dart';
import '../widgets/item_details/next_review_date.dart';
import '../widgets/item_details/srs_difficulty_row.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/item-details';

  final String currentTimeZone;
  final Function reAllocateMaps;
  final Function resetItemStatus;
  final List<dynamic> kanjiMapList;

  ItemDetailScreen({
    @required this.kanjiMapList,
    @required this.reAllocateMaps,
    @required this.resetItemStatus,
    @required this.currentTimeZone,
  });

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  Map<String, Object> _selectedItem;
  var _showHandler = true;

  void _updateMnemonicField(String input) {
    if (input == null || input != '')
      setState(() {
        _selectedItem['mnemonicStory'] = input;
        print('mnemonicStory input is ${_selectedItem['mnemonicStory']}');
        widget.reAllocateMaps();
      });
  }

  void _hideMnemonicHandler() {
    setState(() {
      _showHandler = !_showHandler;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedIndex = ModalRoute.of(context).settings.arguments;
    var dateFormater = DateFormat('dd/MM/yyyy HH:mm');
    var screenHeight = MediaQuery.of(context).size.height;

    _selectedItem = widget.kanjiMapList[selectedIndex];
    var levelChangeDate = _fixTimeZone(_selectedItem);

    return Scaffold(
      appBar: MainAppBar(
        title: 'Item Details',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopKanjiRow(
              kanjiSpriteAddress: _selectedItem['colorPhotoAddress'],
              leftWidgetText: "Prev",
              rightWidgetText: "Next",
              leftWidgetHandler: null,
              rightWidgetHandler: null,
            ),
            SizedBox(
              height: screenHeight * 0.08,
              child: KeyTextContainer(
                'Keyword: ' + _selectedItem['keyword'],
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
              _selectedItem['progressLevel'],
              Theme.of(context).accentColor,
            ),
            SizedBox(height: 20),
            Container(
              height: screenHeight * 0.06,
              child: NextReviewDate(
                _selectedItem,
                levelChangeDate,
              ),
            ),
            SizedBox(height: 20),
            SrsDifficultyRow(),
            SizedBox(height: 20),
            ScrollableContainer(
              itemDetails: _selectedItem,
              updateHandler: _updateMnemonicField,
              hideShowHandler: _hideMnemonicHandler,
            ),
            SizedBox(height: 30),
            BuildingBlockRow(_selectedItem),
            SizedBox(height: 30),
            if (_showHandler)
              MnemonicHandler(
                itemDetails: _selectedItem,
                updateHandler: _updateMnemonicField,
                hideShowHandler: _hideMnemonicHandler,
                resetItemStatus: widget.resetItemStatus,
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

  DateTime _fixTimeZone(itemDetails) {
    print('${widget.currentTimeZone}');
    print('${DateTime.now().timeZoneName}');
    if (widget.currentTimeZone == 'Asia/Tokyo' &&
        DateTime.now().timeZoneName != 'JST') {
      return DateTime.now().add(Duration(hours: 9));
    }
    return _selectedItem['dateLastLevelChanged'];
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
