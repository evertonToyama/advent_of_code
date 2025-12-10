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

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var (freshIngredients, _) = await readInput<(List<(int, int)>, List<int>)>(
      filename,
      input,
    );
    var freshIngredientsIntervals = <(int begin, int end)>[];
    var count = 0;

    for (var (begin, end) in freshIngredients) {
      var exists = false;
      for (var i = 0; i < freshIngredientsIntervals.length; i++) {
        var freshBegin = freshIngredientsIntervals[i].$1;
        var freshEnd = freshIngredientsIntervals[i].$2;
        if (freshBegin > end || freshEnd < begin) {
          continue;
        }

        if (freshBegin < end) {
          freshBegin = begin;
          exists = true;
        }
        if (freshEnd > begin) {
          freshEnd = end;
          exists = true;
        }

        if (exists) {
          freshIngredientsIntervals[i] = (freshBegin, freshEnd);
          break;
        }
      }

      if (!exists) {
        freshIngredientsIntervals.add((begin, end));
      }
    }

    print(freshIngredientsIntervals);

    return count;
  }

  bool intervalContainElement(List<(int, int)> intervals, int element) {
    for (var (begin, end) in intervals) {
      if (element >= begin && element <= end) {
        return true;
      }
    }

    return false;
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
