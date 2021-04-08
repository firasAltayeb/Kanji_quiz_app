import 'package:flutter/material.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';

class KanjiData with ChangeNotifier {
  List<Kanji> _items = [
    Kanji(),
    Kanji(),
    Kanji(),
    Kanji(),
  ];

  List<Kanji> get items {
    return [..._items];
  }
}
