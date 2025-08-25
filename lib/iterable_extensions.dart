/// A comprehensive collection of useful extension methods for Dart's Iterable class.
///
/// This library provides null-safe alternatives to common operations, collection utilities,
/// and functional programming helpers that make working with iterables more convenient
/// and expressive.
///
/// Example usage:
/// ```dart
/// import 'package:iterable_extensions/iterable_extensions.dart';
///
/// final numbers = [1, 2, 3, 4, 5];
/// final firstEven = numbers.firstWhereOrNull((n) => n.isEven); // 2
/// final sum = numbers.sum(); // 15
/// final average = numbers.average; // 3.0
/// ```
library iterable_extensions;

extension IterableExtension<T> on Iterable<T> {
  /// Returns the first element that satisfies the given predicate [test].
  /// Returns null if no element satisfies the predicate.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final firstEven = numbers.firstWhereOrNull((n) => n.isEven); // 2
  /// final firstNegative = numbers.firstWhereOrNull((n) => n < 0); // null
  /// ```
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Returns the last element that satisfies the given predicate [test].
  /// Returns null if no element satisfies the predicate.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final lastEven = numbers.lastWhereOrNull((n) => n.isEven); // 4
  /// final lastNegative = numbers.lastWhereOrNull((n) => n < 0); // null
  /// ```
  T? lastWhereOrNull(bool Function(T element) test) {
    T? result;
    for (final element in this) {
      if (test(element)) result = element;
    }
    return result;
  }

  /// Returns the single element that satisfies the given predicate [test].
  /// Returns null if no element or more than one element satisfies the predicate.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final singleThree = numbers.singleWhereOrNull((n) => n == 3); // 3
  /// final singleEven = numbers.singleWhereOrNull((n) => n.isEven); // null (multiple evens)
  /// final singleNegative = numbers.singleWhereOrNull((n) => n < 0); // null (no negatives)
  /// ```
  T? singleWhereOrNull(bool Function(T element) test) {
    T? result;
    bool found = false;

    for (final element in this) {
      if (test(element)) {
        if (found) {
          // More than one element matches - return null
          return null;
        }
        result = element;
        found = true;
      }
    }

    return result; // Returns null if no matches, or the single match
  }

  /// Returns the first element of the iterable, or null if empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final empty = <int>[];
  /// print(numbers.firstOrNull); // 1
  /// print(empty.firstOrNull); // null
  /// ```
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element of the iterable, or null if empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3];
  /// final empty = <int>[];
  /// print(numbers.lastOrNull); // 3
  /// print(empty.lastOrNull); // null
  /// ```
  T? get lastOrNull => isEmpty ? null : last;

  /// Returns the single element of the iterable, or null if empty or has more than one element.
  ///
  /// Example:
  /// ```dart
  /// final single = [42];
  /// final multiple = [1, 2, 3];
  /// final empty = <int>[];
  /// print(single.singleOrNull); // 42
  /// print(multiple.singleOrNull); // null
  /// print(empty.singleOrNull); // null
  /// ```
  T? get singleOrNull {
    if (isEmpty) return null;
    final iterator = this.iterator;
    iterator.moveNext();
    final first = iterator.current;
    if (iterator.moveNext()) return null; // More than one element
    return first;
  }

  /// Returns the element at the given [index], or null if index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [10, 20, 30];
  /// print(numbers.elementAtOrNull(1)); // 20
  /// print(numbers.elementAtOrNull(5)); // null
  /// print(numbers.elementAtOrNull(-1)); // null
  /// ```
  T? elementAtOrNull(int index) {
    if (index < 0) return null;

    int currentIndex = 0;
    for (final element in this) {
      if (currentIndex == index) {
        return element;
      }
      currentIndex++;
    }

    return null; // Index is out of bounds
  }

  /// Returns the index of the first occurrence of [value] in the iterable,
  /// or null if the value is not found.
  ///
  /// Example:
  /// ```
  /// final list = ['a', 'b', 'c'];
  /// print(list.indexOfOrNull('b')); // 1
  /// print(list.indexOfOrNull('z')); // null
  /// ```
  int? indexOfOrNull(dynamic value) {
    int index = 0;
    for (final element in this) {
      if (element == value) {
        return index;
      }
      index++;
    }
    return null;
  }

  /// Groups elements by the result of [keySelector].
  ///
  /// Example:
  /// ```dart
  /// final words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// final grouped = words.groupBy((word) => word[0]);
  /// // Result: {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}
  ///
  /// final numbers = [1, 2, 3, 4, 5, 6];
  /// final evenOdd = numbers.groupBy((n) => n.isEven ? 'even' : 'odd');
  /// // Result: {'odd': [1, 3, 5], 'even': [2, 4, 6]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T element) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => <T>[]).add(element);
    }
    return map;
  }

  /// Returns a new iterable with distinct elements based on [keySelector].
  /// If [keySelector] is not provided, uses element equality.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 2, 3, 3, 4];
  /// final unique = numbers.distinctBy().toList(); // [1, 2, 3, 4]
  ///
  /// final words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// final uniqueByLength = words.distinctBy((w) => w.length).toList();
  /// // Result: ['apple', 'banana', 'blueberry'] (distinct lengths: 5, 6, 9)
  /// ```
  Iterable<T> distinctBy<K>([K Function(T element)? keySelector]) {
    final seen = <K>{};
    return where((element) {
      final key = keySelector?.call(element) ?? element as K;
      return seen.add(key);
    });
  }

  /// Returns distinct elements using element equality.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 2, 3, 3, 4];
  /// final unique = numbers.distinct.toList(); // [1, 2, 3, 4]
  /// ```
  Iterable<T> get distinct => distinctBy<T>();

  /// Splits the iterable into chunks of the specified [size].
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5, 6, 7, 8];
  /// final chunks = numbers.chunked(3).toList();
  /// // Result: [[1, 2, 3], [4, 5, 6], [7, 8]]
  ///
  /// final letters = ['a', 'b', 'c', 'd', 'e'];
  /// final pairs = letters.chunked(2).toList();
  /// // Result: [['a', 'b'], ['c', 'd'], ['e']]
  /// ```
  Iterable<List<T>> chunked(int size) sync* {
    if (size <= 0) throw ArgumentError('Chunk size must be positive');

    final iterator = this.iterator;
    while (iterator.moveNext()) {
      final chunk = <T>[iterator.current];
      for (int i = 1; i < size && iterator.moveNext(); i++) {
        chunk.add(iterator.current);
      }
      yield chunk;
    }
  }

  /// Returns true if all elements satisfy the given predicate [test].
  /// Returns true for empty iterables.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [2, 4, 6, 8];
  /// final allEven = numbers.all((n) => n.isEven); // true
  /// final allPositive = numbers.all((n) => n > 0); // true
  /// final allBig = numbers.all((n) => n > 10); // false
  /// final empty = <int>[];
  /// final emptyResult = empty.all((n) => n > 100); // true
  /// ```
  bool all(bool Function(T element) test) => every(test);

  /// Returns true if no element satisfies the given predicate [test].
  /// Returns true for empty iterables.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 3, 5, 7];
  /// final noneEven = numbers.none((n) => n.isEven); // true
  /// final noneNegative = numbers.none((n) => n < 0); // true
  /// final noneBig = numbers.none((n) => n > 3); // false (5 and 7 are > 3)
  /// final empty = <int>[];
  /// final emptyResult = empty.none((n) => n > 0); // true
  /// ```
  bool none(bool Function(T element) test) => !any(test);

  /// Returns the minimum element according to the natural ordering,
  /// or null if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [3, 1, 4, 1, 5];
  /// print(numbers.minOrNull); // 1
  /// final empty = <int>[];
  /// print(empty.minOrNull); // null
  ///
  /// final words = ['banana', 'apple', 'cherry'];
  /// print(words.minOrNull); // 'apple' (alphabetically first)
  /// ```
  T? get minOrNull {
    if (isEmpty) return null;
    return reduce((a, b) => (a as Comparable).compareTo(b) <= 0 ? a : b);
  }

  /// Returns the maximum element according to the natural ordering,
  /// or null if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [3, 1, 4, 1, 5];
  /// print(numbers.maxOrNull); // 5
  /// final empty = <int>[];
  /// print(empty.maxOrNull); // null
  ///
  /// final words = ['banana', 'apple', 'cherry'];
  /// print(words.maxOrNull); // 'cherry' (alphabetically last)
  /// ```
  T? get maxOrNull {
    if (isEmpty) return null;
    return reduce((a, b) => (a as Comparable).compareTo(b) >= 0 ? a : b);
  }

  /// Returns the minimum element according to the given [selector],
  /// or null if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final words = ['banana', 'apple', 'cherry'];
  /// final shortest = words.minByOrNull((w) => w.length); // 'apple'
  ///
  /// final people = [
  ///   {'name': 'Alice', 'age': 30},
  ///   {'name': 'Bob', 'age': 25},
  ///   {'name': 'Charlie', 'age': 35}
  /// ];
  /// final youngest = people.minByOrNull((p) => p['age']); // Bob's record
  /// ```
  T? minByOrNull<R extends Comparable<Object>>(R Function(T element) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => selector(a).compareTo(selector(b)) <= 0 ? a : b);
  }

  /// Returns the maximum element according to the given [selector],
  /// or null if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final words = ['banana', 'apple', 'cherry'];
  /// final longest = words.maxByOrNull((w) => w.length); // 'banana'
  ///
  /// final people = [
  ///   {'name': 'Alice', 'age': 30},
  ///   {'name': 'Bob', 'age': 25},
  ///   {'name': 'Charlie', 'age': 35}
  /// ];
  /// final oldest = people.maxByOrNull((p) => p['age']); // Charlie's record
  /// ```
  T? maxByOrNull<R extends Comparable<Object>>(R Function(T element) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => selector(a).compareTo(selector(b)) >= 0 ? a : b);
  }

  /// Returns a new iterable with elements in reverse order.
  /// Note: This materializes the entire iterable into a list first.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final reversed = numbers.reversed.toList(); // [5, 4, 3, 2, 1]
  ///
  /// final words = ['hello', 'world'];
  /// final reversedWords = words.reversed.toList(); // ['world', 'hello']
  /// ```
  Iterable<T> get reversed => toList().reversed;

  /// Returns a new iterable that yields elements from this iterable
  /// followed by elements from [other].
  ///
  /// Example:
  /// ```dart
  /// final first = [1, 2, 3];
  /// final second = [4, 5, 6];
  /// final combined = (first + second).toList(); // [1, 2, 3, 4, 5, 6]
  ///
  /// final letters = ['a', 'b'];
  /// final numbers = ['1', '2'];
  /// final mixed = (letters + numbers).toList(); // ['a', 'b', '1', '2']
  ///
  /// // Works with any iterable, including map results
  /// final nums = [1, 2, 3];
  /// final strings = (nums + nums.map((n) => n.toString())).toList();
  /// ```
  Iterable<T> operator +(Iterable<T> other) sync* {
    yield* this;
    yield* other;
  }

  /// Performs the given [action] on each element with its index.
  ///
  /// Example:
  /// ```dart
  /// final fruits = ['apple', 'banana', 'cherry'];
  /// fruits.forEachIndexed((index, fruit) {
  ///   print('$index: $fruit');
  /// });
  /// // Output:
  /// // 0: apple
  /// // 1: banana
  /// // 2: cherry
  /// ```
  void forEachIndexed(void Function(int index, T element) action) {
    int index = 0;
    for (final element in this) {
      action(index++, element);
    }
  }

  /// Returns a new iterable with elements paired with their indices.
  ///
  /// Example:
  /// ```dart
  /// final fruits = ['apple', 'banana', 'cherry'];
  /// final indexed = fruits.indexed.toList();
  /// // Result: [MapEntry(0, 'apple'), MapEntry(1, 'banana'), MapEntry(2, 'cherry')]
  ///
  /// for (final entry in fruits.indexed) {
  ///   print('Index ${entry.key}: ${entry.value}');
  /// }
  /// ```
  Iterable<MapEntry<int, T>> get indexed sync* {
    int index = 0;
    for (final element in this) {
      yield MapEntry(index++, element);
    }
  }

  /// Returns the sum of all elements (only works with num types).
  /// Throws if called on non-numeric types or if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final total = numbers.sum(); // 15
  ///
  /// final doubles = [1.5, 2.5, 3.0];
  /// final sum = doubles.sum(); // 7.0
  ///
  /// final empty = <int>[];
  /// // empty.sum(); // Throws StateError
  /// ```
  T sum() {
    if (isEmpty) throw StateError('Cannot sum empty iterable');
    return reduce((a, b) => (a as num) + (b as num) as T);
  }

  /// Returns the sum of all elements, or null if empty (only works with num types).
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final total = numbers.sumOrNull; // 15
  ///
  /// final empty = <int>[];
  /// final emptySum = empty.sumOrNull; // null
  /// ```
  T? get sumOrNull => isEmpty ? null : sum();

  /// Returns the average of all elements (only works with num types).
  /// Returns null if empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final avg = numbers.average; // 3.0
  ///
  /// final scores = [85, 90, 78, 92];
  /// final avgScore = scores.average; // 86.25
  ///
  /// final empty = <int>[];
  /// final emptyAvg = empty.average; // null
  /// ```
  double? get average {
    if (isEmpty) return null;
    final total = sum() as num;
    return total / length;
  }
}
