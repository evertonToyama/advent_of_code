import 'dart:math';

import 'package:advent_of_code/day.dart';

class Day5Year2025 extends Day {
  @override
  int get day => 5;

  @override
  int get year => 2025;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var (
      freshIngredients,
      availableIngredients,
    ) = await readInput<(List<(int, int)>, List<int>)>(filename, input);
    var count = 0;

    for (var ingredient in availableIngredients) {
      for (var (begin, end) in freshIngredients) {
        if (ingredient >= begin && ingredient <= end) {
          count++;

          break;
        }
      }
    }

    return count;
  }

  // 337098394852955 - too low
  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var (freshIngredients, _) = await readInput<(List<(int, int)>, List<int>)>(
      filename,
      input,
    );
    var count = 0;
    var ingredients = <(int, int)>[];
    var lastRangeIndex = 0;

    freshIngredients.sort((a, b) => a.$1.compareTo(b.$1));
    ingredients.add(freshIngredients[lastRangeIndex]);
    for (var i = 1; i < freshIngredients.length; i++) {
      var (begin, end) = freshIngredients[i];

      if (begin <= ingredients[lastRangeIndex].$2 + 1) {
        ingredients[lastRangeIndex] = (
          ingredients[lastRangeIndex].$1,
          max(ingredients[lastRangeIndex].$2, end),
        );
      } else {
        ingredients.add((begin, end));
        lastRangeIndex++;
      }
    }

    for (var (begin, end) in ingredients) {
      count += end - begin + 1;
    }

    return count;
  }

  @override
  Object loadContent(String content) {
    var lists = content.split("\n\n");
    var freshIngredients = lists[0].split('\n');
    var availableIngredients =
        lists[1].split('\n').map((i) => int.parse(i)).toList();
    var freshIngredientsIntervals = <(int, int)>[];

    for (var ingredients in freshIngredients) {
      var interval = ingredients.split('-');
      freshIngredientsIntervals.add((
        int.parse(interval[0]),
        int.parse(interval[1]),
      ));
    }

    return (freshIngredientsIntervals, availableIngredients);
  }
}
