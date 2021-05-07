import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';

class ReviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool showSrsPop;
  final List<Kanji> reviewList;
  final List<bool> ansChoiceList;

  ReviewAppBar({
    Key key,
    this.appBar,
    this.showSrsPop,
    this.reviewList,
    this.ansChoiceList,
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
            ansChoiceList: ansChoiceList,
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
