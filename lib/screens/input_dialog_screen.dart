import 'package:flutter/material.dart';

class InputDialogScreen extends StatelessWidget {
  final mnemonicController = TextEditingController();
  final String textToEdit;

  InputDialogScreen(this.textToEdit);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
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
                hintText: "$textToEdit",
                hintMaxLines: 10,
                hintStyle: TextStyle(
                  fontSize: screenHeight * 0.03,
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
              onSubmitted: (_) {},
              onChanged: (_) {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _myMaterialButton(
                'Dispose',
                Colors.red,
                screenHeight,
                () => mnemonicController.clear(),
              ),
              _myMaterialButton(
                'Submit',
                Colors.green,
                screenHeight,
                mnemonicController.text == ''
                    ? null
                    : () {
                        Navigator.pop(context);
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
