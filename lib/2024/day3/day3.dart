import 'package:advent_of_code/day.dart';

/*
The computer appears to be trying to run a program, but its memory (your puzzle input) is corrupted. All of the instructions have been jumbled up!

It seems like the goal of the program is just to multiply some numbers. It does that with instructions like mul(X,Y), where X and Y are each 1-3 digit numbers. For instance, mul(44,46) multiplies 44 by 46 to get a result of 2024. Similarly, mul(123,4) would multiply 123 by 4.

However, because the program's memory has been corrupted, there are also many invalid characters that should be ignored, even if they look like part of a mul instruction. Sequences like mul(4*, mul(6,9!, ?(12,34), or mul ( 2 , 4 ) do nothing.

For example, consider the following section of corrupted memory:

xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
Only the four highlighted sections are real mul instructions. Adding up the result of each instruction produces 161 (2*4 + 5*5 + 11*8 + 8*5).

Scan the corrupted memory for uncorrupted mul instructions. What do you get if you add up all of the results of the multiplications?

Your puzzle answer was 179571322.

-----------------------------------------------------------------------------------------------

There are two new instructions you'll need to handle:

The do() instruction enables future mul instructions.
The don't() instruction disables future mul instructions.
Only the most recent do() or don't() instruction applies. At the beginning of the program, mul instructions are enabled.

For example:

xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
This corrupted memory is similar to the example from before, but this time the mul(5,5) and mul(11,8) instructions are disabled because there is a don't() instruction before them. The other mul instructions function normally, including the one at the end that gets re-enabled by a do() instruction.

This time, the sum of the results is 48 (2*4 + 8*5).

Handle the new instructions; what do you get if you add up all of the results of just the enabled multiplications?

Your puzzle answer was 103811193.
*/

class Day3Year2024 extends Day {
  @override
  int get day => 3;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var content = await readInput<String>(filename, input);

    return findMultiplication(content);
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var content = await readInput<String>(filename, input);

    return findDoDont(content);
  }

  int findMultiplication(String content) {
    var matches = RegExp('mul\\(\\d{1,3},\\d{1,3}\\)').allMatches(content);
    var count = 0;
    for (var match in matches) {
      var operation = match[0]!;
      var initial = 4;
      var firstNumber = operation.indexOf(',');
      var num1 = int.tryParse(operation.substring(initial, firstNumber));
      var num2 = int.tryParse(
        operation.substring(firstNumber + 1, operation.length - 1),
      );
      var total = num1! * num2!;
      count += total;
    }

    return count;
  }

  int findDoDont(String content) {
    var matches = RegExp(
      "mul\\(\\d{1,3},\\d{1,3}\\)|don't\\(\\)|do\\(\\)",
    ).allMatches(content);
    var count = 0;
    var enable = true;
    for (var match in matches) {
      var operation = match[0]!;
      if (operation.contains('mul')) {
        if (!enable) continue;

        var initial = 4;
        var firstNumber = operation.indexOf(',');
        var num1 = int.tryParse(operation.substring(initial, firstNumber));
        var num2 = int.tryParse(
          operation.substring(firstNumber + 1, operation.length - 1),
        );
        var total = num1! * num2!;
        count += total;
      } else if (operation.contains("don't")) {
        enable = false;
      } else if (operation.contains('do')) {
        enable = true;
      }
    }

    return count;
  }

  @override
  Object loadContent(String content) {
    return content;
  }
}
