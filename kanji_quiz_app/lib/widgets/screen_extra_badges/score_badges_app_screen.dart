import 'package:flutter/material.dart';

class ScoreBadgesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  ScoreBadgesAppBar({
    Key key,
    this.appBar,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        'Extra Badges',
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        // PopupMenuButton(
        //   onSelected: (choice) => choiceAction(
        //     choice: choice,
        //     context: context,
        //   ),
        //   icon: Icon(
        //     Icons.more_vert,
        //   ),
        //   itemBuilder: (_) => [],
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
