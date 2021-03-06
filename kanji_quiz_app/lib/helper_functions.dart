import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'screens/input_dialog_screen.dart';
import 'screens/item_detail_screen.dart';
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
  HomeIcon,
  Koohii,
  User,
}

void choiceAction({
  @required BuildContext context,
  @required VertOptions choice,
  List<StudyItem> practiceList,
  List<StudyItem> reviewList,
  List<bool> sessionChoices,
  StudyItem targetKanji,
  bool lvlColumnVisible,
  bool overallVisible,
  ScopedReader watch,
  bool showAlert,
  bool showPopUp,
}) {
  if (choice == VertOptions.Koohii) {
    launchURL(targetKanji);
  } else if (choice == VertOptions.WrapLesson) {
    wrapLessonSession(context, watch);
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
  } else if (choice == VertOptions.HomeIcon) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

void assignNewLessonItems(ScopedReader watch, BuildContext context, rtkLesson) {
  final notReadyList = watch(notReadyListProvider);

  int lessonEndIndex =
      notReadyList.indexWhere((element) => element.characterID == "古");

  if (lessonEndIndex == -1) return;

  for (var index = 0; index < lessonEndIndex; index++) {
    notReadyList[index].progressLevel = 0;
    notReadyList[index].learningStatus = "Lesson";
    context.read(studyItemProvider.notifier).editKanji(notReadyList[index]);
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

void markAsPracticeDialog({
  bool wrapSession = false,
  bool showAlert = true,
  bool naviPop = true,
  StudyItem targetItem,
  BuildContext context,
  String alertMessage,
  ScopedReader watch,
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
    if (targetItem.itemType == "Kanji" &&
        targetItem.learningStatus != "Practice") {
      targetItem.progressLevel = 4;
      targetItem.learningStatus = 'Practice';
    } else {
      targetItem.progressLevel = 7;
      targetItem.learningStatus = 'Acquireds';
    }
    if (naviPop) {
      if (targetItem.progressLevel == 4 &&
          watch(practiceQueueIdxProvider).state > 0)
        targetItem.learningStatus = "Queued";
      targetItem.dateLastLevelChanged = DateTime.now();
      context.read(studyItemProvider.notifier).editKanji(targetItem);
      Navigator.of(context).pop();
    } else if (wrapSession) {
      if (targetItem.progressLevel == 4 &&
          watch(practiceQueueIdxProvider).state > 0)
        targetItem.learningStatus = "Queued";
      wrapLessonSession(context, watch);
    } else {
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
  ScopedReader watch,
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
    targetItem.mnemonicStory = '';
    if (watch(lessonQueueIdxProvider).state > 0) {
      targetItem.learningStatus = "Queued";
    } else {
      targetItem.progressLevel = 0;
      targetItem.learningStatus = "Lesson";
    }
    context.read(studyItemProvider.notifier).editKanji(targetItem);
    if (naviPop) {
      context.read(studyItemProvider.notifier).saveProgress();
      Navigator.of(context).pop();
    } else {
      if (watch(lessonQueueIdxProvider).state > 0) {
        context.read(lessonQueueIdxProvider).state--;
      } else {
        context.read(lessonQueueIdxProvider).state++;
      }
    }
  }
}

void wrapLessonSession(BuildContext context, ScopedReader watch) {
  final queuedList = watch(queuedListProvider);
  unQueueItems(queuedList, "Lesson", 0, context);

  final lsnQueueIndex = watch(lessonQueueIdxProvider).state;
  final lessonList = watch(inLessonListProvider);
  for (var index = 0; index <= lsnQueueIndex; index++) {
    StudyItem lessonItem = lessonList[index];
    //dont change item if marked as prac or acqu
    if (lessonItem.progressLevel > 0) return;

    if (watch(reviewQueueIdxProvider).state > 0)
      lessonItem.learningStatus = "Queued";
    else
      lessonItem.learningStatus = 'Review';

    lessonItem.progressLevel = 1;
    lessonItem.dateLastLevelChanged = DateTime.now();
    context.read(studyItemProvider.notifier).editKanji(lessonItem);
  }

  context.read(lessonQueueIdxProvider).state = 0;
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}

void unQueueItems(queuedList, newStatus, lvlInQus, context) {
  if (queuedList != null)
    queuedList.forEach((item) {
      if (item.progressLevel == lvlInQus) {
        item.learningStatus = newStatus;
        item.dateLastLevelChanged = DateTime.now();
        context.read(studyItemProvider.notifier).editKanji(item);
      }
    });
}

void wrapReviewSession(BuildContext context, sessionChoices, reviewList) {
  for (var index = 0; index < sessionChoices.length; index++) {
    StudyItem reviewedItem = reviewList[index];
    reviewedItem.dateLastLevelChanged = DateTime.now();
    //if answer was correct
    if (sessionChoices[index]) {
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
    } else if (!sessionChoices[index]) {
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
  context.read(sentenceQueueIdxProvider).state = 0;
  context.read(practiceQueueIdxProvider).state = 0;
  context.read(answeredRevealedProvider).state = false;
  context.read(sessionChoicesListProvider).state.clear();
  context.read(studyItemProvider.notifier).saveProgress();
  Navigator.pop(context);
}

List<StudyItem> correctItemList(itemList, sessionChoices) {
  List<StudyItem> itemsMarkedCorrect = [];
  for (var index = 0; index < sessionChoices.length; index++)
    if (sessionChoices[index]) itemsMarkedCorrect.add(itemList[index]);
  return itemsMarkedCorrect;
}

List<StudyItem> incorrectItemList(itemList, sessionChoices) {
  List<StudyItem> itemsMarkedCorrect = [];
  for (var index = 0; index < sessionChoices.length; index++)
    if (!sessionChoices[index]) itemsMarkedCorrect.add(itemList[index]);
  return itemsMarkedCorrect;
}

void editDataHandler(
    {BuildContext buildContext, StudyItem studyItem, bool forKeyword}) {
  if (forKeyword) buildContext.read(keywordPressedProvider).state = true;
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
