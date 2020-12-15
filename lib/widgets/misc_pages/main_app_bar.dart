import 'package:flutter/material.dart';

import 'user_page.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;

  const MainAppBar({
    Key key,
    this.title,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: 35,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserPage())),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
