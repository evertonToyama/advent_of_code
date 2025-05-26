import 'package:advent_of_code/utils/file.dart';

abstract class Day {
  final int day;
  final int year;

  const Day(this.day, this.year);

  Future<Object> part1({String filename = "input.txt"});

  Future<Object> part2({String filename = "input.txt"});

  Future<E> readInput<E>(String filename) async {
    var content = await FileUtils.readFromDay(day, year);
    return loadContent(content) as E;
  }

  Object loadContent(String content);
}
