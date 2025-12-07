import 'package:advent_of_code/day.dart';

class Day1Year2024 extends Day {
  @override
  int get day => 1;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    final (left, right) = await readInput<(List<int>, List<int>)>(
      filename,
      input,
    );

    sort(left);
    sort(right);

    return calculateTotalDistance(left, right);
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var (left, right) = await readInput<(List<int>, List<int>)>(
      filename,
      input,
    );

    sort(left);
    sort(right);

    return calculateTotalSimilarityScore(left, right);
  }

  int calculateTotalSimilarityScore(List<int> left, List<int> right) {
    var totalSimilarity = 0;
    var numbersMap = <int, int>{};

    for (var num in right) {
      var count = numbersMap[num];
      if (count != null) {
        count++;
        numbersMap[num] = count;
      } else {
        numbersMap[num] = 1;
      }
    }

    for (var num in left) {
      var count = numbersMap[num];
      if (count == null) {
        continue;
      }

      totalSimilarity += count * num;
    }

    return totalSimilarity; // 21328497
  }

  int calculateTotalDistance(List<int> left, List<int> right) {
    var totalDistance = 0;
    for (var i = 0; i < left.length; i++) {
      totalDistance += (left[i] - right[i]).abs();
    }

    return totalDistance; // 2742123
  }

  List<int> sort(List<int> numbers) {
    for (var i = 0; i < numbers.length - 1; i++) {
      var isSorted = true;

      for (var j = 0; j < numbers.length - 1 - i; j++) {
        if (numbers[j] > numbers[j + 1]) {
          isSorted = false;
          var temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
        }
      }

      if (isSorted) break;
    }

    return numbers;
  }

  @override
  Object loadContent(String content) {
    var arr = content.split('\n');
    var left = <int>[];
    var right = <int>[];

    for (var i = 0; i < arr.length; i++) {
      var nums = arr[i].split('   ');
      var leftNum = int.tryParse(nums[0]);
      var rightNum = int.tryParse(nums[1]);

      left.add(leftNum!);
      right.add(rightNum!);
    }
    return (left, right);
  }
}
