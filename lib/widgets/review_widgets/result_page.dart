import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int scoreToDisplay;
  final Function resetHandler;
  final List<String> correctRecallList;
  final List<String> incorrectRecallList;

  ResultPage({
    @required this.resetHandler,
    @required this.scoreToDisplay,
    @required this.correctRecallList,
    @required this.incorrectRecallList,
  });

  @override
  Widget build(BuildContext context) {
    double spaceWidth = MediaQuery.of(context).size.width;
    double spaceHeight = MediaQuery.of(context).size.height;

    final children = <Widget>[
      SizedBox(height: spaceHeight * 0.03),
      wrapUpButton(spaceWidth * 0.6),
      SizedBox(height: spaceHeight * 0.03),
      Text(
        'Your session score is ${scoreToDisplay.toString()}',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: spaceHeight * 0.03),
      textContainer('Recalled Correctly', Colors.green),
    ];

    kanjiChildrenRow(children, correctRecallList, spaceHeight);
    children.add(textContainer('Recalled Incorrectly', Colors.red));
    kanjiChildrenRow(children, incorrectRecallList, spaceHeight);

    return Column(children: children);
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

  Widget wrapUpButton(double spaceWidth) {
    return ButtonTheme(
      minWidth: spaceWidth,
      splashColor: Colors.green,
      child: RaisedButton(
        child: Text(
          'Wrap up session',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: resetHandler,
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.black, width: 2),
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
