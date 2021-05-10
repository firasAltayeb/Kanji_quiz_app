import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../widgets/practice_mgr/sen_translation_btn.dart';
import '../widgets/practice_mgr/practice_app_bar.dart';
import '../widgets/shared/corner_button.dart';
import '../widgets/shared/corner_widget.dart';
import '../model/aozora_bunko_sites.dart';
import '../model/kanji_model.dart';
import '../main_providers.dart';

class PracticeManager extends ConsumerWidget {
  static const routeName = '/practice-screen';

  void _skipSentence(
      BuildContext ctx, senQueueIdx, practiceList, practiceQueueIdx) {
    if (senQueueIdx < 15) {
      ctx.read(sentenceQueueIdxProvider).state++;
    } else {
      ctx.read(sentenceQueueIdxProvider).state = 1;
      ctx.read(targetKanjiProvider).state = practiceList[practiceQueueIdx + 1];
      ctx.read(practiceQueueIdxProvider).state++;
    }
  }

  void _previousSentence(
      BuildContext ctx, senQueueIdx, practiceList, practiceQueueIdx) {
    if (senQueueIdx > 1) {
      ctx.read(sentenceQueueIdxProvider).state--;
    } else if (senQueueIdx <= 1 && practiceQueueIdx > 0) {
      ctx.read(targetKanjiProvider).state = practiceList[practiceQueueIdx - 1];
      ctx.read(practiceQueueIdxProvider).state--;
    }
  }

  // void _webScraperScrap() async {
  //   var novelSubPage = "";
  //   final rawUrl = aozoraBunkoSites[0];
  //   final webScraper = WebScraper('https://www.aozora.gr.jp');
  //   final endpoint = rawUrl.replaceAll('https://www.aozora.gr.jp', '');
  //   print("endpoint is $endpoint");
  //   if (await webScraper.loadWebPage(endpoint)) {
  //     final pageContent = webScraper.getPageContent();
  //     final queriedStartIndex = pageContent.indexOf("/files/");
  //     novelSubPage =
  //         pageContent.substring(queriedStartIndex, queriedStartIndex + 23);
  //     print(novelSubPage);
  //   }
  //   final newEndPoint =
  //       endpoint.replaceAll(RegExp('/card[0-9]*.html'), novelSubPage);
  //   print("newEndPoint is $newEndPoint");
  //   if (await webScraper.loadWebPage(newEndPoint)) {
  //     final pageContent = webScraper.getPageContent();
  //     print(pageContent);
  //   }
  // }

  void _manualSiteScrap() async {
    var client = Client();
    var novelSubPage = "";
    final rawUrl = aozoraBunkoSites[0];
    Response response = await client.get(rawUrl);
    print(utf8.decode(response.bodyBytes));
    final queriedStartIndex = response.body.indexOf("/files/");
    novelSubPage =
        response.body.substring(queriedStartIndex, queriedStartIndex + 23);
    final newUrl = rawUrl.replaceAll(RegExp('/card[0-9]*.html'), novelSubPage);
    print("newUrl is $newUrl");
    Response newResponse = await client.get(newUrl);
    print(newResponse.body);
    print(utf8.decode(newResponse.bodyBytes, allowMalformed: true));
  }

  Widget build(BuildContext context, ScopedReader watch) {
    List<Kanji> _practiceList = ModalRoute.of(context).settings.arguments;
    final _practiceQueueIdx = watch(practiceQueueIdxProvider).state;
    final _senQueueIdx = watch(sentenceQueueIdxProvider).state;
    final _targetKanji = watch(targetKanjiProvider).state;

    _manualSiteScrap();

    var _screenHeight = MediaQuery.of(context).size.height;
    var _sentenceRemainingStatus =
        _senQueueIdx < 10 ? " 0$_senQueueIdx/15" : " $_senQueueIdx/15";

    print('Practice mgr build called');

    if (_practiceList.isEmpty == true) {
      return Scaffold();
    }

    return Scaffold(
      appBar: PracticeAppBar(
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CornerButton(
                passedText: "Perv",
                handler: _senQueueIdx == 1 && _practiceQueueIdx == 0
                    ? null
                    : () => _previousSentence(
                          context,
                          _senQueueIdx,
                          _practiceList,
                          _practiceQueueIdx,
                        ),
                height: _screenHeight * 1.1,
              ),
              CornerWidget(
                passedText: _targetKanji.characterID + _sentenceRemainingStatus,
                height: _screenHeight * 1.3,
              ),
              CornerButton(
                passedText: "Skip",
                handler: () => _skipSentence(
                  context,
                  _senQueueIdx,
                  _practiceList,
                  _practiceQueueIdx,
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
            "Sentence example $_senQueueIdx",
            style: TextStyle(
              fontSize: _screenHeight * 0.04,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(flex: 5, child: SizedBox()),
          TranslationOptionBtn(
            _practiceList,
          ),
          Expanded(child: SizedBox()),
          TranslationOptionBtn(
            _practiceList,
          ),
          Expanded(child: SizedBox()),
          TranslationOptionBtn(
            _practiceList,
          ),
          Expanded(child: SizedBox()),
          TranslationOptionBtn(
            _practiceList,
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
