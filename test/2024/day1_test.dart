import 'package:advent_of_code/utils/file.dart';
import 'package:test/test.dart';

void main() {
  final day = "day1";
  final year = "2024";
  test('Test relative filepath', () {
    var file = FileUtils.loadFile("./lib/$year/$day/input.txt");
    expect(file.existsSync(), true);
  });
}
