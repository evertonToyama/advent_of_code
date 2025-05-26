import 'dart:io';
import 'dart:typed_data';

import 'package:advent_of_code/2024/day1/day1.dart';
import 'package:advent_of_code/2024/day10/day10.dart';
import 'package:advent_of_code/2024/day11/day11.dart';
import 'package:advent_of_code/2024/day12/day12.dart';
import 'package:advent_of_code/2024/day2/day2.dart';
import 'package:advent_of_code/2024/day3/day3.dart';
import 'package:advent_of_code/2024/day4/day4.dart';
import 'package:advent_of_code/2024/day5/day5.dart';
import 'package:advent_of_code/2024/day6/day6.dart';
import 'package:advent_of_code/2024/day7/day7.dart';
import 'package:advent_of_code/2024/day8/day8.dart';
import 'package:advent_of_code/2024/day9/day9.dart';
import 'package:advent_of_code/utils/file.dart';
import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:process_run/shell_run.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addCommand('fetch')
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('part', abbr: 'p', negatable: false, help: 'Part')
    ..addFlag('day', abbr: 'd', negatable: false, help: 'Challenge day')
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart advent_of_code.dart <flags> [arguments]');
  print(argParser.usage);
}

final challenges = {
  2024: [
    Day1(1, 2024),
    Day2(2, 2024),
    Day3(3, 2024),
    Day4(4, 2024),
    Day5(5, 2024),
    Day6(6, 2024),
    Day7(7, 2024),
    Day8(8, 2024),
    Day9(9, 2024),
    Day10(10, 2024),
    Day11(11, 2024),
    Day12(12, 2024),
  ],
};

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;
    int day = 1;
    int year = 2024;
    int indexPosition = 0;
    int part = 1;
    Object result;

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('advent_of_code version: $version');
      return;
    }
    if (results.flag('day')) {
      day = int.parse(results.rest[0]);
      indexPosition = day - 1;
    }
    if (results.flag('part')) {
      part = int.parse(results.rest[1]);
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    if (results.command?.name == "fetch") {
      day = int.parse(results.arguments[1]);
      result = await fetchInput(day);
      if (result == 200) {
        print("Input fetched");
      }
      return;
    }

    print('-------------------------------------------------');
    print('Starting Day $day - Part $part');
    var stopwatch = Stopwatch()..start();

    if (part == 1) {
      result = await challenges[year]![indexPosition].part1();
    } else {
      result = await challenges[year]![indexPosition].part2();
    }

    stopwatch.stop();

    copyToClipboard(result.toString());
    print("\nFinal Result:");
    print(result);
    print("\nTime Elapsed: ${stopwatch.elapsed}");

    if (verbose) {
      // Act on the arguments provided.
      print('Positional arguments: ${results.rest}');
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

Future<int> fetchInput(int day) async {
  var uri = Uri.https('adventofcode.com', '/2024/day/$day/input');
  var req = http.Request('get', uri);
  req.headers.addAll({
    "Cookie":
        "session=53616c7465645f5f23c694c99c30d0e85d3fb1432b6ce3ded6849ad0999a9a66b5ef8393413cc7f2d20039b8a9b550c423538d755c94ff873f6f824cc9f31a24",
  });
  var response = await req.send();

  if (response.statusCode != 200) {
    print('Error on fetch: ${response.statusCode}');
    return response.statusCode;
  }

  var contents = await response.stream.toBytes();
  contents = trimContent(contents);
  FileUtils.writeToFile('./lib/2024/day$day/input.txt', contents);

  return response.statusCode;
}

Uint8List trimContent(Uint8List content) {
  if (content.last != 10) {
    return content;
  }

  return content.sublist(0, content.length - 1);
}

Future<void> copyToClipboard(Object text) async {
  final shell = Shell();

  if (Platform.isWindows) {
    await shell.run('echo "$text" | clip');
  } else if (Platform.isLinux) {
    await run('copyq copy $text', verbose: false);
  } else if (Platform.isMacOS) {
    await shell.run('echo "$text" | pbcopy');
  } else {
    throw UnsupportedError('Clipboard not supported on this platform');
  }

  print("Copied to clipboard");
}
