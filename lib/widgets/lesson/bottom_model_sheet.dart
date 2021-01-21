import 'package:flutter/material.dart';

class BottomModelSheet {
  final mnemonicController = TextEditingController();

  Future<bool> show(BuildContext parentContext) {
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
                        fontSize: 20,
                      ),
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: mnemonicController,
                      onSubmitted: (_) {},
                      onChanged: (_) {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
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
                              fontSize: 22,
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 22,
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
