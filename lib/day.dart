import 'package:advent_of_code/utils/file.dart';

abstract class Day {
  int get day;
  int get year;

  Future<Object> part1({String filename = "input.txt", String? input});

  Future<Object> part2({String filename = "input.txt", String? input});

  Future<E> readInput<E>(String filename, String? input) async {
    var content = input ?? await FileUtils.readFromDay(day, year);
    return loadContent(content) as E;
  }

  Object loadContent(String content);
}
