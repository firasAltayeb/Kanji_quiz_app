import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../model/study_item_model.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class InputDialogScreen extends StatefulWidget {
  final StudyItem itemDetails;

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
    _mnemonicController.text = widget.itemDetails.mnemonicStory;
  }

  Future<bool> _onBackPressed() async {
    setState(() {
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
                  hintText: inputDialogHintText(widget.itemDetails),
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
                      emptyMnemonic ? 'Return' : 'Dispose',
                      Colors.red,
                      screenHeight,
                      emptyMnemonic
                          ? () {
                              setState(() {
                                _showButtonsRow = false;
                              });
                              context.read(btnBottomRowProvider).state = true;
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
                              context.read(btnBottomRowProvider).state = true;
                              widget.itemDetails.mnemonicStory =
                                  _mnemonicController.text;
                              context
                                  .read(studyItemProvider.notifier)
                                  .editKanji(widget.itemDetails);
                              context
                                  .read(studyItemProvider.notifier)
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
