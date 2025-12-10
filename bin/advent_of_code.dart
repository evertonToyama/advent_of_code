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
import 'package:advent_of_code/2025/day1/day1.dart';
import 'package:advent_of_code/2025/day2/day2.dart';
import 'package:advent_of_code/2025/day3/day3.dart';
import 'package:advent_of_code/utils/file.dart';
import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:process_run/shell_run.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addCommand('fetch')
    ..addCommand('answer')
    ..addCommand('delete')
    ..addOption('test', abbr: 't')
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'check',
      abbr: 'c',
      negatable: false,
      help: 'Check if the answer is right according to the challenge input',
    )
    ..addOption('part', abbr: 'p', help: 'Part')
    ..addOption('day', abbr: 'd', help: 'Challenge day')
    ..addOption('year', abbr: 'y', help: 'Challenge year')
    ..addFlag('version', abbr: 'v', help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('Usage: dart advent_of_code.dart <flags> [arguments]');
  print(argParser.usage);
}

final challenges = {
  2024: [
    Day1Year2024(),
    Day2Year2024(),
    Day3Year2024(),
    Day4Year2024(),
    Day5Year2024(),
    Day6Year2024(),
    Day7Year2024(),
    Day8Year2024(),
    Day9Year2024(),
    Day10Year2024(),
    Day11Year2024(),
    Day12Year2024(),
  ],
  2025: [Day1Year2025(), Day2Year2025(), Day3Year2025()],
};

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    int day = 1;
    int year = 2025;
    int indexPosition = 0;
    int part = 1;
    String answer;
    bool checkAnswer = false;
    Object result;

    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('advent_of_code version: $version');
      return;
    }
    if (results.flag("check")) {
      checkAnswer = true;
    }

    if (results.wasParsed('day')) {
      day = int.parse(results.option('day')!);
      indexPosition = day - 1;
    }
    if (results.wasParsed('part')) {
      part = int.parse(results.option('part')!);
    }
    if (results.wasParsed('year')) {
      year = int.parse(results.option('year')!);
    }

    if (results.command?.name == "fetch") {
      fetchInput(day, year);
      return;
    }

    if (results.command?.name == "delete") {
      FileUtils.deleteAnswer(day: 1, year: 2025, part: 1);
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

    if (results.command?.name == "answer") {
      FileUtils.writeAnswer(
        day: day,
        year: year,
        part: part,
        answer: result.toString(),
      );
    }

    copyToClipboard(result.toString());
    print("\nFinal Result:");
    print(result);
    if (checkAnswer) {
      answer = await FileUtils.getAnswer(day: day, year: year, part: part);
      if (answer == result.toString()) {
        print("Right Answer");
      } else {
        print("Try Again");
      }
    }
    print("\nTime Elapsed: ${stopwatch.elapsed}");
  } on FormatException catch (e) {
    print(e.message);
    printUsage(argParser);
  }
}

Future<void> fetchInput(int day, int year) async {
  var uri = Uri.https('adventofcode.com', '/$year/day/$day/input');
  var cookie = await FileUtils.readFromFile(".env");
  var headers = {"Cookie": cookie};

  try {
    var response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');
      return;
    }

    var contents = response.bodyBytes;
    contents = trimContent(contents);
    FileUtils.writeToFile('./lib/$year/day$day/input.txt', contents);
    print("Input fetched");
  } on Exception catch (ex) {
    print(ex);
  }
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
