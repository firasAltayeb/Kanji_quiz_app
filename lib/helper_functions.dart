import 'package:kanji_quiz_app/widgets/misc/back_pressed_alert.dart';
import 'package:kanji_quiz_app/screens/input_dialog_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:kanji_quiz_app/main_providers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void openChoiceDialog(
  ScopedReader watch,
  BuildContext context,
  Kanji targetKanji,
  Function bottomRowHandler,
  String alertMessage, [
  List<Kanji> lessonList,
]) async {
  final queueIndex = watch(lessonQueueIdxProvider).state;
  var dialogChoice = await BackPressedAlert().dialog(
        parentCtx: context,
        alertMsg: alertMessage,
      ) ??
      false;
  if (dialogChoice) {
    bottomRowHandler(context, targetKanji);
    if (lessonList == null) {
      Navigator.of(context).pop();
    } else {
      context.read(targetKanjiProvider).state = lessonList[queueIndex + 1];
      context.read(lessonQueueIdxProvider).state++;
    }
  }
}

void markAsComplete(BuildContext context, Kanji targetKanji) {
  targetKanji.progressLevel = 6;
  if (targetKanji.itemType == "Kanji")
    targetKanji.learningStatus = 'Practice';
  else if (targetKanji.itemType != "Kanji")
    targetKanji.learningStatus = 'Learned';
  context.read(kanjiListProvider.notifier).editKanji(targetKanji);
  context.read(kanjiListProvider.notifier).saveProgress();
}

void resetItemStatus(BuildContext context, Kanji targetKanji) {
  targetKanji.learningStatus = 'Lesson';
  targetKanji.progressLevel = 0;
  targetKanji.mnemonicStory = '';
  context.read(kanjiListProvider.notifier).editKanji(targetKanji);
  context.read(kanjiListProvider.notifier).saveProgress();
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

void wrapSession(BuildContext context, answerChoiceList, reviewList) {
  for (var index = 0; index < answerChoiceList.length; index++) {
    Kanji reviewedItem = reviewList[index];
    reviewedItem.dateLastLevelChanged = DateTime.now();
    //if answer was correct
    if (answerChoiceList[index]) {
      // current progress + 1
      reviewedItem.progressLevel++;
      reviewedItem.recallHistory.add("Correct");
      //when lvl is 5 practice if kanji else learned
      if (reviewedItem.progressLevel > 5) {
        if (reviewedItem.itemType == "Kanji")
          reviewedItem.learningStatus = 'Practice';
        else if (reviewedItem.itemType != "Kanji")
          reviewedItem.learningStatus = 'Learned';
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
