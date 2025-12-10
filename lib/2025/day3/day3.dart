import 'dart:math';

import 'package:advent_of_code/day.dart';

class Day3Year2025 extends Day {
  @override
  int get day => 3;

  @override
  int get year => 2025;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var batteries = await readInput<List<List<int>>>(filename, input);
    var sum = 0;

    for (var bank in batteries) {
      var first = 0;
      var second = 0;
      for (var i = 0; i < bank.length - 1; i++) {
        var value = bank[i];
        var next = bank[i + 1];

        if (value > first) {
          first = value;
          second = next;
        }

        if (next > second) {
          second = next;
        }
      }

      sum += first * 10 + second;
    }

    return sum;
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var batteries = await readInput<List<List<int>>>(filename, input);
    var sum = 0;
    final count = 12;

    for (var bank in batteries) {
      var highestJoltages = List.filled(count, 0);
      var bankJoltage = 0;
      var initialBatteryIndex = 0;
      for (var i = 0; i < count; i++) {
        var maxJoltage = 0;
        for (var j = initialBatteryIndex; j <= bank.length - (count - i); j++) {
          if (bank[j] > maxJoltage) {
            maxJoltage = bank[j];
            initialBatteryIndex = j + 1;
          }
        }
        highestJoltages[i] = maxJoltage;
      }

      for (var i = 0; i < highestJoltages.length; i++) {
        bankJoltage +=
            highestJoltages[i] *
            pow(10, highestJoltages.length - i - 1).toInt();
      }

      sum += bankJoltage;
    }

    return sum;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    List<List<int>> batteries = [];
    for (var line in lines) {
      List<int> bank = [];
      for (var i = 0; i < line.length; i++) {
        var d = line[i];
        bank.add(int.parse(d));
      }

      batteries.add(bank);
    }

    return batteries;
  }
}
