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
    List<Kanji> _practiceList = ModalRoute.of(context).settings.arguments;

    print('Practice mgr build called');

    if (_practiceList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: MainAppBar(
        title: 'Pratice page',
        appBar: AppBar(),
      ),
      body: Consumer(builder: (bldCtx, watch, _) {
        final _queueIndex = watch(practiceQueueIdxProvider).state;
        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
              ),
            ),
            _answerButton(bldCtx),
            Expanded(child: SizedBox()),
          ],
        );
      }),
    );
  }

  Widget _answerButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.04,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Answer Choice',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
