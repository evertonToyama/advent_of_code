class Matrix<T extends Object?> implements Iterable<T> {
  List<T> _list = <T>[];
  int _columns = 0;
  T? _defaultValue;

  Matrix({required int columns, int rows = 1, T? defaultValue}) {
    _columns = columns;
    _defaultValue = defaultValue;
    _list = List.filled(columns * rows, defaultValue as T, growable: true);
  }

  Matrix.from(List<List<T>> values) {
    if (values.isEmpty) {
      throw Exception("Cannot create a matrix with no rows");
    }

    _columns = values[0].length;
    if (_columns == 0) {
      throw Exception("Cannot create a matrix with no columns");
    }

    for (var row in values) {
      if (row.length != _columns) {
        throw Exception('All the rows must be the same size');
      }

      _list.addAll(row);
    }
  }

  int get rowsLength => _columns;
  int get colsLength => _list.length ~/ _columns;
  int get capacity => _list.length;

  void clear() {
    for (var i = 0; i < _list.length; i++) {
      _list[i] = _defaultValue as T;
    }
  }

  void addRow(List<T> row) {
    if (row.length != rowsLength) {
      throw Exception(
        'The new row must be the same size of the previous rows. Row: [${row.length}] - RowsLength: [$rowsLength]',
      );
    }

    _list.addAll(row);
  }

  T get(Vector2 vec) {
    return _list[vec.x * _columns + vec.y];
  }

  T? tryGet(Vector2 pos) {
    if (!isValidPos(pos)) return null;

    return get(pos);
  }

  bool isValidPos(Vector2 pos) {
    return pos.x >= 0 && pos.x < colsLength && pos.y >= 0 && pos.y < rowsLength;
  }

  void insertVec(Vector2 vec, T item) {
    insert(vec.x, vec.y, item);
  }

  void insert(int row, int col, T item) {
    _list[row * _columns + col] = item;
  }

  (int row, int col) indexOf(T item) {
    var index = _list.indexOf(item);

    return (index ~/ _columns, index % _columns);
  }

  T operator []((int, int) pair) {
    var (r, c) = pair;
    return get(Vector2(r, c));
  }

  void operator []=((int, int) pair, T value) {
    var (r, c) = pair;
    insertVec(Vector2(r, c), value);
  }

  @override
  String toString() {
    var result = '';

    for (var index = 0; index < _list.length; index++) {
      if (index % _columns == 0) {
        result += '[';
      }

      result += '${_list[index]}, ';

      if (((index + 1) % _columns) == 0) {
        result = '${result.substring(0, result.length - 2)}]\n';
      }
    }

    return result;
  }

  @override
  bool operator ==(Object other) {
    return _list == other;
  }

  @override
  int get hashCode => _list.hashCode;

  @override
  bool any(bool Function(T element) test) {
    return _list.any(test);
  }

  @override
  Iterable<R> cast<R>() {
    return _list.cast();
  }

  @override
  bool contains(Object? element) {
    return _list.contains(element);
  }

  @override
  T elementAt(int index) {
    return _list[index];
  }

  @override
  bool every(bool Function(T element) test) {
    return _list.every(test);
  }

  @override
  Iterable<R> expand<R>(Iterable<R> Function(T element) toElements) {
    return _list.expand(toElements);
  }

  @override
  T get first => _list.first;

  @override
  T firstWhere(bool Function(T element) test, {T Function()? orElse}) {
    return _list.firstWhere(test, orElse: orElse);
  }

  @override
  R fold<R>(R initialValue, R Function(R previousValue, T element) combine) {
    return _list.fold(initialValue, combine);
  }

  @override
  Iterable<T> followedBy(Iterable<T> other) {
    return _list.followedBy(other);
  }

  @override
  void forEach(void Function(T element) action) {
    _list.forEach(action);
  }

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  Iterator<T> get iterator => _list.iterator;

  @override
  String join([String separator = ""]) {
    return _list.join(separator);
  }

  @override
  T get last => _list.last;

  @override
  T lastWhere(bool Function(T element) test, {T Function()? orElse}) {
    return _list.lastWhere(test, orElse: orElse);
  }

  @override
  int get length => _list.length;

  @override
  Iterable<R> map<R>(R Function(T e) toElement) {
    return _list.map(toElement);
  }

  @override
  T reduce(T Function(T value, T element) combine) {
    return _list.reduce(combine);
  }

  @override
  T get single => _list.single;

  @override
  T singleWhere(bool Function(T element) test, {T Function()? orElse}) {
    return _list.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> skip(int count) {
    return _list.skip(count);
  }

  @override
  Iterable<T> skipWhile(bool Function(T value) test) {
    return _list.skipWhile(test);
  }

  @override
  Iterable<T> take(int count) {
    return _list.take(count);
  }

  @override
  Iterable<T> takeWhile(bool Function(T value) test) {
    return _list.takeWhile(test);
  }

  @override
  List<T> toList({bool growable = true}) {
    return _list.toList(growable: growable);
  }

  @override
  Set<T> toSet() {
    return _list.toSet();
  }

  @override
  Iterable<T> where(bool Function(T element) test) {
    return _list.where(test);
  }

  @override
  Iterable<R> whereType<R>() {
    return _list.whereType();
  }

  @override
  bool get isEmpty => !_list.any((element) => element != _defaultValue);
}

class Vector2 {
  final int x;
  final int y;

  Vector2(this.x, this.y);

  Vector2.zero() : x = 0, y = 0;
  Vector2.one() : x = 1, y = 1;
  Vector2.up() : x = 1, y = 0;
  Vector2.down() : x = -1, y = 0;
  Vector2.right() : x = 0, y = 1;
  Vector2.left() : x = 0, y = -1;

  Vector2 operator +(Vector2 other) {
    return Vector2(x + other.x, y + other.y);
  }

  Vector2 operator -(Vector2 other) {
    return Vector2(x - other.x, y - other.y);
  }

  Vector2 operator *(int multiplier) {
    return Vector2(x * multiplier, y * multiplier);
  }

  Vector2 abs() {
    return Vector2(x.abs(), y.abs());
  }

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  bool operator ==(covariant Vector2 other) {
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => x.hashCode + y.hashCode;
}

class Vector3 {
  final int x;
  final int y;
  final int z;

  Vector3(this.x, this.y, this.z);

  Vector3.zero() : x = 0, y = 0, z = 0;
  Vector3.one() : x = 1, y = 1, z = 1;

  Vector3 operator +(Vector3 other) {
    return Vector3(x + other.x, y + other.y, z + other.z);
  }

  Vector3 operator -(Vector3 other) {
    return Vector3(x - other.x, y - other.y, z - other.z);
  }

  Vector3 operator *(int multiplier) {
    return Vector3(x * multiplier, y * multiplier, z * multiplier);
  }

  @override
  String toString() {
    return '($x, $y $z)';
  }

  @override
  bool operator ==(covariant Vector3 other) {
    return x == other.x && y == other.y && z == other.z;
  }

  @override
  int get hashCode => x.hashCode + y.hashCode + z.hashCode;
}
