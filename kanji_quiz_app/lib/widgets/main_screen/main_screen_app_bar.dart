import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'package:flutter/material.dart';

class MainScreenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;

  MainScreenAppBar({
    Key key,
    this.appBar,
  }) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
    final screenHeight = MediaQuery.of(context).size.height;
    final lvlColumnVisible = watch(lvlColumnVisibleProvider).state;

    return AppBar(
      title: Text(
        'Home Page',
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
        PopupMenuButton(
          onSelected: (choice) => choiceAction(
            choice: choice,
            context: context,
            lvlColumnVisible: lvlColumnVisible,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: VertOptions.User,
              child: Text(
                'User page',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
            PopupMenuItem(
              value: VertOptions.ToggleSrsColumn,
              child: Text(
                lvlColumnVisible ? 'Hide SRS column' : 'Show SRS column',
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
