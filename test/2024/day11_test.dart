import 'package:advent_of_code/2024/day11/day11.dart';
import 'package:test/test.dart';

void main() {
  test('Contents', () {
    var file = '''0123
1234
8765
9876''';
  });

  test('Part 1', () {
    var stones = <int>[0, 1, 10, 99, 999];

    print(stones);
    stones = Day11Year2024().blink(stones);
    print(stones);

    expect(stones, [1, 2024, 1, 0, 9, 9, 2021976]);
  });
}
