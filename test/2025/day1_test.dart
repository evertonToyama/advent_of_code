import 'package:advent_of_code/2025/day1/day1.dart';
import 'package:test/test.dart';

void main() {
  final day = Day1Year2025();
  final input = '''L68
L30
R48
L5
R60
L55
L1
L99
R14
L82''';
  final input2 = '''L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
L200''';

  test('Input', () {
    List<int> result = day.loadContent(input) as List<int>;
    List<int> content = [-68, -30, 48, -5, 60, -55, -1, -99, 14, -82];

    expect(result, content);
  });

  test('Part 1', () async {
    final result = await day.part1(input: input);
    expect(result, 3);
  });
  test('Part 2', () async {
    final result = await day.part2(input: input);
    expect(result, 6);
  });
}
