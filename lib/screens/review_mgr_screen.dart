import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/review/result_review_page.dart';
import '../widgets/review/recall_review_page.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class ReviewManager extends StatelessWidget {
  static const routeName = '/review-screen';

  void _undoAnswer(BuildContext ctx, ansChoiceList, queueIdx, reviewList) {
    if (ansChoiceList[queueIdx - 1]) {
      ctx.read(sessionScoreProvider).state -= 5;
      ctx.read(correctRecallListProvider).state.removeLast();
    } else {
      ctx.read(incorrectRecallListProvider).state.removeLast();
    }
    ctx.read(targetKanjiProvider).state = reviewList[queueIdx - 1];
    ctx.read(answerChoiceListProvider).state.removeLast();
    ctx.read(reviewQueueIdxProvider).state--;
  }

  void _wrapSession(BuildContext context, answerChoiceList, reviewList) {
    for (var index = 0; index < answerChoiceList.length; index++) {
      Kanji reviewedItem = reviewList[index];
      reviewedItem.dateLastLevelChanged = DateTime.now();

      if (answerChoiceList[index]) {
        //if answer was correct
        reviewedItem.progressLevel++; // = currentProgressLevel + 1;
        if (reviewedItem.progressLevel >= 5)
          reviewedItem.learningStatus = 'Pratice';
      } else {
        //if answer was incorrect
        reviewedItem.progressLevel = reviewedItem.newProgressLevel();
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

  Widget build(BuildContext context) {
    List<Kanji> _reviewList = ModalRoute.of(context).settings.arguments;

    print('Review mgr build called');

    if (_reviewList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Review page',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _queueIndex = watch(reviewQueueIdxProvider).state;
        final _ansChoiceList = watch(answerChoiceListProvider).state;
        return _queueIndex < _reviewList.length
            ? RecallPage(
                queueIndex: _queueIndex,
                reviewQueue: _reviewList,
                undoLastAnswer: () => _undoAnswer(
                    bldCtx, _ansChoiceList, _queueIndex, _reviewList),
              )
            : ResultPage(
                wrapSession: () =>
                    _wrapSession(bldCtx, _ansChoiceList, _reviewList),
                undoLastAnswer: () => _undoAnswer(
                    bldCtx, _ansChoiceList, _queueIndex, _reviewList),
              );
      }),
    );
  }
}
