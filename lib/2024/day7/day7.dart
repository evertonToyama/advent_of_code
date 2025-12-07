import 'package:advent_of_code/day.dart';

class Day7Year2024 extends Day {
  @override
  int get day => 7;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var operations = await readInput<List<(int, List<int>)>>(filename, input);
    var total = 0;

    for (var (result, values) in operations) {
      if (isValid(result, values.reversed.toList())) {
        total += result;
      }
    }

    return total;
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var operations = await readInput<List<(int, List<int>)>>(filename, input);
    var total = 0;

    for (var (result, values) in operations) {
      if (isValidConcat(result, values.reversed.toList())) {
        total += result;
      }
    }

    return total;
  }

  bool isValid(int result, List<int> values) {
    if (values.length == 1) {
      return values[0] == result;
    }

    var first = values[0];
    var rest = values.sublist(1);

    if (result % first == 0 && isValid(result ~/ first, rest)) {
      return true;
    }

    if (result >= first && isValid(result - first, rest)) {
      return true;
    }

    return false;
  }

  bool isValidConcat(int result, List<int> values) {
    if (values.length == 1) {
      return values[0] == result;
    }

    var first = values[0];
    var rest = values.sublist(1);

    if (result % first == 0 && isValidConcat(result ~/ first, rest)) {
      return true;
    }

    if (result >= first && isValidConcat(result - first, rest)) {
      return true;
    }

    var sResult = result.toString();
    var sFirst = first.toString();
    try {
      var s =
          sResult.length > sFirst.length
              ? sResult.substring(0, sResult.length - sFirst.length)
              : '0';
      if (sResult.endsWith(sFirst) && isValidConcat(int.parse(s), rest)) {
        return true;
      }
    } catch (e) {
      print('$sResult $sFirst $values');
    }

    return false;
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var operations = <(int result, List<int> values)>[];

    for (var line in lines) {
      if (line.isEmpty) continue;

      var operation = line.split(':');
      var result = int.parse(operation[0]);
      var values = operation[1].split(' ').sublist(1).map(int.parse).toList();
      operations.add((result, values));
    }

    return operations;
  }
}
