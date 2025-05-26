import 'package:advent_of_code/day.dart';
import 'package:advent_of_code/utils/math.dart';

class Day12 extends Day {
  Day12(super.day, super.year);

  Map<Vector2, List<Vector2>> _zones = {};
  Matrix<String> _map = Matrix<String>.empty();

  @override
  Future<Object> part1({String filename = "input.txt"}) async {
    final areas = await readInput<Matrix<String>>(filename);
    final values = calculateAreaPerimeter(areas);

    var result = 0;
    for (var (area, perimeter) in values) {
      result += area * perimeter;
    }

    return result;
  }

  @override
  Future<Object> part2({String filename = "input.txt"}) async {
    _map = await readInput<Matrix<String>>(filename);
    _zones = mapZones(_map);

    print(_zones[Vector2.zero()]);

    return Future.value(0);
  }

  int _countCorners(Vector2 currentPos) {
    var children = _zones[currentPos]!;

    if (children.isEmpty) return 4;
    if (children.length == 1) return 2;

    var firstChild = children[0] - currentPos;
    var secondChild = children[1] - currentPos;
    var isDiagonal = (firstChild + secondChild).abs() == Vector2.one();
    if (children.length == 2 && isDiagonal) {
      if (_map.get(firstChild + secondChild) == _map.get(currentPos)) {
        return 2;
      }

      return 1;
    }

    if (children.length == 3) {
      var result = children[0] + children[1] + children[2];
      var diagonal = getDiagonalPositions(result);
      var points = 0;
      for (var pos in diagonal) {
        if (_map.get(pos) == _map.get(currentPos)) {
          points++;
        }
      }

      return points;
    }

    if (children.length == 4) {
      var diagonal = [
        Vector2(1, 1),
        Vector2(-1, -1),
        Vector2(1, -1),
        Vector2(-1, 1),
      ];
      var points = 0;
      for (var pos in diagonal) {
        if (_map.get(pos) == _map.get(currentPos)) {
          points++;
        }
      }

      return points;
    }

    return 0;
  }

  List<Vector2> getDiagonalPositions(Vector2 child) {
    var diagonal = <Vector2>[];
    var multiplier = 1;

    for (var i = 0; i < 2; i++) {
      var x = child.x == 0 ? multiplier : child.x;
      var y = child.y == 0 ? multiplier : child.y;
      multiplier *= -1;

      diagonal.add(Vector2(x, y));
    }

    return diagonal;
  }

  Map<Vector2, List<Vector2>> mapZones(Matrix<String> map) {
    var zones = <Vector2, List<Vector2>>{};

    for (var r = 0; r < map.rowsLength; r++) {
      for (var c = 0; c < map.colsLength; c++) {
        var pos = Vector2(r, c);
        zones[pos] = [];
        var directions = [
          Vector2(1, 0),
          Vector2(0, -1),
          Vector2(-1, 0),
          Vector2(0, 1),
        ];
        for (var direction in directions) {
          var newPos = pos + direction;
          if (!map.isValidPos(newPos)) {
            continue;
          }

          if (map.get(pos) != map.get(newPos)) {
            continue;
          }

          zones[pos]?.add(newPos);
        }
      }
    }

    return zones;
  }

  List<(int area, int perimeter)> calculateAreaPerimeter(Matrix<String> map) {
    var areas = <(int, int)>[];
    var seen = <Vector2>[];

    var zones = mapZones(map);

    for (var zone in zones.entries) {
      var currentPos = zone.key;
      if (seen.contains(currentPos)) continue;

      var (area, perimeter) = calculateArea(zones, currentPos, seen);
      areas.add((area, perimeter));
    }

    return areas;
  }

  (int, int) calculateArea(
    Map<Vector2, List<Vector2>> map,
    Vector2 currentPos,
    List<Vector2> seen,
  ) {
    var area = 1;
    var perimeter = 4 - map[currentPos]!.length;
    seen.add(currentPos);

    for (var pos in map[currentPos]!) {
      if (seen.contains(pos)) continue;

      var (a, p) = calculateArea(map, pos, seen);
      area += a;
      perimeter += p;
    }

    return (area, perimeter);
  }

  @override
  loadContent(String content) {
    var lines = content.split('\n');
    var matrix = lines.map((line) => line.split('')).toList();
    var map = Matrix<String>.from(matrix);

    return map;
  }
}
