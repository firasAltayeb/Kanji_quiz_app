import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../widgets/screen_practice/sen_translation_btn.dart';
import '../widgets/screen_practice/practice_app_bar.dart';
import '../widgets/shared/corner_button.dart';
import '../widgets/shared/corner_widget.dart';
import '../model/translation_question.dart';
import '../model/study_item_model.dart';
import '../helper_functions.dart';
import '../main_providers.dart';

class PracticeManager extends ConsumerWidget {
  static const routeName = '/practice-screen';

  void _skipSentence(
      BuildContext ctx, senQueueIdx, ansChoiceList, pracList, pracQueueIdx) {
    if (senQueueIdx < 15) {
      ctx.read(sentenceQueueIdxProvider).state++;
    } else if (pracQueueIdx < pracList.length - 1) {
      ctx.read(sentenceQueueIdxProvider).state = 1;
      ctx.read(practiceQueueIdxProvider).state++;
      ctx.read(sessionChoicesListProvider).state.add(null);
    } else {
      wrapPracticeSession(ctx, ansChoiceList, pracList);
    }
  }

  void _previousSentence(
      BuildContext ctx, senQueueIdx, practiceList, practiceQueueIdx) {
    if (senQueueIdx > 1) {
      ctx.read(sentenceQueueIdxProvider).state--;
    } else if (senQueueIdx == 1 && practiceQueueIdx > 0) {
      ctx.read(practiceQueueIdxProvider).state--;
      ctx.read(sessionChoicesListProvider).state.removeLast();
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<StudyItem> _pracList = ModalRoute.of(context).settings.arguments;
    final _pracQueueIdx = watch(practiceQueueIdxProvider).state;
    final _targetKanji = _pracList[_pracQueueIdx];

    final _sessionChoices = watch(sessionChoicesListProvider).state;
    final _answeredRevealed = watch(answeredRevealedProvider).state;
    final _senQueueIdx = watch(sentenceQueueIdxProvider).state;
    final _questionList = translationQuestions;

    var _screenHeight = MediaQuery.of(context).size.height;
    var _sentenceRemainingStatus =
        _senQueueIdx < 10 ? " 0$_senQueueIdx/15" : " $_senQueueIdx/15";

    print('Practice mgr build called');

    if (_pracList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: PracticeAppBar(
        appBar: AppBar(),
        practiceList: _pracList,
        sessionChoicesList: _sessionChoices,
      ),
      body: Column(
        children: [
          Container(
            height: _screenHeight * 0.03,
            color: Colors.grey[300],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CornerButton(
                passedText: "Perv",
                handler: (_senQueueIdx == 1 && _pracQueueIdx == 0) ||
                        _answeredRevealed
                    ? null
                    : () => _previousSentence(
                          context,
                          _senQueueIdx,
                          _pracList,
                          _pracQueueIdx,
                        ),
                height: _screenHeight * 1.1,
              ),
              CornerWidget(
                passedText: _targetKanji.characterID + _sentenceRemainingStatus,
                height: _screenHeight * 1.3,
              ),
              CornerButton(
                passedText: "Skip",
                handler: _answeredRevealed
                    ? null
                    : () => _skipSentence(
                          context,
                          _senQueueIdx,
                          _sessionChoices,
                          _pracList,
                          _pracQueueIdx,
                        ),
                height: _screenHeight * 1.1,
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text(
            "Choose the most correct translation for the following sentence?",
            style: TextStyle(
              fontSize: _screenHeight * 0.03,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(flex: 3, child: SizedBox()),
          Text(
            _questionList[_pracQueueIdx % 2].quesitonText,
            style: TextStyle(
              fontSize: _screenHeight * 0.05,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(flex: 5, child: SizedBox()),
          ...(_questionList[_pracQueueIdx % 2].answerList)
              .map((answerOption) => TranslationOptionBtn(
                    answerColor: answerOption.accuracy == 100
                        ? Colors.green
                        : Colors.red,
                    practiceList: _pracList,
                    questionAnswer: answerOption,
                    sessionChoices: _sessionChoices,
                  ))
              .toList(),
          SizedBox(
            height: _screenHeight * 0.015,
          ),
        ],
      ),
    );
  }
}
