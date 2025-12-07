import 'package:advent_of_code/day.dart';

class Day2Year2025 extends Day {
  @override
  int get day => 2;

  @override
  int get year => 2025;

  int bruteForcePart1() {
    return 0;
  }

  int modPart1() {
    return 0;
  }

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    final ids = await readInput<List<(int, int)>>(filename, input);
    List<int> invalidIds = [];
    var sum = 0;

    for (var (start, end) in ids) {
      for (var id = start; id <= end; id++) {
        var sId = id.toString();
        if (sId.length % 2 != 0) continue;

        var mid = sId.length ~/ 2;
        var firstHalf = sId.substring(0, mid);
        var secondHalf = sId.substring(mid);

        if (firstHalf == secondHalf) {
          invalidIds.add(id);
        }
      }
    }

    for (var id in invalidIds) {
      sum += id;
    }

    return sum;
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    final ids = await readInput<List<(int, int)>>(filename, input);
    List<int> invalidIds = [];
    var sum = 0;

    // Iterate through the ids
    for (var (start, end) in ids) {
      // print("start: $start | end: $end");
      // Iterate through each interval
      for (var id = start; id <= end; id++) {
        // print(id);
        var sId = id.toString();
        var chunk = 1;
        var mid = sId.length ~/ 2;

        // Get am initial chunk of 1 and test if it repeats the sequence, after increment the chunk and do again
        while (chunk <= mid) {
          var compare = sId.substring(0, chunk);
          // if (id == 1001) {
          //   print(chunk);
          // }
          if (sId.length % chunk != 0) {
            chunk++;
            continue;
          }

          var valid = false;
          for (var i = chunk; i <= sId.length - chunk; i += chunk) {
            var v = sId.substring(i, i + chunk);
            if (compare.compareTo(v) != 0) {
              valid = true;
              break;
            }
          }
          if (!valid && !invalidIds.contains(id)) invalidIds.add(id);

          chunk++;
        }
      }
    }

    for (var id in invalidIds) {
      print(id);
      sum += id;
    }

    return sum;
  }

  @override
  Object loadContent(String content) {
    var list = content.split(',');
    List<(int, int)> ids = [];

    for (var item in list) {
      var range = item.split('-');
      var start = int.parse(range[0]);
      var end = int.parse(range[1]);
      ids.add((start, end));
    }

    return ids;
  }
}
