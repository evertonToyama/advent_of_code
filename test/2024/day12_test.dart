import 'package:advent_of_code/2024/day12/day12.dart';
import 'package:advent_of_code/utils/math.dart';
import 'package:test/test.dart';

void main() {
  test('Part 1', () {
    var file = '''RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE''';

    // var map = loadContent(file);
    var map = file;

    var areas = Day12Year2024().calculateAreaPerimeter(map as Matrix<String>);
    var result = 0;
    for (var (area, perimeter) in areas) {
      result += area * perimeter;
    }

    expect(result, 1930);
  });

  test('Part 2', () {
    var file = '''RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE''';

    // var map = loadContent(file);
    var map = file;
    var zones = Day12Year2024().mapZones(map as Matrix<String>);
  });
}
