import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../main_providers.dart';
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
            Container(
              height: screenHeight * 0.03,
              color: Colors.grey[300],
            ),
            TextContainer(
              passedText: 'Study Badges',
              widgetColor: Colors.red[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "S",
              screenHeight * 0.2,
              watch(studiedListProvider).length,
            ),
            TextContainer(
              passedText: 'Review Badges',
              widgetColor: Colors.orange[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "R",
              screenHeight * 0.2,
              watch(reviewedListProvider).length,
            ),
            TextContainer(
              passedText: 'Pratice Badges',
              widgetColor: Colors.blue[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "P",
              screenHeight * 0.2,
              watch(practicedListProvider).length,
            ),
            TextContainer(
              passedText: 'Acquire Badges',
              widgetColor: Colors.green[400],
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "A",
              screenHeight * 0.2,
              watch(acquiredListProvider).length,
            ),
          ],
        ),
      ),
    );
  }

  Widget interactiveRow(badgesType, widgetHeight, currentAmount) {
    return Padding(
      padding: EdgeInsets.only(bottom: widgetHeight * 0.1),
      child: SizedBox(
        height: widgetHeight,
        child: GridView.builder(
            itemCount: scoreBadgesList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: widgetHeight,
              childAspectRatio: 1.25,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  Container(
                    height: widgetHeight * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/crown_decoration.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: widgetHeight * 0.75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              currentAmount > scoreBadgesList[i].amountToGet
                                  ? scoreBadgesList[i].backGroundAddress
                                  : "assets/images/grey_badge_template2.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: widgetHeight * 0.3,
                        child: Text(
                          "$badgesType" + "${scoreBadgesList[i].amountToGet}",
                          style: TextStyle(
                            fontSize: widgetHeight * 0.2,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
