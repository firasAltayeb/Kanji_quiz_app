import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/main_screen/main_screen_app_bar.dart';
import '../widgets/shared/text_container.dart';
import '../model/score_badges_model.dart';

class BadgesScreen extends ConsumerWidget {
  static const routeName = '/badges-screen';
  Widget build(BuildContext context, ScopedReader watch) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainScreenAppBar(
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            TextContainer(
              passedText: 'Study Badges',
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "S", scoreBadgesData),
            SizedBox(height: screenHeight * 0.05),
            TextContainer(
              passedText: 'Review Badges',
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "R", scoreBadgesData),
            SizedBox(height: screenHeight * 0.05),
            TextContainer(
              passedText: 'Pratice Badges',
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "P", scoreBadgesData),
            SizedBox(height: screenHeight * 0.05),
            TextContainer(
              passedText: 'Acquire Badges',
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(screenHeight * 0.2, "A", scoreBadgesData),
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
