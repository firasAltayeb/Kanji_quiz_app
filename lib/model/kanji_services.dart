import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:Kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<String> get _loadKanjiAsset async {
  return await rootBundle.loadString('assets/json/kanji_list.json');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/kanji_progress.json');
}

Future<List<Kanji>> readProgressUpdate() async {
  String jsonString;
  final file = await _localFile;
  final jsonFileExist = await file.exists();

  if (jsonFileExist) {
    print("File exists");
    jsonString = await file.readAsString();
  } else {
    print("File doesn't exists");
    jsonString = await _loadKanjiAsset;
  }

  return loadKanjiList(jsonString);
}

Future<List<Kanji>> loadKanjiList(String jsonString) async {
  List<dynamic> jsonResponse = json.decode(jsonString);
  print("jsonResponse is \n" + "$jsonResponse");
  return jsonResponse.map((i) => Kanji.fromJson(i)).toList();
}

Future<File> writeProgressUpdate(List<Kanji> kanjiList) async {
  final file = await _localFile;
  file.create();

  String encoded = jsonEncode(kanjiList);
  print("file found in $file");
  print("encoded data is $encoded");
  return file.writeAsString(encoded);
}
