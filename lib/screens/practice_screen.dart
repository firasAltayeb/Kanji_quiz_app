import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import '../widgets/shared/main_app_bar.dart';
import 'package:flutter/material.dart';
import '../main_providers.dart';

class PracticeManager extends StatelessWidget {
  static const routeName = '/practice-screen';

  void _undoAnswer(BuildContext ctx, ansChoiceList, queueIdx, practiceList) {
    ctx.read(targetKanjiProvider).state = practiceList[queueIdx - 1];
    ctx.read(practiceQueueIdxProvider).state--;
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<Kanji> _practiceList = ModalRoute.of(context).settings.arguments;

    print('Practice mgr build called');

    if (_practiceList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        passedTitle: 'Pratice',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _queueIndex = watch(practiceQueueIdxProvider).state;
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            _answerButton(bldCtx, screenHeight),
            Expanded(child: SizedBox()),
          ],
        );
      }),
    );
  }

  Widget _answerButton(BuildContext context, screenHeight) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.1,
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
          "Can you recall this character? \n Did you remember correctly?",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
