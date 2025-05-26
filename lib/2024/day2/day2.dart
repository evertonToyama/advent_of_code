import 'package:advent_of_code/day.dart';

/*
Each report is a list of numbers called levels that are separated by spaces. For example:

7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
This example data contains six reports each containing five levels.

The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

The levels are either all increasing or all decreasing.
Any two adjacent levels differ by at least one and at most three.
In the example above, the reports can be found safe or unsafe by checking those rules:

7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.
So, in this example, 2 reports are safe.

Analyze the unusual data from the engineers. How many reports are safe?

Your puzzle answer was 390.

------------------------------------------------------------------------------------------------

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

7 6 4 2 1: Safe without removing any level.
1 2 7 8 9: Unsafe regardless of which level is removed.
9 7 6 2 1: Unsafe regardless of which level is removed.
1 3 2 4 5: Safe by removing the second level, 3.
8 6 4 4 1: Safe by removing the third level, 4.
1 3 6 7 9: Safe without removing any level.
Thanks to the Problem Dampener, 4 reports are actually safe!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?

Your puzzle answer was 439.
*/

class Day2 extends Day {
  Day2(super.day, super.year);

  @override
  Future<Object> part1({String filename = "input.txt"}) async {
    var reports = await readInput<List<List<int>>>(filename);

    int count = 0;
    for (var report in reports) {
      if (isSafe(report)) {
        count++;
        continue;
      }
    }

    return count;
  }

  @override
  Future<Object> part2({String filename = "input.txt"}) async {
    var reports = await readInput(filename);

    int count = 0;
    for (var report in reports) {
      if (isSafe(report)) {
        count++;
        continue;
      }

      for (var i = 0; i < report.length; i++) {
        var l = List<int>.from(report);
        l.removeAt(i);
        if (isSafe(l)) {
          count++;
          break;
        }
      }
    }

    return count;
  }

  bool isSafe(List<int> levels) {
    var direction = 0;

    for (var i = 1; i < levels.length; i++) {
      var difference = levels[i] - levels[i - 1];
      var absolute = difference.abs();
      if (absolute < 1 || absolute > 3) {
        return false;
      }

      if (direction != 0 && difference / absolute != direction) {
        return false;
      }

      direction = (difference / absolute).floor();
    }

    return true;
  }

  @override
  loadContent(String content) {
    var reportsString = content.split('\n');
    var reports = <List<int>>[];
    for (var report in reportsString) {
      var levelsString = report.split(' ');
      var levels = <int>[];
      for (var level in levelsString) {
        levels.add(int.tryParse(level)!);
      }
      reports.add(levels);
    }
    return reports;
  }
}
