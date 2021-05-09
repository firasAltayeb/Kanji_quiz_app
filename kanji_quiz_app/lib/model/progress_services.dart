import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_io/io.dart' show Platform;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import '../model/progress_model.dart';

Future<String> get _assetsJsonString async {
  return await rootBundle.loadString('assets/json/progress_list.json');
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

Future<List<Progress>> _loadProgressList(String jsonString) async {
  List<dynamic> jsonResponse = json.decode(jsonString);
  //print("jsonResponse is \n" + "$jsonResponse");
  return jsonResponse.map((i) => Progress.fromJson(i)).toList();
}

Future<String> get _androidProgressData async {
  final file = await _localFile;
  final jsonFileExist = await file.exists();
  var status = await Permission.storage.status;

  if (jsonFileExist && status.isGranted) {
    print("local json file exists");
    return await file.readAsString();
  }
  return await _assetsJsonString;
}

Future<List<Progress>> readProgressUpdate() async {
  String jsonString;

  if (Platform.isAndroid) {
    jsonString = await _androidProgressData;
  } else {
    print("local json file doesn't exists");
    jsonString = await _assetsJsonString;
  }

  return compute(_loadProgressList, jsonString);
}

Future<File> writeProgressUpdate(List<Progress> progressList) async {
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
  print("write file encoded");
  String encoded = jsonEncode(progressList);
  return file.writeAsString(encoded);
}
