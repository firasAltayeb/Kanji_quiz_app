import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:Kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/kanji_progress.json');
}

Future<String> get _loadKanjiAsset async {
  return await rootBundle.loadString('assets/json/kanji_list.json');
}

Future<List<Kanji>> loadKanjiList() async {
  String jsonString = await _loadKanjiAsset;
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((i) => Kanji.fromJson(i)).toList();
}

Future<File> writeProgressUpdate(List<Kanji> kanjiList) async {
  final file = await _localFile;
  String encoded = jsonEncode(kanjiList);
  print(encoded);
  return file.writeAsString(encoded);
}

Future<List<Kanji>> readProgressUpdate() async {
  final file = await _localFile;
  String jsonString = await file.readAsString();
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((i) => Kanji.fromJson(i)).toList();
}
