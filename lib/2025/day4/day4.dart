import 'package:advent_of_code/day.dart';
import 'package:advent_of_code/utils/math.dart';

class Day4Year2025 extends Day {
  final directions = [
    Vector2(-1, 0), // Left
    Vector2(-1, 1), // Up-Left
    Vector2(0, 1), // Up
    Vector2(1, 1), // Up-Right
    Vector2(1, 0), // Right
    Vector2(1, -1), // Down-Right
    Vector2(0, -1), // Down
    Vector2(-1, -1), // Down-Left
  ];
  @override
  int get day => 4;

  @override
  int get year => 2025;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var map = await readInput<Matrix<int>>(filename, input);
    var count = scanMap(map);

    return count;
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var map = await readInput<Matrix<int>>(filename, input);
    var count = 0;
    var subtotal = 0;

    do {
      subtotal = scanMap(map, removeAvailabePaperRolls: true);
      count += subtotal;
    } while (subtotal != 0);

    return count;
  }

  int scanMap(Matrix<int> map, {bool removeAvailabePaperRolls = false}) {
    var count = 0;

    for (var i = 0; i < map.colsLength; i++) {
      for (var j = 0; j < map.rowsLength; j++) {
        var hasPaper = map[(i, j)] == 1;
        if (!hasPaper) {
          continue;
        }

        var adjacentCount = 0;
        for (var direction in directions) {
          var x = i + direction.x;
          var y = j + direction.y;
          var isOutOfBoundsHorizontally = x < 0 || x >= map.colsLength;
          var isOutOfBoundsVertically = y < 0 || y >= map.rowsLength;

          if (isOutOfBoundsHorizontally || isOutOfBoundsVertically) {
            continue;
          }

          var hasAdjacentPaper = map[(x, y)] == 1;
          if (hasAdjacentPaper) {
            adjacentCount++;
          }
        }

        if (adjacentCount < 4) {
          if (removeAvailabePaperRolls) {
            map[(i, j)] = 0;
          }

          count++;
        }
      }
    }

    return count;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var map = Matrix(
      columns: lines[0].length,
      rows: lines.length,
      defaultValue: 0,
    );

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      for (var j = 0; j < line.length; j++) {
        var c = line[j];
        if (c == '@') {
          map[(i, j)] = 1;
        }
      }
    }

    return map;
  }
}
