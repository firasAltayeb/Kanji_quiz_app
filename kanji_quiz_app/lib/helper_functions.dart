import 'package:kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:kanji_quiz_app/screens/user_page_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'misc/back_pressed_alert.dart';

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
  List<Kanji> reviewList,
  List<Kanji> lessonList,
  bool lvlColumnVisible,
  Kanji targetKanji,
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

void openChoiceDialog({
  Function chosenHandler,
  bool showAlert = true,
  bool naviPop = true,
  BuildContext context,
  String alertMessage,
  List<Kanji> lsnList,
  Kanji targetKanji,
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
    chosenHandler(context, targetKanji);
    if (lsnList != null) {
      context.read(targetKanjiProvider).state = lsnList[lsnQueueIdx + 1];
      context.read(lessonQueueIdxProvider).state++;
    } else if (naviPop) {
      context.read(kanjiListProvider.notifier).saveProgress();
      Navigator.of(context).pop();
    } else {
      context.read(targetKanjiProvider).state = targetKanji;
    }
  }
}

void markAsComplete(BuildContext context, Kanji targetKanji) {
  targetKanji.progressLevel = 6;
  context.read(kanjiListProvider.notifier).editKanji(targetKanji);
}

void resetItemStatus(BuildContext context, Kanji targetKanji) {
  targetKanji.learningStatus = 'Lesson';
  targetKanji.progressLevel = 0;
  targetKanji.mnemonicStory = '';
  context.read(kanjiListProvider.notifier).editKanji(targetKanji);
}

void launchURL(Kanji targetKanji) async {
  String url =
      'https://kanji.koohii.com/study/kanji/' + '${targetKanji.frameNumSixth}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void editMnemonicHandler(
    BuildContext context, Kanji targetKanji, Function showHandler) {
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
    Kanji reviewedItem = reviewList[index];
    reviewedItem.dateLastLevelChanged = DateTime.now();
    //if answer was correct
    if (answerChoiceList[index]) {
      // current progress + 1
      reviewedItem.progressLevel++;
      reviewedItem.recallHistory.add("Correct");
      //when lvl is 5 practice if kanji else learned
      if (reviewedItem.progressLevel == 6) {
        if (reviewedItem.itemType == "Kanji")
          reviewedItem.learningStatus = 'Practice';
        else if (reviewedItem.itemType != "Kanji") {
          reviewedItem.learningStatus = 'Learned';
          reviewedItem.progressLevel++;
        }
      }
    } /*if answer was incorrect*/ else {
      reviewedItem.difficultyAdjustment();
      reviewedItem.progressLevel = reviewedItem.lapsePenalty();
    }
    context.read(kanjiListProvider.notifier).editKanji(reviewedItem);
  }
  context.read(sessionScoreProvider).state = 0;
  context.read(reviewQueueIdxProvider).state = 0;
  context.read(answerChoiceListProvider).state.clear();
  context.read(correctRecallListProvider).state.clear();
  context.read(incorrectRecallListProvider).state.clear();
  context.read(kanjiListProvider.notifier).saveProgress();
  Navigator.pop(context);
}

void wrapLessonSession(BuildContext context, lsnQueueIdx, lessonList) {
  for (var index = 0; index < lsnQueueIdx; index++) {
    Kanji sessionItem = lessonList[index];
    sessionItem.dateLastLevelChanged = DateTime.now();
    // if item not marked as completed
    if (sessionItem.progressLevel < 6) {
      sessionItem.progressLevel = 1;
      sessionItem.learningStatus = 'Review';
    } /*if item marked as completed*/ else {
      if (sessionItem.itemType == "Kanji")
        sessionItem.learningStatus = 'Practice';
      else if (sessionItem.itemType != "Kanji") {
        sessionItem.learningStatus = 'Learned';
        sessionItem.progressLevel++;
      }
    }
    context.read(kanjiListProvider.notifier).editKanji(sessionItem);
  }
  context.read(lessonQueueIdxProvider).state = 0;
  context.read(kanjiListProvider.notifier).saveProgress();
  Navigator.pop(context);
}
