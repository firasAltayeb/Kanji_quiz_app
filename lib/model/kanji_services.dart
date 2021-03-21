import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:kanji_quiz_app/model/kanji_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

Future<String> get _loadKanjiAsset async {
  return await rootBundle.loadString('assets/json/kanji_list.json');
}

Future<String> get _localPath async {
  Directory directory = await getExternalStorageDirectory();
  var path = directory.path;
  var newPath = path.substring(0, path.indexOf("Android"));
  return "${newPath}KanjiQuiz";
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/kanji_progress.json');
}

Future<List<Kanji>> loadKanjiList(String jsonString) async {
  List<dynamic> jsonResponse = json.decode(jsonString);
  //print("jsonResponse is \n" + "$jsonResponse");
  return jsonResponse.map((i) => Kanji.fromJson(i)).toList();
}

Future<List<Kanji>> readProgressUpdate() async {
  String jsonString;
  final file = await _localFile;
  final jsonFileExist = await file.exists();
  var status = await Permission.storage.status;

  if (jsonFileExist && status.isGranted) {
    print("local json file exists");
    jsonString = await file.readAsString();
  } else {
    print("local json file doesn't exists");
    jsonString = await _loadKanjiAsset;
  }

  return compute(loadKanjiList, jsonString);
}

Future<File> writeProgressUpdate(List<Kanji> kanjiList) async {
  final path = await _localPath;
  final directory = Directory(path);

  if (!await directory.exists()) {
    print("write directory doesn't exists");
    await directory.create(recursive: true);
  }

  final file = await _localFile;
  if (!await file.exists()) {
    print("write file doesn't exists");
    print("new location ${file.path}");
    await file.create(recursive: true);
  }

  String encoded = jsonEncode(kanjiList);
  return file.writeAsString(encoded);
}
