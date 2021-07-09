import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';

class PracticeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  PracticeAppBar({
    Key key,
    this.appBar,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        'Practice Page',
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
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
