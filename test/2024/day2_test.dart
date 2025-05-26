import 'dart:io';

import 'package:advent_of_code/utils/file.dart';
import 'package:test/test.dart';

void main() {
  final year = "2024";
  test('Test relative filepath', () {
    var file = FileUtils.loadFile("./lib/$year/day2/input.txt");
    print(Platform.script.pathSegments[2].split('.'));
    expect(file.existsSync(), true);
  });
}
