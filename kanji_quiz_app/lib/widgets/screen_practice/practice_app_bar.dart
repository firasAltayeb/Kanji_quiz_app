import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';

class PracticeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final List<StudyItem> practiceList;
  final List<bool> sessionChoicesList;

  PracticeAppBar({
    Key key,
    this.appBar,
    this.practiceList,
    this.sessionChoicesList,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        'Practice Page',
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (choice) => choiceAction(
            choice: choice,
            context: context,
            practiceList: practiceList,
            sessionChoices: sessionChoicesList,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: VertOptions.WrapPractice,
              child: Text(
                'Wrap up session',
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
