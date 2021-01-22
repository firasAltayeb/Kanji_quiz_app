import 'package:flutter/material.dart';

import '../../screens/user_page_screen.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;

  MainAppBar({
    Key key,
    this.title,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenHeight * 0.03,
          fontFamily: 'Anton',
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: screenHeight * 0.035,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: screenHeight * 0.035,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
