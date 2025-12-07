import 'package:advent_of_code/day.dart';
import 'package:advent_of_code/utils/math.dart';

class Day8Year2024 extends Day {
  @override
  int get day => 8;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var matrix = await readInput<Matrix<String>>(filename, input);
    var antinodes = <Vector2>{};
    var antennas = <String, List<Vector2>>{};

    for (var r = 0; r < matrix.rowsLength; r++) {
      for (var c = 0; c < matrix.colsLength; c++) {
        var item = matrix[(r, c)];

        if (item == '.') continue;

        if (!antennas.containsKey(item)) {
          antennas[item] = <Vector2>[];
        }

        antennas[item]!.add(Vector2(r, c));
      }
    }

    for (var pair in antennas.entries) {
      for (var i = 0; i < pair.value.length; i++) {
        for (var j = 0; j < pair.value.length; j++) {
          if (i == j) continue;
          var positions = pair.value;

          var difference = positions[j] - positions[i];
          var firstAntinode = positions[i] - difference;
          var secondAntinode = positions[j] + difference;

          if (matrix.isValidPos(firstAntinode)) {
            antinodes.add(firstAntinode);
          }

          if (matrix.isValidPos(secondAntinode)) {
            antinodes.add(secondAntinode);
          }
        }
      }
    }

    return antinodes.length;
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var matrix = await readInput<Matrix<String>>(filename, input);
    var antinodes = <Vector2>{};
    var antennas = <String, List<Vector2>>{};

    for (var r = 0; r < matrix.rowsLength; r++) {
      for (var c = 0; c < matrix.colsLength; c++) {
        var item = matrix[(r, c)];

        if (item == '.') continue;

        if (!antennas.containsKey(item)) {
          antennas[item] = <Vector2>[];
        }

        antennas[item]!.add(Vector2(r, c));
      }
    }

    for (var pair in antennas.entries) {
      for (var i = 0; i < pair.value.length; i++) {
        for (var j = 0; j < pair.value.length; j++) {
          if (i == j) continue;
          var positions = pair.value;
          antinodes.add(positions[i]);

          var count = 1;
          var difference = positions[j] - positions[i];
          var firstAntinode = positions[i] - (difference * count);
          var secondAntinode = positions[j] + (difference * count);

          while (matrix.isValidPos(firstAntinode)) {
            antinodes.add(firstAntinode);
            count++;
            firstAntinode = positions[i] - (difference * count);
          }

          count = 1;
          while (matrix.isValidPos(secondAntinode)) {
            antinodes.add(secondAntinode);
            count++;
            secondAntinode = positions[j] + (difference * count);
          }
        }
      }
    }

    return antinodes.length;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var matrix = Matrix<String>(columns: lines[0].length, defaultValue: '');

    for (var row = 0; row < lines.length; row++) {
      matrix.addRow(lines[row].split(''));
    }

    return matrix;
  }
}
