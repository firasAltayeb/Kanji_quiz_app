import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int scoreToDisplay;
  final Function wrapSession;
  final List<String> correctRecallList;
  final List<String> incorrectRecallList;

  ResultPage({
    @required this.wrapSession,
    @required this.scoreToDisplay,
    @required this.correctRecallList,
    @required this.incorrectRecallList,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final children = <Widget>[
      wrapUpButton(screenHeight, screenWidth),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: screenHeight * 0.03),
      textContainer('Recalled Correctly', Colors.green),
    ];

    kanjiChildrenRow(children, correctRecallList, screenHeight);
    children.add(textContainer('Recalled Incorrectly', Colors.red));
    kanjiChildrenRow(children, incorrectRecallList, screenHeight);

    return Column(children: children);
  }

  Widget wrapUpButton(double height, double width) {
    return Container(
      padding: EdgeInsets.only(
        top: height * 0.05,
        bottom: height * 0.03,
      ),
      width: width * 0.8,
      child: RaisedButton(
        child: Text(
          'Wrap up session',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: wrapSession,
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  void kanjiChildrenRow(
      List<Widget> children, List<String> list, double height) {
    children.add(
      list.length == 0
          ? SizedBox()
          : SizedBox(
              width: double.infinity,
              height: height * 0.25,
              child: GridView(
                children: (list)
                    .map(
                      (blockAddress) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(blockAddress),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.25,
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
    );
  }

  Widget textContainer(String txt, Color backColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: backColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
