import 'dart:convert';
import 'dart:async' show Future;
import 'package:Kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadKanjiAsset() async {
  return await rootBundle.loadString('assets/json/kanji_list.json');
}

Future<List<Kanji>> loadKanjiList() async {
  String jsonString = await _loadKanjiAsset();
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((i) => Kanji.fromJson(i)).toList();
}
