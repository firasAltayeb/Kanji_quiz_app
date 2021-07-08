import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/score_screens/score_badges_app_screen.dart';
import '../widgets/shared/text_container.dart';
import '../model/score_badges_model.dart';

class BadgesScreen extends ConsumerWidget {
  static const routeName = '/badges-screen';
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ScoreBadgesAppBar(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: screenHeight * 0.03, color: Colors.grey[300]),
            TextContainer(
              passedText: 'Study Badges',
              widgetColor: Colors.red[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "S", scoreBadgesData),
            Container(height: screenHeight * 0.03, color: Colors.grey[300]),
            TextContainer(
              passedText: 'Review Badges',
              widgetColor: Colors.orange[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "R", scoreBadgesData),
            Container(height: screenHeight * 0.03, color: Colors.grey[300]),
            TextContainer(
              passedText: 'Pratice Badges',
              widgetColor: Colors.blue[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "P", scoreBadgesData),
            Container(height: screenHeight * 0.03, color: Colors.grey[300]),
            TextContainer(
              passedText: 'Acquire Badges',
              widgetColor: Colors.green[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "A", scoreBadgesData),
            Container(height: screenHeight * 0.03, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget interactiveRow(widgetHeight, badgesType, badgeList) {
    return SizedBox(
      height: widgetHeight,
      child: GridView.builder(
          itemCount: badgeList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widgetHeight,
            childAspectRatio: 1.25,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        badgeList[i].backGroundAddress,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: widgetHeight * 0.3,
                  child: Text(
                    "$badgesType" + "${badgeList[i].labelText}",
                    style: TextStyle(
                      fontSize: widgetHeight * 0.2,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
