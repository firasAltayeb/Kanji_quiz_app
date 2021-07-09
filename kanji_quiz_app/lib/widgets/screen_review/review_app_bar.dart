import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';

class ReviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool showSrsPop;
  final List<bool> sessionChoices;
  final List<StudyItem> reviewList;

  ReviewAppBar({
    Key key,
    this.appBar,
    this.showSrsPop,
    this.reviewList,
    this.sessionChoices,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        'Review Page',
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontFamily: 'Anton',
        ),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (choice) => choiceAction(
            choice: choice,
            context: context,
            showPopUp: showSrsPop,
            reviewList: reviewList,
            sessionChoices: sessionChoices,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: VertOptions.WrapReview,
              child: Text(
                'Wrap up session',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
            PopupMenuItem(
              value: VertOptions.ToggleSrsPopUp,
              child: Text(
                showSrsPop ? 'Hide pop-up msg' : 'Show pop-up msg',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
