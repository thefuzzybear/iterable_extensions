import 'package:test/test.dart';
import 'package:iterable_extensions/iterable_extensions.dart';

import '../example/thing.model.dart';

void main() {
  group('Null-safe operations', () {
    test('firstWhereOrNull returns first matching element', () {
      final numbers = [1, 2, 3, 4, 5];
      expect(numbers.firstWhereOrNull((n) => n.isEven), equals(2));
      expect(numbers.firstWhereOrNull((n) => n > 10), isNull);
    });

    test('lastWhereOrNull returns last matching element', () {
      final numbers = [1, 2, 3, 4, 5];
      expect(numbers.lastWhereOrNull((n) => n.isEven), equals(4));
      expect(numbers.lastWhereOrNull((n) => n > 10), isNull);
    });

    test('singleWhereOrNull returns single matching element', () {
      final numbers = [1, 2, 3, 4, 5];
      expect(numbers.singleWhereOrNull((n) => n == 3), equals(3));
      expect(numbers.singleWhereOrNull((n) => n.isEven),
          isNull); // Multiple matches
      expect(numbers.singleWhereOrNull((n) => n > 10), isNull); // No matches
    });

    test('firstOrNull returns first element or null', () {
      final numbers = [1, 2, 3];
      final empty = <int>[];
      expect(numbers.firstOrNull, equals(1));
      expect(empty.firstOrNull, isNull);
    });

    test('lastOrNull returns last element or null', () {
      final numbers = [1, 2, 3];
      final empty = <int>[];
      expect(numbers.lastOrNull, equals(3));
      expect(empty.lastOrNull, isNull);
    });

    test('singleOrNull returns single element or null', () {
      final single = [42];
      final multiple = [1, 2, 3];
      final empty = <int>[];
      expect(single.singleOrNull, equals(42));
      expect(multiple.singleOrNull, isNull);
      expect(empty.singleOrNull, isNull);
    });

    test('elementAtOrNull returns element at index or null', () {
      final numbers = [10, 20, 30];
      expect(numbers.elementAtOrNull(1), equals(20));
      expect(numbers.elementAtOrNull(5), isNull);
      expect(numbers.elementAtOrNull(-1), isNull);
    });

    test('elementAtOrNull returns element at index or null', () {
      const things = [
        Thing(thing: '1'),
        Thing(thing: '2'),
        Thing(thing: '3'),
      ];
      const thing = Thing(thing: '1');
      const thing_4 = Thing(thing: '4');

      expect(things.indexOfOrNull(thing), equals(0));
      expect(things.indexOfOrNull(thing_4), isNull);
    });
  });

  group('Collection utilities', () {
    test('groupBy groups elements by key', () {
      final words = ['apple', 'banana', 'apricot', 'blueberry'];
      final grouped = words.groupBy((word) => word[0]);
      expect(grouped['a'], equals(['apple', 'apricot']));
      expect(grouped['b'], equals(['banana', 'blueberry']));
    });

    test('distinctBy removes duplicates based on selector', () {
      final words = ['apple', 'banana', 'apricot', 'blueberry'];
      final uniqueByLength = words.distinctBy((w) => w.length).toList();
      expect(uniqueByLength.length, equals(4)); // lengths: 5, 6, 7, 9
      expect(uniqueByLength, contains('apple')); // length 5
      expect(uniqueByLength, contains('banana')); // length 6
      expect(uniqueByLength, contains('apricot')); // length 7
      expect(uniqueByLength, contains('blueberry')); // length 9
    });

    test('distinct removes duplicate elements', () {
      final numbers = [1, 2, 2, 3, 3, 4];
      final unique = numbers.distinct.toList();
      expect(unique, equals([1, 2, 3, 4]));
    });

    test('chunked splits into chunks', () {
      final numbers = [1, 2, 3, 4, 5, 6, 7, 8];
      final chunks = numbers.chunked(3).toList();
      expect(
          chunks,
          equals([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8]
          ]));
    });

    test('chunked throws on invalid size', () {
      final numbers = [1, 2, 3];
      expect(() => numbers.chunked(0), throwsArgumentError);
      expect(() => numbers.chunked(-1), throwsArgumentError);
    });
  });

  group('Predicates', () {
    test('all returns true if all elements match', () {
      final evens = [2, 4, 6, 8];
      final mixed = [1, 2, 3, 4];
      final empty = <int>[];
      expect(evens.all((n) => n.isEven), isTrue);
      expect(mixed.all((n) => n.isEven), isFalse);
      expect(empty.all((n) => n > 100), isTrue); // Vacuous truth
    });

    test('none returns true if no elements match', () {
      final odds = [1, 3, 5, 7];
      final mixed = [1, 2, 3, 4];
      final empty = <int>[];
      expect(odds.none((n) => n.isEven), isTrue);
      expect(mixed.none((n) => n.isEven), isFalse);
      expect(empty.none((n) => n > 0), isTrue);
    });
  });

  group('Min/Max operations', () {
    test('minOrNull returns minimum or null', () {
      final numbers = [3, 1, 4, 1, 5];
      final empty = <int>[];
      expect(numbers.minOrNull, equals(1));
      expect(empty.minOrNull, isNull);
    });

    test('maxOrNull returns maximum or null', () {
      final numbers = [3, 1, 4, 1, 5];
      final empty = <int>[];
      expect(numbers.maxOrNull, equals(5));
      expect(empty.maxOrNull, isNull);
    });

    test('minByOrNull returns minimum by selector', () {
      final words = ['banana', 'apple', 'cherry'];
      final empty = <String>[];
      expect(words.minByOrNull((w) => w.length), equals('apple'));
      expect(empty.minByOrNull((w) => w.length), isNull);
    });

    test('maxByOrNull returns maximum by selector', () {
      final words = ['banana', 'apple', 'cherry'];
      final empty = <String>[];
      expect(words.maxByOrNull((w) => w.length), equals('banana'));
      expect(empty.maxByOrNull((w) => w.length), isNull);
    });
  });

  group('Functional operations', () {
    test('+ operator concatenates iterables', () {
      final first = [1, 2, 3];
      final second = [4, 5, 6];
      final combined = (first + second).toList();
      expect(combined, equals([1, 2, 3, 4, 5, 6]));
    });

    test('forEachIndexed iterates with index', () {
      final fruits = ['apple', 'banana', 'cherry'];
      final results = <String>[];
      fruits.forEachIndexed((index, fruit) {
        results.add('$index:$fruit');
      });
      expect(results, equals(['0:apple', '1:banana', '2:cherry']));
    });

    test('indexed returns elements with indices', () {
      final fruits = ['apple', 'banana'];
      final indexed = fruits.indexed.toList();
      expect(indexed.length, equals(2));
      expect(indexed[0].key, equals(0));
      expect(indexed[0].value, equals('apple'));
      expect(indexed[1].key, equals(1));
      expect(indexed[1].value, equals('banana'));
    });

    test('reversed returns reversed iterable', () {
      final numbers = [1, 2, 3, 4, 5];
      final reversed = numbers.reversed.toList();
      expect(reversed, equals([5, 4, 3, 2, 1]));
    });
  });

  group('Mathematical operations', () {
    test('sum returns sum of elements', () {
      final numbers = [1, 2, 3, 4, 5];
      expect(numbers.sum(), equals(15));
    });

    test('sum throws on empty iterable', () {
      final empty = <int>[];
      expect(() => empty.sum(), throwsStateError);
    });

    test('sumOrNull returns sum or null', () {
      final numbers = [1, 2, 3, 4, 5];
      final empty = <int>[];
      expect(numbers.sumOrNull, equals(15));
      expect(empty.sumOrNull, isNull);
    });

    test('average returns average of elements', () {
      final numbers = [1, 2, 3, 4, 5];
      final empty = <int>[];
      expect(numbers.average, equals(3.0));
      expect(empty.average, isNull);
    });

    test('mathematical operations work with doubles', () {
      final doubles = [1.5, 2.5, 3.0];
      expect(doubles.sum(), equals(7.0));
      expect(doubles.average, equals(7.0 / 3));
    });
  });

  group('Edge cases', () {
    test('operations work with empty iterables', () {
      final empty = <int>[];
      expect(empty.firstOrNull, isNull);
      expect(empty.lastOrNull, isNull);
      expect(empty.singleOrNull, isNull);
      expect(empty.minOrNull, isNull);
      expect(empty.maxOrNull, isNull);
      expect(empty.sumOrNull, isNull);
      expect(empty.average, isNull);
      expect(empty.distinct.toList(), isEmpty);
      expect(empty.all((n) => n > 0), isTrue);
      expect(empty.none((n) => n > 0), isTrue);
    });

    test('operations work with single element', () {
      final single = [42];
      expect(single.firstOrNull, equals(42));
      expect(single.lastOrNull, equals(42));
      expect(single.singleOrNull, equals(42));
      expect(single.minOrNull, equals(42));
      expect(single.maxOrNull, equals(42));
      expect(single.sum(), equals(42));
      expect(single.average, equals(42.0));
    });

    test('chunked handles empty and small iterables', () {
      final empty = <int>[];
      final single = [1];

      expect(empty.chunked(3).toList(), isEmpty);
      expect(
          single.chunked(3).toList(),
          equals([
            [1]
          ]));
    });
  });
}
