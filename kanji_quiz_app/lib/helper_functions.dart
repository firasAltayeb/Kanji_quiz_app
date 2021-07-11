import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/screens/item_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'screens/input_dialog_screen.dart';
import 'screens/user_page_screen.dart';
import 'misc/back_pressed_alert.dart';
import 'model/study_item_model.dart';
import 'main_providers.dart';

enum VertOptions {
  ToggleOverallProg,
  ToggleSrsColumn,
  ToggleSrsPopUp,
  ToggleAlert,
  WrapPractice,
  WrapLesson,
  WrapReview,
  Koohii,
  User,
}

void choiceAction({
  @required BuildContext context,
  @required VertOptions choice,
  List<StudyItem> practiceList,
  List<StudyItem> lessonList,
  List<StudyItem> reviewList,
  List<bool> sessionChoices,
  bool lvlColumnVisible,
  bool overallVisible,
  StudyItem targetKanji,
  int lsnQueueIdx,
  bool showAlert,
  bool showPopUp,
}) {
  if (choice == VertOptions.Koohii) {
    launchURL(targetKanji);
  } else if (choice == VertOptions.WrapLesson) {
    wrapLessonSession(context, lsnQueueIdx, lessonList);
  } else if (choice == VertOptions.WrapReview) {
    wrapReviewSession(context, sessionChoices, reviewList);
  } else if (choice == VertOptions.WrapPractice) {
    wrapPracticeSession(context, sessionChoices, practiceList);
  } else if (choice == VertOptions.ToggleAlert) {
    context.read(showAlertProvider).state = !showAlert;
  } else if (choice == VertOptions.User) {
    Navigator.of(context).pushNamed(UserPage.routeName);
  } else if (choice == VertOptions.ToggleSrsPopUp) {
    context.read(showSrsPopUpProvider).state = !showPopUp;
  } else if (choice == VertOptions.ToggleSrsColumn) {
    context.read(lvlColumnVisibleProvider).state = !lvlColumnVisible;
  } else if (choice == VertOptions.ToggleOverallProg) {
    context.read(overallProgressVisibleProvider).state = !overallVisible;
  }
}

void completeChoiceDialog({
  bool showAlert = true,
  bool naviPop = true,
  List<StudyItem> lsnList,
  StudyItem targetItem,
  BuildContext context,
  String alertMessage,
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
      targetItem.progressLevel = 4;
      targetItem.learningStatus = 'Practice';
    } else {
      targetItem.progressLevel = 7;
      targetItem.learningStatus = 'Acquired';
    }

    if (naviPop) {
      context.read(studyItemProvider.notifier).editKanji(targetItem);
      Navigator.of(context).pop();
    } else if (lsnList.length <= lsnQueueIdx + 1) {
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
  StudyItem targetItem,
  BuildContext context,
  String alertMessage,
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
    targetItem.progressLevel = 0;
    targetItem.mnemonicStory = '';
    targetItem.learningStatus = 'Lesson';
    targetItem.dateLastLevelChanged = DateTime.now();
    context.read(studyItemProvider.notifier).editKanji(targetItem);

    if (naviPop) {
      context.read(studyItemProvider.notifier).saveProgress();
      Navigator.of(context).pop();
    } else {
      if (lsnQueueIdx > 0) {
        context.read(lessonQueueIdxProvider).state--;
      } else {
        context.read(lessonQueueIdxProvider).state++;
      }
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

void wrapReviewSession(BuildContext context, answerChoiceList, reviewList) {
  for (var index = 0; index < answerChoiceList.length; index++) {
    StudyItem reviewedItem = reviewList[index];
    reviewedItem.dateLastLevelChanged = DateTime.now();
    //if answer was correct
    if (answerChoiceList[index]) {
      // current progress + 1
      reviewedItem.progressLevel++;
      reviewedItem.recallHistory.add("Correct");
      //when lvl is 4 practice if kanji else acquired
      if (reviewedItem.progressLevel == 4) {
        if (reviewedItem.itemType == "Kanji") {
          reviewedItem.learningStatus = 'Practice';
        } else {
          reviewedItem.progressLevel = 7;
          reviewedItem.learningStatus = 'Acquired';
        }
      } else if (reviewedItem.progressLevel == 7) {
        reviewedItem.learningStatus = 'Acquired';
      }
    } else if (!answerChoiceList[index]) {
      /*if answer was incorrect*/
      reviewedItem.recallHistory.add("Incorrect");

      reviewedItem.difficultyAdjustment();
      reviewedItem.progressLevel = reviewedItem.lapsePenalty();
    }
    context.read(studyItemProvider.notifier).editKanji(reviewedItem);
  }
  context.read(sessionScoreProvider).state = 0;
  context.read(reviewQueueIdxProvider).state = 0;
  context.read(sessionChoicesListProvider).state.clear();
  context.read(correctRecallListProvider).state.clear();
  context.read(incorrectRecallListProvider).state.clear();
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}

void wrapPracticeSession(BuildContext context, sessionChoices, practiceList) {
  print("answerChoiseList is $sessionChoices");
  for (var index = 0; index < sessionChoices.length; index++) {
    StudyItem practiceItem = practiceList[index];
    practiceItem.dateLastLevelChanged = DateTime.now();
    if (sessionChoices[index] != null) {
      //if answer was correct
      if (sessionChoices[index]) {
        // current progress + 1
        practiceItem.progressLevel++;
        practiceItem.practiceHistory.add("Correct");
        //when item reaches lvl 7 it is marked as done
        if (practiceItem.progressLevel == 7) {
          practiceItem.learningStatus = 'Acquired';
        }
      } else if (!sessionChoices[index]) {
        /*if answer was incorrect*/
        practiceItem.practiceHistory.add("Incorrect");
        practiceItem.progressLevel = practiceItem.lapsePenalty();
        if (practiceItem.progressLevel < 4)
          practiceItem.learningStatus = "Review";
      }
      //save changes to the main list
      context.read(studyItemProvider.notifier).editKanji(practiceItem);
    }
  }
  context.read(sessionScoreProvider).state = 0;
  context.read(sentenceQueueIdxProvider).state = 1;
  context.read(practiceQueueIdxProvider).state = 0;
  context.read(answeredRevealedProvider).state = false;
  context.read(sessionChoicesListProvider).state.clear();
  context.read(correctRecallListProvider).state.clear();
  context.read(incorrectRecallListProvider).state.clear();
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}

void editDataHandler(
    {BuildContext buildContext, StudyItem studyItem, bool forKeyword}) {
  if (forKeyword) buildContext.read(showScrollConProvider).state = false;
  buildContext.read(showBottomRowProvider).state = false;
  Navigator.of(buildContext).push(
    PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return InputDialogScreen(
            itemDetails: studyItem,
            keywordManipulation: forKeyword,
          );
        }),
  );
}

String inputDialogHintText(StudyItem item, keywordManipulation) {
  var type = item.itemType;
  var keywordHint = type == 'Kanji' ? "e.g. ${item.itemMeanings}" : "";
  var temp = item.buildingBlockKeywords.length > 1 ? "blocks" : "block";
  if (keywordManipulation) {
    return "${item.itemType} keyword can be any of the " +
        "words/meanings it usually associate with " +
        keywordHint;
  }
  if (type == 'Kanji') {
    return 'Please create a mnemonic for the kanji ' +
        '${item.characterID} using its bulidng $temp: ' +
        '${item.buildingBlockKeywords}';
  } else if (type == 'Radical') {
    return 'Please create a mnemonic for the Radical ${item.characterID}';
  }
  return 'Please create a mnemonic';
}

void pushToItemDetailScreen(
    BuildContext ctx, StudyItem clickedKanji, String routeName) {
  print("pushToItemDetailScreen is called by $routeName");
  if (routeName == "/") {
    ctx.read(targetItemProvider).state = clickedKanji;
    Navigator.of(ctx).pushNamed(ItemDetailScreen.routeName);
  } else {
    Navigator.of(ctx)
        .pushNamed(ItemDetailScreen.routeName, arguments: clickedKanji);
  }
}

Function prevItemDetail(
    {StudyItem item, BuildContext ctx, ScopedReader watch}) {
  final sameLevelItems = watch(chosenlvlListProvider(item.progressLevel));
  final itemIdx = sameLevelItems.indexOf(item);
  if (itemIdx <= 0 || sameLevelItems.length < 1) return null;
  final prevKanji = sameLevelItems[itemIdx - 1];
  return () {
    ctx.read(targetItemProvider).state = prevKanji;
  };
}

Function nextItemDetail(
    {StudyItem item, BuildContext ctx, ScopedReader watch}) {
  final sameLevelItems = watch(chosenlvlListProvider(item.progressLevel));
  final itemIdx = sameLevelItems.indexOf(item);
  if (itemIdx + 1 == sameLevelItems.length) return null;
  final nextKanji = sameLevelItems[itemIdx + 1];
  return () {
    ctx.read(targetItemProvider).state = nextKanji;
  };
}
