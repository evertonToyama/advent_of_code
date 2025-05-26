import 'dart:io';
import 'dart:typed_data';

class FileUtils {
  static Future<String> readFromDay(int day, int year) {
    return readFromFile('lib/$year/day$day/input.txt');
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

  static File loadFile(String filename) {
    return File(filename);
  }
}
