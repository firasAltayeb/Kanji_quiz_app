import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/review/result_review_page.dart';
import '../widgets/review/recall_review_page.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class ReviewManager extends ConsumerWidget {
  static const routeName = '/review-screen';

  void _undoAnswer(BuildContext context, answerChoiceList, queueIdx) {
    if (answerChoiceList[queueIdx - 1]) {
      context.read(sessionScoreProvider).state -= 5;
      context.read(correctRecallListProvider).state.removeLast();
    } else {
      context.read(incorrectRecallListProvider).state.removeLast();
    }
    context.read(answerChoiceListProvider).state.removeLast();
    context.read(reviewQueueIdxProvider).state--;
  }

  void _wrapSession(BuildContext context, answerChoiceList, reviewList) {
    for (var index = 0; index < answerChoiceList.length; index++) {
      Kanji reviewedItem = reviewList[index];
      int currentProgressLevel = reviewedItem.progressLevel;
      reviewedItem.dateLastLevelChanged = DateTime.now();

      if (answerChoiceList[index]) {
        reviewedItem.progressLevel = currentProgressLevel + 1;
        if (reviewedItem.progressLevel >= 5)
          reviewedItem.learningStatus = 'Pratice';
      } else {
        if (currentProgressLevel > 1)
          reviewedItem.progressLevel = currentProgressLevel - 1;
      }
      context.read(kanjiListProvider.notifier).editKanji(reviewedItem);
    }
    context.read(sessionScoreProvider).state = 0;
    context.read(reviewQueueIdxProvider).state = 0;
    context.read(answerChoiceListProvider).state.clear();
    context.read(correctRecallListProvider).state.clear();
    context.read(incorrectRecallListProvider).state.clear();
    Navigator.pop(context);
  }

  Widget build(BuildContext bldCtx, ScopedReader watch) {
    final _reviewList = watch(reviewListProvider);
    final _queueIndex = watch(reviewQueueIdxProvider).state;
    final _ansChoiceList = watch(answerChoiceListProvider).state;
    print('Review mgr build called');

    if (_reviewList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Review page',
        appBar: AppBar(),
      ),
      body: _queueIndex < _reviewList.length
          ? RecallPage(
              questionIndex: _queueIndex,
              reviewQueue: _reviewList,
              undoLastAnswer: () =>
                  _undoAnswer(bldCtx, _ansChoiceList, _queueIndex),
            )
          : ResultPage(
              wrapSession: () =>
                  _wrapSession(bldCtx, _ansChoiceList, _reviewList),
              undoLastAnswer: () =>
                  _undoAnswer(bldCtx, _ansChoiceList, _queueIndex),
            ),
    );
  }
}
