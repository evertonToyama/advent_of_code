import 'dart:math';

import 'package:advent_of_code/day.dart';

class Day11Year2024 extends Day {
  @override
  int get day => 11;

  @override
  int get year => 2024;

  /*
  186996 - right
  */
  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var stones = await readInput<List<int>>(filename, input);

    for (var i = 0; i < 25; i++) {
      stones = blink(stones);
    }

    return stones.length;
  }

  /*
    221683913164898 - right*
  */
  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var stones = await readInput<List<int>>(filename, input);
    // print(stones);

    // for (var i = 0; i < 75; i++) {
    //   print('Starting Blink ${i + 1}');
    //   blink(stones);
    // }

    var result = 0;
    for (var i = 0; i < stones.length; i++) {
      result += answer(stones[i], 75);
    }

    // print(stones);

    return result;
  }

  List<int> blink(List<int> stones) {
    var digits = 0;
    var result = <int>[];
    for (var i = 0; i < stones.length; i++) {
      if (stones[i] == 0) {
        result.add(1);
      } else if ((digits = getNumberDigitsBetter(stones[i])).isEven) {
        var base = pow(10, digits / 2);
        var leftHalf = (stones[i] % base).toInt();
        var rightHalf = stones[i] ~/ base;

        result.add(rightHalf);
        result.add(leftHalf);
      } else {
        result.add(stones[i] * 2024);
      }
    }

    return result;
  }

  Map<(int, int), int> cache = {};
  int answer(int value, int step) {
    var result = 0;
    var digits = 0;
    if (step == 0) {
      return 1;
    } else if (!cache.containsKey((value, step))) {
      if (value == 0) {
        result = answer(1, step - 1);
      } else if ((digits = getNumberDigitsBetter(value)).isEven) {
        var base = pow(10, digits / 2);

        result = 0;
        result += answer((value % base).toInt(), step - 1);
        result += answer(value ~/ base, step - 1);
      } else {
        result = answer(value * 2024, step - 1);
      }
      cache[(value, step)] = result;
    }

    return cache[(value, step)]!;
  }

  int getNumberDigitsBetter(num value) {
    return (log(value) / ln10).floor() + 1;
  }

  int getNumberDigitsForDummies(num value) {
    var count = 0;

    do {
      value ~/= 10;
      count++;
    } while (value > 0);

    return count;
  }

  @override
  Object loadContent(String content) {
    var values = content.split(' ');
    var stones = <int>[];

    for (var stone in values) {
      stones.add(int.parse(stone));
    }

    return stones;
  }
}
