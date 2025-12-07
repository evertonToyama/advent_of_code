import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class FileUtils {
  static Future<String> readFromDay(int day, int year) {
    return readFromFile('lib/$year/day$day/input.txt');
  }

  static Future<String> getAnswer({
    required int day,
    required int year,
    required int part,
  }) async {
    return await readFromFile("lib/$year/day$day/answer-$part.txt");
  }

  static void writeAnswer({
    required int day,
    required int year,
    required int part,
    required String answer,
  }) {
    writeToFile("lib/$year/day$day/answer-$part.txt", utf8.encode(answer));
  }

  static void deleteAnswer({
    required int day,
    required int year,
    required int part,
  }) {
    renameFile("lib/$year/day$day/answer-$part.txt", "answer-$part-ignore.txt");
  }

  static Future<String> readFromFile(String filename) async {
    var file = loadFile(filename);

    if (!file.existsSync()) {
      print("File not found");
      return "";
    }

    return file.readAsString();
  }

  static void writeToFile(String filename, Uint8List content) {
    var file = loadFile(filename);

    file.writeAsBytes(content);
  }

  static void renameFile(String filename, String newFileName) {
    var file = loadFile(filename);

    if (!file.existsSync()) {
      print("File not found");
      return;
    }

    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    file.rename(newPath);
  }

  static File loadFile(String filename) {
    return File(filename);
  }
}
