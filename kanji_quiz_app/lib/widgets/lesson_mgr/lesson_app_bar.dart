import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';

class LessonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool showAlert;
  final int lsnQueueIdx;
  final List<Kanji> lessonList;

  LessonAppBar({
    Key key,
    this.appBar,
    this.showAlert,
    this.lessonList,
    this.lsnQueueIdx,
  }) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
    final screenHeight = MediaQuery.of(context).size.height;
    final targetKanji = lessonList[lsnQueueIdx];

    return AppBar(
      title: Text(
        'Lesson Page',
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
            showAlert: showAlert,
            lessonList: lessonList,
            lsnQueueIdx: lsnQueueIdx,
            targetKanji: targetKanji,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: VertOptions.Koohii,
              child: Text(
                'Search in Koohii',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
            PopupMenuItem(
              value: VertOptions.WrapLesson,
              child: Text(
                'Wrap up session',
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                ),
              ),
            ),
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
