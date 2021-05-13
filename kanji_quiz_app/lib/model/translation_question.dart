import 'package:flutter/foundation.dart';

List<TranslationQuestion> translationQuestions = [
  TranslationQuestion(quesitonText: "彼は早口だ。", answerList: [
    TranslationQusAnswer(
      answerText: "He speaks fast.",
      accuracy: 100,
    ),
    TranslationQusAnswer(
      answerText: "His mouth is fast.",
      accuracy: 80,
    ),
    TranslationQusAnswer(
      answerText: "He is early.",
      accuracy: 40,
    ),
    TranslationQusAnswer(
      answerText: "His mouth is early.",
      accuracy: 0,
    ),
  ]),
  TranslationQuestion(quesitonText: "良い一日を。", answerList: [
    TranslationQusAnswer(
      answerText: "Have a good sun.",
      accuracy: 60,
    ),
    TranslationQusAnswer(
      answerText: "Have a nice month.",
      accuracy: 40,
    ),
    TranslationQusAnswer(
      answerText: "Have a good day.",
      accuracy: 100,
    ),
    TranslationQusAnswer(
      answerText: "Have a good one.",
      accuracy: 0,
    ),
  ]),
];

class TranslationQuestion {
  final String quesitonText;
  final List<TranslationQusAnswer> answerList;

  TranslationQuestion({
    @required this.quesitonText,
    @required this.answerList,
  });
}

class TranslationQusAnswer {
  final String answerText;
  final int accuracy;

  TranslationQusAnswer({
    @required this.answerText,
    @required this.accuracy,
  });
}
