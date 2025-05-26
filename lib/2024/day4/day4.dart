import 'package:advent_of_code/day.dart';

class Day4 extends Day {
  Day4(super.day, super.year);

  @override
  Future<Object> part1({String filename = "input.txt"}) async {
    var matrix = await readInput<List<String>>(filename);

    return findXMAS(matrix);
  }

  @override
  Future<Object> part2({String filename = "input.txt"}) async {
    var matrix = await readInput<List<String>>(filename);

    return findMAS(matrix);
  }

  int findMAS(List<String> matrix) {
    var total = 0;

    for (var i = 1; i < matrix.length - 1; i++) {
      for (var j = 1; j < matrix[i].length - 1; j++) {
        if (matrix[i][j] != 'A') continue;

        final main = matrix[i - 1][j - 1] + matrix[i + 1][j + 1];
        final cross = matrix[i - 1][j + 1] + matrix[i + 1][j - 1];

        if ((main == 'MS' || main == 'SM') &&
            (cross == 'MS' || cross == 'SM')) {
          total++;
        }
      }
    }

    return total;
  }

  int findXMAS(List<String> matrix) {
    final windrose = [
      (0, 1),
      (-1, 1),
      (-1, 0),
      (-1, -1),
      (0, -1),
      (1, -1),
      (1, 0),
      (1, 1),
    ];
    final word = "XMAS";
    var total = 0;
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] != 'X') continue;

        var removedItems = [];

        for (var z = 1; z < word.length; z++) {
          for (var w = 0; w < windrose.length; w++) {
            if (removedItems.contains(w)) continue;

            var direction = windrose[w];
            var y = i + direction.$1 * z;
            var x = j + direction.$2 * z;
            if (x < 0 || x >= matrix[i].length || y < 0 || y >= matrix.length) {
              removedItems.add(w);
              continue;
            }
            if (matrix[y][x] != word[z]) {
              removedItems.add(w);
            }
          }
        }
        total += windrose.length - removedItems.length;
      }
    }

    return total;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    return lines;
  }
}
