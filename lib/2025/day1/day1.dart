import 'package:advent_of_code/day.dart';

class Day1Year2025 extends Day {
  @override
  int get day => 1;

  @override
  int get year => 2025;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var sequence = await readInput<List<int>>(filename, input);
    var dial = 50;
    var zeroCounter = 0;

    for (var rotation in sequence) {
      dial += rotation;
      dial %= 100;

      if (dial == 0) {
        zeroCounter++;
      }
    }

    return zeroCounter;
  }

  // 6769 -> too high
  // 6040 -> too low
  // 5733 -> too low
  // 6788 -> wrong
  // 6671 -> right
  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var sequence = await readInput<List<int>>(filename, input);
    var dial = 50;
    var zeroCounter = 0;

    for (var rotation in sequence) {
      var turns = rotation.abs() ~/ 100;
      var remainder = (rotation.abs() % 100) * rotation.sign;

      dial += remainder;

      if (dial >= 100 || (dial <= 0 && dial != remainder)) {
        zeroCounter++;
      }

      zeroCounter += turns;

      dial %= 100;
    }

    return zeroCounter;
  }

  @override
  Object loadContent(String content) {
    var arr = content.split('\n');
    List<int> result = [];

    for (var rotation in arr) {
      final sign = rotation.contains('R') ? 1 : -1;
      final value = int.parse(rotation.substring(1));

      result.add(value * sign);
    }

    return result;
  }
}
