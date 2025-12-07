import 'package:advent_of_code/day.dart';

class Day9Year2024 extends Day {
  @override
  int get day => 9;

  @override
  int get year => 2024;

  @override
  Future<Object> part1({String filename = "input.txt", String? input}) async {
    var (disk, _) = await readInput<(List<int?>, List<int>)>(filename, input);
    var index = 0;

    for (var i = disk.length - 1; i > 0; i--) {
      if (disk[i] == null) continue;

      index = findEmptySlot(index, disk);

      if (i <= index || index == -1) break;

      disk[index] = disk[i];
      disk[i] = null;
    }

    return calculateChecksum(disk);
  }

  @override
  Future<Object> part2({String filename = "input.txt", String? input}) async {
    var (disk, filesizes) = await readInput<(List<int?>, List<int>)>(
      filename,
      input,
    );
    var index = 0;
    var lastNum = 99999;
    var currentFilesizeIndex = filesizes.length;
    var seen = <int>{};
    var count = 0;

    for (var i = disk.length - 1; i > 0; i--) {
      if (currentFilesizeIndex < filesizes.length &&
          count == filesizes[currentFilesizeIndex]) {
        seen.add(lastNum);
        count = 0;
      }

      if (disk[i] == null || seen.contains(disk[i])) continue;
      count++;

      if (lastNum != disk[i]) {
        currentFilesizeIndex--;
        lastNum = disk[i]!;
        var nextSlot = findEmptySlot(0, disk, filesizes[currentFilesizeIndex]);
        if (nextSlot == -1 || nextSlot > i) {
          i -= (filesizes[currentFilesizeIndex] - 1);
          count = filesizes[currentFilesizeIndex];
          continue;
        }
        index = nextSlot;
      } else {
        index++;
      }

      disk[index] = disk[i];
      disk[i] = null;
    }

    return calculateChecksum(disk);
  }

  int findEmptySlot(int startingIndex, List<int?> disk, [int filesize = 1]) {
    var currentSize = 1;
    for (var index = startingIndex; index < disk.length; index++) {
      if (disk[index] == null) {
        if (currentSize == filesize) {
          return index - (filesize - 1);
        }

        currentSize++;
      } else {
        currentSize = 1;
      }
    }

    return -1;
  }

  int calculateChecksum(List<int?> disk) {
    var total = 0;
    for (var i = 0; i < disk.length; i++) {
      var f = disk[i];
      if (f == null) continue;

      total += f * i;
    }

    return total;
  }

  @override
  Object loadContent(String content) {
    var disk = <int?>[];
    var filesizes = <int>[];
    var fileIds = 0;

    for (var num = 0; num < content.length; num++) {
      var max = int.parse(content[num]);
      var isEven = num % 2 == 0;

      // if (max == 0 && isEven)

      if (isEven && max != 0) filesizes.add(max);

      for (var i = 0; i < max; i++) {
        if (isEven) {
          disk.add(fileIds);
        } else {
          disk.add(null);
        }
      }

      if (isEven) {
        fileIds++;
      }
    }

    // var test = '';
    // int? last = 0;
    // var count = 0;
    // for (var i = 0; i < disk.length; i++) {
    //   if (last == disk[i]) {
    //     count++;
    //   } else {
    //     last = disk[i];
    //     test += count.toString();
    //     count = 1;
    //   }
    // }
    // test += count.toString();

    // print(test);
    // print(file.replaceAll('0', ''));
    // print(test == file.replaceAll('0', ''));

    return (disk, filesizes);
  }
}
