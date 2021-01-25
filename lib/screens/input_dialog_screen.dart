import 'package:flutter/material.dart';

class InputDialogScreen extends StatefulWidget {
  final Map<String, Object> itemDetails;

  InputDialogScreen(this.itemDetails);

  @override
  _InputDialogScreenState createState() => _InputDialogScreenState();
}

class _InputDialogScreenState extends State<InputDialogScreen> {
  final mnemonicController = TextEditingController();
  bool disposeClicked = false;
  bool showButtonsRow = true;
  bool clickable = false;

  void _updateSubmitClickability() {
    setState(() {
      disposeClicked = true;
      mnemonicController.text = '';
    });
  }

  void _hideBottomButton() {
    setState(() {
      showButtonsRow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var hintText = '';

    if (widget.itemDetails['itemType'] == 'Kanji') {
      hintText = 'Please create a mnemonic for the kanji ' +
          '${widget.itemDetails['itemId']} using its bulidng blocks: ' +
          '${widget.itemDetails['buildingBlocks']}';
    } else if (widget.itemDetails['itemType'] == 'Primitive Kanji') {
      hintText = 'Please create a mnemonic for the kanji ' +
          '${widget.itemDetails['itemId']}';
    } else {
      hintText = 'Please create a mnemonic for the item ' +
          '${widget.itemDetails['itemId']}';
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      resizeToAvoidBottomPadding: false,
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
              controller: mnemonicController,
              onTap: () {
                disposeClicked = false;
              },
            ),
          ),
          if (showButtonsRow)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _myMaterialButton(
                  'Dispose',
                  Colors.red,
                  screenHeight,
                  disposeClicked
                      ? () {
                          _hideBottomButton();
                          Navigator.pop(context);
                        }
                      : () {
                          _updateSubmitClickability();
                        },
                ),
                _myMaterialButton(
                  'Submit',
                  Colors.green,
                  screenHeight,
                  mnemonicController.text == ''
                      ? null
                      : () {
                          _hideBottomButton();
                          Navigator.pop(context, mnemonicController.text);
                        },
                ),
              ],
            ),
        ],
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
