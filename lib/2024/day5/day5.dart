import 'package:advent_of_code/day.dart';

class Day5Year2024 extends Day {
  @override
  int get day => 5;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var pages =
        await readInput<({Map<int, List<int>> rules, List<List<int>> updates})>(
          filename,
          input,
        );
    return sumValidMedian(pages.rules, pages.updates);
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var pages =
        await readInput<({Map<int, List<int>> rules, List<List<int>> updates})>(
          filename,
          input,
        );

    return sumSortedMedian(pages.rules, pages.updates);
  }

  int sumSortedMedian(Map<int, List<int>> rules, List<List<int>> updates) {
    var total = 0;
    var isValid = true;

    for (var update in updates) {
      isValid = true;
      for (var i = 0; i < update.length - 1; i++) {
        for (var j = 0; j < update.length - 1; j++) {
          var current = update[j];
          var next = update[j + 1];

          if (!rules.containsKey(next)) continue;

          if (rules[next]!.contains(current)) {
            isValid = false;
            var temp = update[j];
            update[j] = update[j + 1];
            update[j + 1] = temp;
          }
        }
      }

      if (!isValid) {
        var median = update[(update.length / 2).floor()];
        total += median;
      }
    }

    return total;
  }

  int sumValidMedian(Map<int, List<int>> rules, List<List<int>> updates) {
    var total = 0;
    var isValid = true;

    for (var update in updates) {
      isValid = true;
      for (var i = 0; i < update.length - 1; i++) {
        for (var j = i + 1; j < update.length; j++) {
          var current = update[i];
          var next = update[j];

          if (!rules.containsKey(next)) continue;

          if (rules[next]!.contains(current)) {
            isValid = false;
            break;
          }
        }

        if (!isValid) break;
      }

      if (isValid) {
        var median = update[(update.length / 2).floor()];
        total += median;
      }
    }

    return total;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var isRule = true;
    var rules = <int, List<int>>{};
    var updates = <List<int>>[];
    var index = 0;

    for (var line in lines) {
      if (line.isEmpty) {
        isRule = false;
        continue;
      }

      if (isRule) {
        var pages = line.split('|');
        var key = int.parse(pages[0]);
        var value = int.parse(pages[1]);

        if (rules[key] == null) rules[key] = <int>[];

        rules[key]!.add(value);
      } else {
        var pages = line.split(',');
        updates.add(<int>[]);
        for (var page in pages) {
          var num = int.parse(page);
          updates[index].add(num);
        }

        index++;
      }
    }

    return (rules: rules, updates: updates);
  }
}
