import 'package:flutter/material.dart';

class BottomModelSheet {
  final mnemonicController = TextEditingController();

  Future<bool> show(BuildContext parentContext, Function updateField) {
    var screenHeight = MediaQuery.of(parentContext).size.height;
    return showModalBottomSheet(
      context: parentContext,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Mnemonic'),
                      style: TextStyle(
                        fontSize: screenHeight * 0.04,
                      ),
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: mnemonicController,
                      onSubmitted: (_) {},
                      onChanged: (_) {},
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => mnemonicController.clear(),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text(
                            'Dispose',
                            style: TextStyle(
                              fontSize: screenHeight * 0.04,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: mnemonicController.text == ''
                              ? null
                              : () {
                                  Navigator.pop(context);
                                  updateField(mnemonicController.text);
                                },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: screenHeight * 0.04,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
