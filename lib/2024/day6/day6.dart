import 'package:advent_of_code/day.dart';

class Day6 extends Day {
  Day6(super.day, super.year);

  @override
  Future<Object> part1({String filename = "input.txt"}) async {
    var (pos, matrix) = await readInput<(int, List<String>)>(filename);
    var length = matrix[0].length + 1;
    var y = pos ~/ length;
    var x = pos % length;

    return countGuardMovements(matrix, x, y);
  }

  @override
  Future<Object> part2({String filename = "input.txt"}) async {
    var (pos, matrix) = await readInput<(int, List<String>)>(filename);
    var length = matrix[0].length + 1;
    var y = pos ~/ length;
    var x = pos % length;

    return countGuardLoop(matrix, x, y);
  }

  int countGuardLoop(List<String> room, int posX, int posY) {
    var count = 0;
    var counter = 1;
    final rowsLength = room.length;
    final columnsLength = room[0].length;

    for (var i = 0; i < rowsLength; i++) {
      print('$counter ($count)');
      for (var j = 0; j < columnsLength; j++) {
        // print('$counter ($count)');
        counter++;

        if (room[i][j] != '.') continue;

        var line = room[i];
        room[i] = line.replaceRange(j, j + 1, '#');

        if (isInfiniteLoop(room, posX, posY)) {
          count++;
        }

        room[i] = line.replaceRange(j, j + 1, '.');
      }
    }

    return count;
  }

  bool isInfiniteLoop(List<String> room, int posX, int posY) {
    var seen = <({int x, int y, int dirX, int dirY})>{};
    var length = room.length;
    var dirX = 0;
    var dirY = -1;

    while (true) {
      if (contains(seen, posX, posY, dirX, dirY)) {
        break;
      }
      seen.add((x: posX, y: posY, dirX: dirX, dirY: dirY));

      var nextPos = moveForward(dirX, dirY, posX, posY);
      if (isOutOfRoom(nextPos.x, nextPos.y, length)) {
        return false;
      }

      final isAvailable = room[nextPos.y][nextPos.x] != '#';

      if (!isAvailable) {
        var newDir = turnRight(dirX, dirY);
        dirX = newDir.x;
        dirY = newDir.y;
      } else {
        posX = nextPos.x;
        posY = nextPos.y;
      }
    }

    return true;
  }

  bool contains(
    Set<({int x, int y, int dirX, int dirY})> seen,
    int posX,
    int posY,
    int dirX,
    int dirY,
  ) {
    for (var pos in seen) {
      if (pos.x == posX &&
          pos.y == posY &&
          pos.dirX == dirX &&
          pos.dirY == dirY) {
        return true;
      }
    }
    return false;
  }

  int countGuardMovements(List<String> room, int posX, int posY) {
    var seen = <(int, int)>{};
    var length = room.length;
    var dirX = 0;
    var dirY = -1;

    while (true) {
      seen.add((posX, posY));

      var nextPos = moveForward(dirX, dirY, posX, posY);
      if (isOutOfRoom(nextPos.x, nextPos.y, length)) break;

      final isAvailable = room[nextPos.y][nextPos.x] == '.';

      if (!isAvailable) {
        var newDir = turnRight(dirX, dirY);
        dirX = newDir.x;
        dirY = newDir.y;
      } else {
        posX = nextPos.x;
        posY = nextPos.y;
      }
    }

    return seen.length;
  }

  bool isOutOfRoom(int x, int y, int length) =>
      x < 0 || x >= length || y < 0 || y >= length;

  ({int x, int y}) moveForward(int dirX, int dirY, int posX, int posY) {
    return (x: dirX + posX, y: dirY + posY);
  }

  ({int x, int y}) turnRight(int x, int y) {
    final temp = x;
    x = -y;
    y = temp;
    return (x: x, y: y);
  }

  @override
  Object loadContent(String content) {
    var lines = content.split('\n');
    var pos = content.indexOf('^');
    return (pos, lines);
  }
}
