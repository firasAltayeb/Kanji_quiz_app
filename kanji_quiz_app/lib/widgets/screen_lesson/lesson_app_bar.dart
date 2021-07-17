import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';
import 'package:flutter/material.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool showAlert;
  final int lsnQueueIdx;
  final List<StudyItem> lessonList;
  final List<StudyItem> toQueueList;

  LessonAppBar({
    Key key,
    this.appBar,
    this.showAlert,
    this.lessonList,
    this.lsnQueueIdx,
    this.toQueueList,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final targetKanji = lessonList[lsnQueueIdx];

    return AppBar(
      title: Text(
        'Lesson Page',
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
            showAlert: showAlert,
            lessonList: lessonList,
            lsnQueueIdx: lsnQueueIdx,
            targetKanji: targetKanji,
            toQueueList: toQueueList,
          ),
          icon: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
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
              value: VertOptions.Koohii,
              child: Text(
                'Search in Koohii',
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
