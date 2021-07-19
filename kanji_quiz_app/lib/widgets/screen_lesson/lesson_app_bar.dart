import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:kanji_quiz_app/model/study_item_model.dart';
import 'package:kanji_quiz_app/helper_functions.dart';

class LessonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool showAlert;
  final double screenHeight;
  final StudyItem targetKanji;

  LessonAppBar({
    Key key,
    this.appBar,
    this.showAlert,
    this.targetKanji,
    this.screenHeight,
  }) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
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
            watch: watch,
            choice: choice,
            context: context,
            showAlert: showAlert,
            targetKanji: targetKanji,
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
