import 'package:advent_of_code/2025/day2/day2.dart';
import 'package:test/test.dart';

void main() {
  final day = Day2Year2025();
  final input =
      '''11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124''';

  test('Input', () {
    List<(int, int)> result = day.loadContent(input) as List<(int, int)>;
    List<(int, int)> content = [
      (11, 22),
      (95, 115),
      (998, 1012),
      (1188511880, 1188511890),
      (222220, 222224),
      (1698522, 1698528),
      (446443, 446449),
      (38593856, 38593862),
      (565653, 565659),
      (824824821, 824824827),
      (2121212118, 2121212124),
    ];

    expect(result, content);
  });

  test('Part 1', () async {
    final result = await day.part1(input: input);
    expect(result, 1227775554);
  });

  test('Part 2', () async {
    final result = await day.part2(input: input);
    expect(result, 4174379265);
    // var value = 12345678;
    // var c = pow(10, 2);
    // var m = value % c;
    // var d = value ~/ c;

    // print("Div: $d | Mod: $m");
  });
}
