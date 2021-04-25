import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import '../../screens/user_page_screen.dart';
import 'package:flutter/material.dart';

enum VertOptions { User, WrapUp, Koohii }

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String passedTitle;

  MainAppBar({Key key, this.passedTitle, this.appBar}) : super(key: key);

  void _choiceAction(
    VertOptions choice,
    BuildContext context,
    Kanji targetKanji,
    List<bool> ansChoiceList,
    List<Kanji> reviewList,
  ) {
    if (choice == VertOptions.User) {
      Navigator.of(context).pushNamed(UserPage.routeName);
    } else if (choice == VertOptions.Koohii) {
      launchURL(targetKanji);
    } else if (choice == VertOptions.WrapUp) {
      wrapSession(context, ansChoiceList, reviewList);
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    final screenHeight = MediaQuery.of(context).size.height;
    final targetKanji = watch(targetKanjiProvider).state;
    final ansChoiceList = watch(answerChoiceListProvider).state;
    final reviewList = watch(reviewReadyListProvider);
    return AppBar(
      title: Text(
        passedTitle + "Page",
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
          onSelected: (choice) => _choiceAction(
            choice,
            context,
            targetKanji,
            ansChoiceList,
            reviewList,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            if (passedTitle == "Home")
              PopupMenuItem(
                value: VertOptions.User,
                child: Text('User page'),
              ),
            if (passedTitle == "Review")
              PopupMenuItem(
                value: VertOptions.WrapUp,
                child: Text('Wrap up session'),
              ),
            if (passedTitle == "Lesson" || passedTitle == "Item Detail")
              PopupMenuItem(
                value: VertOptions.Koohii,
                child: Text('Search in Koohii'),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
