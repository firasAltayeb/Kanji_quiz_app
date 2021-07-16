import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../main_providers.dart';
import '../widgets/screen_extra_badges/score_badges_app_screen.dart';
import '../widgets/shared/colored_text_container.dart';
import '../model/score_badges_model.dart';

class ExtraBadgesScreen extends ConsumerWidget {
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
            ColoredTextContainer(
              passedText: 'Study Badges',
              widgetColor: Colors.red,
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "S",
              screenHeight * 0.25,
              watch(studiedListProvider).length,
            ),
            ColoredTextContainer(
              passedText: 'Review Badges',
              widgetColor: Colors.orange,
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "R",
              screenHeight * 0.25,
              watch(reviewedListProvider).length,
            ),
            ColoredTextContainer(
              passedText: 'Pratice Badges',
              widgetColor: Colors.blue,
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "P",
              screenHeight * 0.25,
              watch(practicedListProvider).length,
            ),
            ColoredTextContainer(
              passedText: 'Acquire Badges',
              widgetColor: Colors.green,
              widgetHeight: screenHeight * 0.04,
            ),
            interactiveRow(
              "A",
              screenHeight * 0.25,
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
              childAspectRatio: 1.5,
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
                          currentAmount >= scoreBadgesList[i].amountToGet
                              ? scoreBadgesList[i].decorationAddress
                              : "assets/images/decorations/grey_crown.png",
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
                              currentAmount >= scoreBadgesList[i].amountToGet
                                  ? "assets/images/templates/gold_badge_template.png"
                                  : "assets/images/templates/grey_badge_template.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: widgetHeight * 0.25,
                        child: Text(
                          "$badgesType" + "${scoreBadgesList[i].amountToGet}",
                          style: TextStyle(
                            fontSize: widgetHeight * 0.175,
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
