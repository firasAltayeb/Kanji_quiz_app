import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../model/study_item_model.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class InputDialogScreen extends StatefulWidget {
  final StudyItem itemDetails;
  final bool keywordManipulation;

  InputDialogScreen({this.itemDetails, this.keywordManipulation});

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
    if (!widget.keywordManipulation)
      _mnemonicController.text = widget.itemDetails.mnemonicStory;
  }

  Future<bool> _onBackPressed() async {
    setState(() {
      context.read(keywordNotPressedProvider).state = true;
      context.read(showBottomRowProvider).state = true;
      _showButtonsRow = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var emptyMnemonic = _mnemonicController.text.split(" ").join("") == "";
    var screenHeight = MediaQuery.of(context).size.height;

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
                  hintText: inputDialogHintText(
                    widget.itemDetails,
                    widget.keywordManipulation,
                  ),
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
                minLines: 12,
                maxLines: 12,
                controller: _mnemonicController,
              ),
            ),
            if (_showButtonsRow)
              Consumer(builder: (context, watch, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _myMaterialButton(
                      emptyMnemonic ? 'Return' : 'Dispose',
                      Colors.red,
                      screenHeight,
                      emptyMnemonic
                          ? () {
                              setState(() {
                                _showButtonsRow = false;
                              });
                              context.read(keywordNotPressedProvider).state =
                                  true;
                              context.read(showBottomRowProvider).state = true;
                              Navigator.pop(context);
                            }
                          : () {
                              setState(() {
                                _mnemonicController.text = '';
                              });
                            },
                    ),
                    _myMaterialButton(
                      'Submit',
                      Colors.green,
                      screenHeight,
                      emptyMnemonic
                          ? null
                          : () {
                              setState(() {
                                _showButtonsRow = false;
                              });
                              if (widget.keywordManipulation)
                                widget.itemDetails.keyword =
                                    _mnemonicController.text;
                              if (!widget.keywordManipulation)
                                widget.itemDetails.mnemonicStory =
                                    _mnemonicController.text;
                              context
                                  .read(studyItemProvider.notifier)
                                  .editKanji(widget.itemDetails);
                              context
                                  .read(studyItemProvider.notifier)
                                  .saveProgress();

                              context.read(keywordNotPressedProvider).state =
                                  true;
                              context.read(showBottomRowProvider).state = true;
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
      padding: EdgeInsets.only(top: height * 0.15),
      child: MaterialButton(
        color: color,
        elevation: 2,
        onPressed: handler,
        disabledColor: Colors.grey[600],
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.black, width: 3),
        ),
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
