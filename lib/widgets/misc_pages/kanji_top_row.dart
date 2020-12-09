import 'package:flutter/material.dart';

class KanjiTopRow extends StatelessWidget {
  final String text;
  final String address;
  final Function handler;

  KanjiTopRow(
    this.text,
    this.handler,
    this.address,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          padding: const EdgeInsets.fromLTRB(0, 10, 40, 0),
          textColor: Colors.black,
          child: Text(
            text,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: handler,
        ),
        kanjiPicture(
          context: context,
          address: address,
          width: 0.4,
          height: 0.3,
        ),
        FlatButton(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          textColor: Colors.black,
          child: Text(
            "Next",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          onPressed: handler,
        ),
      ],
    );
  }

  Widget kanjiPicture(
      {BuildContext context, String address, double width, double height}) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(address),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
