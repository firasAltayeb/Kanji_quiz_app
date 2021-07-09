import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_review/result_review_page.dart';
import '../widgets/screen_review/recall_review_page.dart';
import '../widgets/screen_review/review_app_bar.dart';
import '../model/study_item_model.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class ReviewManager extends ConsumerWidget {
  static const routeName = '/review-screen';

  void _undoAnswer(BuildContext ctx, ansChoiceList, queueIdx, reviewList) {
    if (ansChoiceList[queueIdx - 1]) {
      ctx.read(sessionScoreProvider).state -= 5;
      ctx.read(correctRecallListProvider).state.removeLast();
    } else {
      ctx.read(incorrectRecallListProvider).state.removeLast();
    }
    ctx.read(sessionChoicesListProvider).state.removeLast();
    ctx.read(reviewQueueIdxProvider).state--;
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<StudyItem> _reviewList = ModalRoute.of(context).settings.arguments;
    final _sessionChoices = watch(sessionChoicesListProvider).state;
    final _queueIndex = watch(reviewQueueIdxProvider).state;
    final _showSrsPop = watch(showSrsPopUpProvider).state;

    print('Review mgr build called');

    if (_reviewList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: ReviewAppBar(
        appBar: AppBar(),
        showSrsPop: _showSrsPop,
        reviewList: _reviewList,
        sessionChoices: _sessionChoices,
      ),
      body: _queueIndex < _reviewList.length
          ? RecallPage(
              queueIndex: _queueIndex,
              reviewQueue: _reviewList,
              undoLastAnswer: () => _undoAnswer(
                  context, _sessionChoices, _queueIndex, _reviewList),
            )
          : ResultPage(
              wrapSession: () =>
                  wrapReviewSession(context, _sessionChoices, _reviewList),
              undoLastAnswer: () => _undoAnswer(
                  context, _sessionChoices, _queueIndex, _reviewList),
            ),
    );
  }
}
