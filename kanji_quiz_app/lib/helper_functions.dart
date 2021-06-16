import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'screens/input_dialog_screen.dart';
import 'screens/user_page_screen.dart';
import 'misc/back_pressed_alert.dart';
import 'model/study_item_model.dart';
import 'main_providers.dart';

enum VertOptions {
  User,
  Koohii,
  WrapReview,
  WrapLesson,
  ToggleAlert,
  ToggleSrsColumn,
  ToggleSrsPopUp,
}

void choiceAction({
  @required BuildContext context,
  @required VertOptions choice,
  List<bool> ansChoiceList,
  List<StudyItem> reviewList,
  List<StudyItem> lessonList,
  bool lvlColumnVisible,
  StudyItem targetKanji,
  int lsnQueueIdx,
  bool showAlert,
  bool showPopUp,
}) {
  if (choice == VertOptions.User) {
    Navigator.of(context).pushNamed(UserPage.routeName);
  } else if (choice == VertOptions.Koohii) {
    launchURL(targetKanji);
  } else if (choice == VertOptions.WrapReview) {
    wrapReviewSession(context, ansChoiceList, reviewList);
  } else if (choice == VertOptions.WrapLesson) {
    wrapLessonSession(context, lsnQueueIdx, lessonList);
  } else if (choice == VertOptions.ToggleSrsColumn) {
    context.read(lvlColumnVisibleProvider).state = !lvlColumnVisible;
  } else if (choice == VertOptions.ToggleAlert) {
    context.read(showAlertProvider).state = !showAlert;
  } else if (choice == VertOptions.ToggleSrsPopUp) {
    context.read(showSrsPopUpProvider).state = !showPopUp;
  }
}

void completeChoiceDialog({
  bool showAlert = true,
  bool naviPop = true,
  BuildContext context,
  String alertMessage,
  List<StudyItem> lsnList,
  StudyItem targetItem,
  int lsnQueueIdx,
}) async {
  bool dialogChoice = true;
  if (showAlert) {
    dialogChoice = await BackPressedAlert().dialog(
          parentCtx: context,
          alertMsg: alertMessage,
        ) ??
        false;
  }
  if (dialogChoice) {
    targetItem.dateLastLevelChanged = DateTime.now();
    if (targetItem.itemType == "Kanji" &&
        targetItem.learningStatus != "Practice") {
      targetItem.progressLevel = 1;
      targetItem.learningStatus = 'Practice';
    } else {
      targetItem.progressLevel = 4;
      targetItem.learningStatus = 'Learned';
    }

    if (naviPop) {
      context.read(studyItemProvider.notifier).editKanji(targetItem);
      Navigator.of(context).pop();
    }
    if (lsnList.length <= lsnQueueIdx + 1) {
      //the item is the last in the queue
      wrapLessonSession(context, lsnQueueIdx, lsnList);
    } else {
      context.read(targetItemProvider).state = lsnList[lsnQueueIdx + 1];
      context.read(lessonQueueIdxProvider).state++;
    }
  }
}

void resetChoiceDialog({
  bool showAlert = true,
  bool naviPop = true,
  BuildContext context,
  String alertMessage,
  StudyItem targetItem,
}) async {
  bool dialogChoice = true;
  if (showAlert) {
    dialogChoice = await BackPressedAlert().dialog(
          parentCtx: context,
          alertMsg: alertMessage,
        ) ??
        false;
  }
  if (dialogChoice) {
    targetItem.progressLevel = 0;
    targetItem.mnemonicStory = '';
    targetItem.learningStatus = 'Lesson';
    targetItem.dateLastLevelChanged = DateTime.now();
    context.read(studyItemProvider.notifier).editKanji(targetItem);

    if (naviPop) {
      context.read(studyItemProvider.notifier).saveProgress();
      Navigator.of(context).pop();
    } else {
      //Will update the currently displayed character
      context.read(targetItemProvider).state = targetItem;
    }
  }
}

void launchURL(StudyItem targetKanji) async {
  String url =
      'https://kanji.koohii.com/study/kanji/' + '${targetKanji.frameNumSixth}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void editMnemonicHandler(
    BuildContext context, StudyItem targetKanji, Function showHandler) {
  Navigator.of(context)
      .push(
    PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return InputDialogScreen(targetKanji);
        }),
  )
      .then((passedText) {
    showHandler(true);
  });
}

void wrapReviewSession(BuildContext context, answerChoiceList, reviewList) {
  for (var index = 0; index < answerChoiceList.length; index++) {
    StudyItem reviewedItem = reviewList[index];
    reviewedItem.dateLastLevelChanged = DateTime.now();
    //if answer was correct
    if (answerChoiceList[index]) {
      // current progress + 1
      reviewedItem.progressLevel++;
      reviewedItem.recallHistory.add("Correct");
      //when lvl is 4 practice if kanji else learned
      if (reviewedItem.progressLevel == 4) {
        if (reviewedItem.itemType == "Kanji") {
          reviewedItem.progressLevel = 1;
          reviewedItem.learningStatus = 'Practice';
        } else {
          reviewedItem.learningStatus = 'Learned';
        }
      }
    } /*if answer was incorrect*/ else {
      reviewedItem.difficultyAdjustment();
      reviewedItem.progressLevel = reviewedItem.lapsePenalty();
    }
    context.read(studyItemProvider.notifier).editKanji(reviewedItem);
  }
  context.read(sessionScoreProvider).state = 0;
  context.read(reviewQueueIdxProvider).state = 0;
  context.read(answerChoiceListProvider).state.clear();
  context.read(correctRecallListProvider).state.clear();
  context.read(incorrectRecallListProvider).state.clear();
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}

void wrapLessonSession(BuildContext context, lsnQueueIdx, lessonList) {
  for (var index = 0; index <= lsnQueueIdx; index++) {
    StudyItem sessionItem = lessonList[index];
    sessionItem.dateLastLevelChanged = DateTime.now();
    // if item is not marked as completed
    if (sessionItem.learningStatus == "Lesson") {
      sessionItem.progressLevel = 1;
      sessionItem.learningStatus = 'Review';
    }
    context.read(studyItemProvider.notifier).editKanji(sessionItem);
  }
  context.read(lessonQueueIdxProvider).state = 0;
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}
