import 'package:advent_of_code/2025/day3/day3.dart';
import 'package:test/test.dart';

void main() {
  final day = Day3Year2025();
  final input = '''987654321111111
811111111111119
234234234234278
818181911112111''';

  test('input', () async {
    var batteries = day.loadContent(input) as List<List<int>>;
    print(batteries);
  });

  test('Part 1', () async {
    var result = await day.part1(input: input);
    expect(result, 357);
  });
  test('Part 2', () async {
    var result = await day.part2(input: input);
    expect(result, 3121910778619);
  });
}
