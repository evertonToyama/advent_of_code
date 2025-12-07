import 'package:advent_of_code/utils/math.dart';
import 'package:test/test.dart';

void main() {
  group('Create Matrix From Lists', () {
    final testCases = {
      'test 01': (
        <List<int>>[
          [0, 0],
          [0, 0],
        ],
        <int>[0, 0, 0, 0],
      ),
      'test 02': (
        <List<int>>[
          [0, 0],
          [0, 0],
        ],
        Matrix<int>(columns: 2, rows: 2, defaultValue: 0),
      ),
      'test 03': (
        <List<String>>[
          ['a', 'a'],
          ['a', 'a'],
        ],
        <String>['a', 'a', 'a', 'a'],
      ),
    };

    testCases.forEach((description, args) {
      test(description, () {
        var (input, expected) = args;
        var matrix = Matrix.from(input);
        expect(matrix, equals(expected));
      });
    });
  });

  group('Create Matrix', () {
    final testCases = {
      'test 01': (2, 2, 0, <int>[0, 0, 0, 0]),
    };

    testCases.forEach((description, args) {
      test(description, () {
        var (columns, rows, defaultValue, expected) = args;
        var matrix = Matrix(
          columns: columns,
          rows: rows,
          defaultValue: defaultValue,
        );
        expect(matrix, equals(expected));
      });
    });
  });

  group('Create Nullable Matrix', () {
    final testCases = {
      'test 01': (2, 2, [null, null, null, null]),
      'test 02': (2, 2, <int?>[null, null, null, null]),
    };

    testCases.forEach((description, args) {
      test(description, () {
        var (columns, rows, expected) = args;
        var matrix = Matrix(columns: columns, rows: rows);
        expect(matrix, equals(expected));
      });
    });
  });

  group('Clear Matrix', () {
    final testCases = {'test 01': (2, 2, 0, [])};

    testCases.forEach((description, args) {
      test(description, () {
        var (columns, rows, defaultValue, expected) = args;
        var matrix = Matrix(
          columns: columns,
          rows: rows,
          defaultValue: defaultValue,
        );
        matrix.insert(0, 0, 1);
        matrix.clear();
        // matrix[(0, 0)] = 1;

        expect(matrix, isEmpty);
      });
    });
  });

  group('Add', () {
    final testCases = {
      'test 01': (2, 2, 0, <int>[0, 0], <int>[0, 0, 0, 0, 0, 0]),
    };

    testCases.forEach((description, args) {
      test(description, () {
        var (columns, rows, defaultValue, newRow, expected) = args;
        var matrix = Matrix(
          columns: columns,
          rows: rows,
          defaultValue: defaultValue,
        );
        // var matrix = Matrix.from(<List<int>>[[0, 0], [0, 0]]);
        matrix.addRow(newRow);

        expect(matrix, expected);
      });
    });

    test('Constructor', () {
      var matrix = Matrix<int>(columns: 2, rows: 2, defaultValue: 0);
      // matrix[(0, 0)] = 0;
      expect(matrix, isA<Matrix<int>>());
      // expect(matrix.get(Vector2.zero()), throwsException);
      // print(matrix[(0, 0)]);
    });

    test('From List', () {
      final List<List<int>> list = [[], []];
      final matrix = Matrix<int>.from(list);
      expect(matrix, isA<Matrix<int>>());
    });

    test('type error', () {
      expect(() => Matrix<int>(columns: 2, rows: 2), throwsA(isA<TypeError>()));
    });
  });
}
