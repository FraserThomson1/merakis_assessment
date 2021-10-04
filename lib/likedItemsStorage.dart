import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class likedItemsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/liked.txt');
  }

  Future<List> readItems() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return json.decode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeItems(List wps) async {
    final file = await _localFile;
    return file.writeAsString(json.encode(wps));
  }
}
