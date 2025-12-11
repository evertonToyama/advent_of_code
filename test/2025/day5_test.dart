import 'package:advent_of_code/2025/day5/day5.dart';
import 'package:test/test.dart';

void main() {
  final day = Day5Year2025();
  final input = '''3-5
10-14
16-20
12-18

1
5
8
11
17
32''';
  final input2 = '''3-5
10-14
16-20
17-19

1
5
8
11
17
32''';
  test('Input', () async {
    var result = day.loadContent(input);
    print(result);
  });
  test('Part 1', () async {
    var result = await day.part1(input: input);
    expect(result, 3);
  });
  test('Part 2', () async {
    var result = await day.part2(input: input2);
    print(result);
    // expect(result, 14);
  });
  test('Part 2 - full input', () async {
    var result = await day.part2();
    print(result);
    // expect(result, 14);
  });
}
