import 'package:advent_of_code/2024/day10/day10.dart';
import 'package:advent_of_code/utils/math.dart';
import 'package:test/test.dart';

void main() {
  test('Contents', () {
    var file = '''0123
1234
8765
9876''';
    var ref = Matrix.from([
      [0, 1, 2, 3],
      [1, 2, 3, 4],
      [8, 7, 6, 5],
      [9, 8, 7, 6],
    ]);
    final day = Day10Year2024();
    var map = day.loadContent(file);
    expect(map, equals(ref));
  });

  test('Part 1', () {
    // var map = Matrix.from([[0, 1, 2, 3], [1, 2, 3, 4], [8, 7, 6, 5], [9, 8, 7, 6]]);
    var map = Matrix.from([
      [8, 8, 8, 0, 8, 8, 8],
      [8, 8, 8, 1, 8, 8, 8],
      [8, 8, 8, 2, 8, 8, 8],
      [6, 5, 4, 3, 4, 5, 6],
      [7, 1, 1, 1, 1, 1, 7],
      [8, 1, 1, 1, 1, 1, 8],
      [9, 1, 1, 1, 1, 1, 9],
    ]);
    var result = Day10Year2024().calculateTrailheadScore(map);

    expect(result, equals(2));
  });
}
