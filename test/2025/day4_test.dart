import 'package:advent_of_code/2025/day4/day4.dart';
import 'package:test/test.dart';

void main() {
  final day = Day4Year2025();
  final input = '''..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.''';

  test('part 1', () async {
    var result = await day.part1(input: input);
    expect(result, 13);
  });
  test('part 2', () async {
    var result = await day.part2(input: input);
    expect(result, 43);
  });
}
