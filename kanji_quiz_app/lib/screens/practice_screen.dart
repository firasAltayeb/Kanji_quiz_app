import 'package:kanji_quiz_app/widgets/main_screen/home_app_bar.dart';
import 'package:kanji_quiz_app/widgets/shared/corner_button.dart';
import 'package:kanji_quiz_app/widgets/shared/corner_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class PracticeManager extends ConsumerWidget {
  static const routeName = '/practice-screen';

  void _undoAnswer(BuildContext ctx, queueIdx, practiceList) {
    if (queueIdx > 0) {
      ctx.read(targetKanjiProvider).state = practiceList[queueIdx - 1];
      ctx.read(practiceQueueIdxProvider).state--;
    }
  }

  void _nextKanji(BuildContext ctx, queueIdx, practiceList) {
    if (queueIdx < practiceList.length - 1) {
      ctx.read(targetKanjiProvider).state = practiceList[queueIdx + 1];
      ctx.read(practiceQueueIdxProvider).state++;
    } else {
      ctx.read(practiceQueueIdxProvider).state = 0;
      ctx.read(kanjiListProvider.notifier).saveProgress();
      Navigator.pop(ctx);
    }
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<Kanji> _practiceList = ModalRoute.of(context).settings.arguments;
    final _queueIndex = watch(practiceQueueIdxProvider).state;
    final screenHeight = MediaQuery.of(context).size.height;
    final _targetKanji = watch(targetKanjiProvider).state;
    final screenWidth = MediaQuery.of(context).size.width;

    print('Practice mgr build called');

    if (_practiceList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: HomeAppBar(
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CornerButton(
                passedText: "Back",
                handler: _queueIndex == 0
                    ? null
                    : () => _undoAnswer(
                          context,
                          _queueIndex,
                          _practiceList,
                        ),
                height: screenHeight,
              ),
              CornerWidget(
                passedText: _targetKanji.characterID + " 01/15",
                height: screenHeight * 1.2,
              ),
              CornerButton(
                passedText: "Skip",
                handler: () => _nextKanji(
                  context,
                  _queueIndex,
                  _practiceList,
                ),
                height: screenHeight,
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text(
            "Choose the most correct translation for the following sentence?",
            style: TextStyle(
              fontSize: screenHeight * 0.03,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(flex: 3, child: SizedBox()),
          Text(
            "Sentence example",
            style: TextStyle(
              fontSize: screenHeight * 0.04,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(flex: 5, child: SizedBox()),
          _answerButton(context, screenHeight, screenWidth),
          Expanded(child: SizedBox()),
          _answerButton(context, screenHeight, screenWidth),
          Expanded(child: SizedBox()),
          _answerButton(context, screenHeight, screenWidth),
          Expanded(child: SizedBox()),
          _answerButton(context, screenHeight, screenWidth),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _answerButton(BuildContext context, screenHeight, screenWidth) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      width: screenWidth * 0.95,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Theme.of(context).accentColor,
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          "extracted sentence translation \n answer button option",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
