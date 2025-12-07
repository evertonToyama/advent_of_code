import 'package:advent_of_code/day.dart';
import 'package:advent_of_code/utils/math.dart';

class Day10Year2024 extends Day {
  @override
  int get day => 10;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var map = await readInput<Matrix<int>>(filename, input);

    // 238 - too low - matrix but (rows, columns)
    // 674 - right

    return calculateTrailheadScore(map);
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var map = await readInput<Matrix<int>>(filename, input);

    return calculateTrailheadRating(map);
  }

  int calculateTrailheadScore(Matrix<int> map) {
    var result = 0;

    for (var r = 0; r < map.rowsLength; r++) {
      for (var c = 0; c < map.colsLength; c++) {
        if (map[(r, c)] == 0) {
          result += findPeakPos(map, Vector2(r, c), 0).length;
        }
      }
    }

    return result;
  }

  int calculateTrailheadRating(Matrix<int> map) {
    var result = 0;

    for (var r = 0; r < map.rowsLength; r++) {
      for (var c = 0; c < map.colsLength; c++) {
        if (map[(r, c)] == 0) {
          result += findPeakPos2(map, Vector2(r, c), 0).length;
        }
      }
    }

    return result;
  }

  List<Vector2> findPeakPos2(
    Matrix<int> map,
    Vector2 currentPos,
    int currentHeight, [
    List<Vector2>? peakPositions,
  ]) {
    if (map.get(currentPos) == 9) return <Vector2>[currentPos];

    var directions = [
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(0, 1),
      Vector2(-1, 0),
    ];
    var vec = <Vector2>[];

    for (var direction in directions) {
      var nextPosition = currentPos + direction;
      var nextHeight = map.tryGet(nextPosition);
      if (nextHeight == null || nextHeight != currentHeight + 1) continue;

      var temp = findPeakPos2(map, nextPosition, nextHeight, peakPositions);
      // peakPositions ??= <Vector2>[];
      // peakPositions = [...?peakPositions, ...temp];
      vec += [...?peakPositions, ...temp];
    }

    return vec;
  }

  Set<Vector2> findPeakPos(
    Matrix<int> map,
    Vector2 currentPos,
    int currentHeight, [
    Set<Vector2>? peakPositions,
  ]) {
    if (map.get(currentPos) == 9) return <Vector2>{currentPos};

    var directions = [
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(0, 1),
      Vector2(-1, 0),
    ];

    for (var direction in directions) {
      var nextPosition = currentPos + direction;
      var nextHeight = map.tryGet(nextPosition);
      if (nextHeight == null || nextHeight != currentHeight + 1) continue;

      var temp = findPeakPos(map, nextPosition, nextHeight, peakPositions);
      peakPositions ??= <Vector2>{};
      peakPositions.addAll(temp);
    }

    return peakPositions ?? <Vector2>{};
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var columns = lines[0].length;
    var rows = lines.length;
    var map = Matrix<int>(columns: columns, rows: rows, defaultValue: 0);

    for (var r = 0; r < rows; r++) {
      var heights = lines[r].split('');
      for (var c = 0; c < columns; c++) {
        var h = int.parse(heights[c]);
        map[(r, c)] = h;
      }
    }

    return map;
  }
}
