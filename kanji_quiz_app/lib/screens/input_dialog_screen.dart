import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../model/kanji_model.dart';
import '../main_providers.dart';

class InputDialogScreen extends StatefulWidget {
  final Kanji itemDetails;

  InputDialogScreen(this.itemDetails);

  @override
  _InputDialogScreenState createState() => _InputDialogScreenState();
}

class _InputDialogScreenState extends State<InputDialogScreen> {
  TextEditingController _mnemonicController;
  bool _showButtonsRow = true;

  @override
  void initState() {
    super.initState();
    _mnemonicController = TextEditingController();
    String mnemonicStory = widget.itemDetails.mnemonicStory;
    var clearStory = mnemonicStory.split(" ").join("");
    if (clearStory != '')
      _mnemonicController.text = widget.itemDetails.mnemonicStory;
  }

  void _clearController() {
    setState(() {
      _mnemonicController.text = '';
    });
  }

  void _hideBottomButton() {
    setState(() {
      _showButtonsRow = false;
    });
  }

  Future<bool> _onBackPressed() async {
    setState(() {
      _showButtonsRow = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var hintText = '';

    if (widget.itemDetails.itemType == 'Kanji') {
      hintText = 'Please create a mnemonic for the kanji ' +
          '${widget.itemDetails.characterID} using its bulidng blocks: ' +
          '${widget.itemDetails.buildingBlockKeywords}';
    } else if (widget.itemDetails.itemType == 'Radical') {
      hintText = 'Please create a mnemonic for the Radical ' +
          '${widget.itemDetails.characterID}';
    } else {
      hintText = 'Please create a mnemonic';
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Container(
              color: Colors.white.withOpacity(0.95),
              child: TextField(
                autofocus: true,
                showCursor: true,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintMaxLines: 10,
                  hintStyle: TextStyle(
                    fontSize: screenHeight * 0.04,
                    color: Colors.blue,
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                ),
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                controller: _mnemonicController,
              ),
            ),
            if (_showButtonsRow)
              Consumer(builder: (context, watch, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _myMaterialButton(
                      _mnemonicController.text == '' ? 'Return' : 'Dispose',
                      Colors.red,
                      screenHeight,
                      _mnemonicController.text == ''
                          ? () {
                              _hideBottomButton();
                              context.read(btnBottomRowProvider).state = true;
                              Navigator.pop(context);
                            }
                          : () {
                              _clearController();
                            },
                    ),
                    _myMaterialButton(
                      'Submit',
                      Colors.green,
                      screenHeight,
                      _mnemonicController.text == ''
                          ? null
                          : () {
                              _hideBottomButton();
                              context.read(btnBottomRowProvider).state = true;
                              widget.itemDetails.mnemonicStory =
                                  _mnemonicController.text;
                              context
                                  .read(kanjiListProvider.notifier)
                                  .editKanji(widget.itemDetails);
                              context
                                  .read(kanjiListProvider.notifier)
                                  .saveProgress();
                              Navigator.pop(context);
                            },
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _myMaterialButton(text, color, height, handler) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, height * 0.225, 15, 0),
      child: MaterialButton(
        onPressed: handler,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black, width: 3),
        ),
        padding: const EdgeInsets.all(10),
        color: color,
        disabledColor: Colors.grey[600],
        child: Text(
          text,
          style: TextStyle(
            fontSize: height * 0.04,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
