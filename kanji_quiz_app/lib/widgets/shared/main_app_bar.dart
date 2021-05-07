import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'package:flutter/material.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String passedTitle;

  MainAppBar({Key key, this.passedTitle, this.appBar}) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
    final showSrsVisible = watch(lvlColumnVisibleProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final targetKanji = watch(targetKanjiProvider).state;
    final showAlert = watch(showAlertProvider).state;
    final showSrsPop = watch(showSrsPopUpProvider).state;

    final reviewList = watch(reviewReadyListProvider);
    final ansChoiceList = watch(answerChoiceListProvider).state;

    final lessonList = watch(lessonListProvider);
    final lsnQueueIdx = watch(lessonQueueIdxProvider).state;
    return AppBar(
      title: Text(
        passedTitle + ' Page',
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
            showAlert: showAlert,
            showPopUp: showSrsPop,
            reviewList: reviewList,
            lessonList: lessonList,
            lsnQueueIdx: lsnQueueIdx,
            targetKanji: targetKanji,
            ansChoiceList: ansChoiceList,
            showSrsVisible: showSrsVisible,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            if (passedTitle == "Home")
              PopupMenuItem(
                value: VertOptions.User,
                child: Text(
                  'User page',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Home")
              PopupMenuItem(
                value: VertOptions.ToggleSrsColumn,
                child: Text(
                  showSrsVisible ? 'Hide SRS column' : 'Show SRS column',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Review")
              PopupMenuItem(
                value: VertOptions.WrapReview,
                child: Text(
                  'Wrap up session',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Review")
              PopupMenuItem(
                value: VertOptions.ToggleSrsPopUp,
                child: Text(
                  showSrsPop ? 'Hide pop-up msg' : 'Show pop-up msg',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Lesson" || passedTitle == "Item Detail")
              PopupMenuItem(
                value: VertOptions.Koohii,
                child: Text(
                  'Search in Koohii',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Lesson")
              PopupMenuItem(
                value: VertOptions.WrapLesson,
                child: Text(
                  'Wrap up session',
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                  ),
                ),
              ),
            if (passedTitle == "Lesson")
              PopupMenuItem(
                value: VertOptions.ToggleAlert,
                child: Text(
                  showAlert ? 'Hide pop-up alert' : 'Show pop-up alert',
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
