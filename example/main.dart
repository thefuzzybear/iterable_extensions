import 'package:iterable_extensions/iterable_extensions.dart';

import 'thing.model.dart';

void main() {
  print('🚀 Iterable Extensions Examples\n');

  // Example 1: Null-safe operations
  print('1. Null-safe operations:');
  final numbers = [1, 2, 3, 4, 5];
  final emptyList = <int>[];
  const things = [
    Thing(thing: '1'),
    Thing(thing: '2'),
    Thing(thing: '3'),
  ];
  const thing = Thing(thing: '1');
  print('  numbers.firstOrNull: ${numbers.firstOrNull}'); // 1
  print('  emptyList.firstOrNull: ${emptyList.firstOrNull}'); // null
  print(
      '  numbers.firstWhereOrNull((n) => n.isEven): ${numbers.firstWhereOrNull((n) => n.isEven)}'); // 2
  print(
      '  numbers.elementAtOrNull(10): ${numbers.elementAtOrNull(10)}'); // null

  print(' things.indexOfOrNull(thing): ${things.indexOfOrNull(thing)} '); //0
  print('');
  // Example 2: Collection utilities
  print('2. Collection utilities:');
  final fruits = ['apple', 'banana', 'apricot', 'blueberry', 'avocado'];

  final groupedByFirstLetter = fruits.groupBy((fruit) => fruit[0]);
  print('  Grouped by first letter: $groupedByFirstLetter');

  final duplicates = [1, 2, 2, 3, 3, 3, 4, 5, 5];
  final unique = duplicates.distinct.toList();
  print('  Duplicates: $duplicates');
  print('  Unique: $unique');

  final chunked = numbers.chunked(2).toList();
  print('  Numbers chunked by 2: $chunked');
  print('');

  // Example 3: Mathematical operations
  print('3. Mathematical operations:');
  final scores = [85, 92, 78, 96, 88];
  print('  Scores: $scores');
  print('  Sum: ${scores.sum()}');
  print('  Average: ${scores.average}');
  print('  Min: ${scores.minOrNull}');
  print('  Max: ${scores.maxOrNull}');
  print('  Empty list sum: ${emptyList.sumOrNull}');
  print('');

  // Example 4: Advanced filtering
  print('4. Advanced filtering:');
  final mixedNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final allEven = [2, 4, 6, 8];
  final someOdd = [1, 3, 5, 7, 2];

  print(
      ' All numbers even in [2,4,6,8]: ${allEven.all((n) => n.isEven)}'); // true
  print(
      ' No numbers > 10 in mixedNumbers: ${mixedNumbers.none((n) => n > 10)}'); // true
  print(
      ' All numbers < 5 in mixedNumbers: ${mixedNumbers.all((n) => n < 5)}'); // false
  print(' Some numbers odd in someOdd: ${someOdd.any((n) => n.isOdd)}'); // true
  print(
      ' None even in someOdd: ${someOdd.none((n) => n.isEven)}'); // false (2 is even)
  print('');

  // Example 5: Min/Max by selector
  print('5. Min/Max by selector:');
  final words = ['elephant', 'cat', 'hippopotamus', 'dog'];
  print('  Words: $words');
  print('  Shortest word: ${words.minByOrNull((w) => w.length)}');
  print('  Longest word: ${words.maxByOrNull((w) => w.length)}');
  print('');

  // Example 6: Functional operations
  print('6. Functional operations:');
  final letters = ['a', 'b', 'c'];
  final moreNumbers = [4, 5, 6];

  // Convert numbers to strings and combine
  final numberStrings = moreNumbers.map((n) => n.toString()).toList();
  final combined = (letters + numberStrings).toList();
  print('  Combined: $combined');

  print('  Indexed iteration:');
  fruits.take(3).forEachIndexed((index, fruit) {
    print('    $index: $fruit');
  });

  final indexed = numbers.take(3).indexed.toList();
  print('  Indexed pairs: $indexed');
  print('');

  // Example 7: Real-world scenario
  print('7. Real-world scenario - Processing user data:');
  final users = [
    {'name': 'Alice', 'age': 30, 'city': 'New York'},
    {'name': 'Bob', 'age': 25, 'city': 'London'},
    {'name': 'Charlie', 'age': 35, 'city': 'New York'},
    {'name': 'Diana', 'age': 28, 'city': 'Paris'},
    {'name': 'Eve', 'age': 32, 'city': 'London'},
  ];

  // Group users by city
  final usersByCity = users.groupBy((user) => user['city'] as String);
  print('  Users by city:');
  usersByCity.forEach((city, cityUsers) {
    final names = cityUsers.map((u) => u['name']).join(', ');
    print('    $city: $names');
  });

  // Find youngest and oldest users
  final youngest = users.minByOrNull((user) => user['age'] as int);
  final oldest = users.maxByOrNull((user) => user['age'] as int);
  print('  Youngest user: ${youngest?['name']} (${youngest?['age']})');
  print('  Oldest user: ${oldest?['name']} (${oldest?['age']})');

  // Calculate average age
  final ages = users.map((user) => user['age'] as int);
  print('  Average age: ${ages.average}');

  // Check if all users are adults
  final allAdults = users.all((user) => (user['age'] as int) >= 18);
  print('  All users are adults: $allAdults');
  print('');

  print('✅ All examples completed!');
}
