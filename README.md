# Iterable Extensions

A comprehensive collection of useful extension methods for Dart's `Iterable<T>` class. These extensions provide null-safe alternatives to common operations, collection utilities, and functional programming helpers that make working with iterables more convenient and expressive.

## Features

🛡️ **Null-safe operations** - Safe alternatives to methods that throw exceptions  
🔍 **Enhanced filtering** - Advanced filtering and search capabilities  
📊 **Collection utilities** - Grouping, chunking, and distinct operations  
🧮 **Mathematical operations** - Sum, average, min/max with null safety  
🔄 **Transformation helpers** - Convenient ways to transform and combine iterables  
📈 **Performance focused** - Lazy evaluation where possible

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  iterable_extensions: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Usage

Import the package and the extension methods will be automatically available on all `Iterable<T>` instances:

```dart
import 'package:iterable_extensions/iterable_extensions.dart';

void main() {
  final numbers = [1, 2, 3, 4, 5];
  
  // Null-safe operations
  final firstEven = numbers.firstWhereOrNull((n) => n.isEven); // 2
  final elementAt10 = numbers.elementAtOrNull(10); // null
  
  // Collection utilities
  final grouped = numbers.groupBy((n) => n.isEven ? 'even' : 'odd');
  // {'odd': [1, 3, 5], 'even': [2, 4]}
  
  // Mathematical operations
  final sum = numbers.sum(); // 15
  final average = numbers.average; // 3.0
}
```

## Extension Methods

### Null-Safe Operations

Replace exception-throwing methods with null-returning alternatives:

```dart
final numbers = [1, 2, 3, 4, 5];
final empty = <int>[];

// Safe element access
final first = numbers.firstOrNull; // 1
final emptyFirst = empty.firstOrNull; // null

// Safe conditional access
final firstEven = numbers.firstWhereOrNull((n) => n.isEven); // 2
final firstNegative = numbers.firstWhereOrNull((n) => n < 0); // null

// Safe index access
final third = numbers.elementAtOrNull(2); // 3
final outOfBounds = numbers.elementAtOrNull(10); // null
```

### Collection Utilities

Group, chunk, and manipulate collections easily:

```dart
final words = ['apple', 'banana', 'apricot', 'blueberry'];

// Group by criteria
final byFirstLetter = words.groupBy((word) => word[0]);
// {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}

// Remove duplicates
final numbers = [1, 2, 2, 3, 3, 4];
final unique = numbers.distinct.toList(); // [1, 2, 3, 4]

// Split into chunks
final chunks = numbers.chunked(2).toList(); // [[1, 2], [2, 3], [3, 4]]
```

### Mathematical Operations

Perform calculations with null safety:

```dart
final numbers = [1, 2, 3, 4, 5];
final empty = <int>[];

// Sum and average
final total = numbers.sum(); // 15
final avg = numbers.average; // 3.0
final emptySum = empty.sumOrNull; // null

// Min and max
final min = numbers.minOrNull; // 1
final max = numbers.maxOrNull; // 5

// Min/max by selector
final words = ['apple', 'banana', 'cherry'];
final shortest = words.minByOrNull((w) => w.length); // 'apple'
final longest = words.maxByOrNull((w) => w.length); // 'banana'
```

### Functional Operations

Enhanced functional programming support:

```dart
final numbers = [2, 4, 6, 8];

// Enhanced predicates
final allEven = numbers.all((n) => n.isEven); // true
final noneOdd = numbers.none((n) => n.isOdd); // true

// Combine iterables
final first = [1, 2, 3];
final second = [4, 5, 6];
final combined = (first + second).toList(); // [1, 2, 3, 4, 5, 6]

// Indexed operations
numbers.forEachIndexed((index, value) {
  print('$index: $value');
});

final indexed = numbers.indexed.toList();
// [MapEntry(0, 2), MapEntry(1, 4), MapEntry(2, 6), MapEntry(3, 8)]
```

## Complete Method Reference

| Method | Description | Returns |
|--------|-------------|---------|
| `firstWhereOrNull(test)` | First element matching predicate | `T?` |
| `lastWhereOrNull(test)` | Last element matching predicate | `T?` |
| `singleWhereOrNull(test)` | Single element matching predicate | `T?` |
| `firstOrNull` | First element or null | `T?` |
| `lastOrNull` | Last element or null | `T?` |
| `singleOrNull` | Single element or null | `T?` |
| `elementAtOrNull(index)` | Element at index or null | `T?` |
| `groupBy(keySelector)` | Group elements by key | `Map<K, List<T>>` |
| `distinctBy(keySelector?)` | Distinct elements by key | `Iterable<T>` |
| `distinct` | Distinct elements | `Iterable<T>` |
| `chunked(size)` | Split into chunks | `Iterable<List<T>>` |
| `all(test)` | All elements match predicate | `bool` |
| `none(test)` | No elements match predicate | `bool` |
| `minOrNull` | Minimum element | `T?` |
| `maxOrNull` | Maximum element | `T?` |
| `minByOrNull(selector)` | Minimum by selector | `T?` |
| `maxByOrNull(selector)` | Maximum by selector | `T?` |
| `reversed` | Reversed iterable | `Iterable<T>` |
| `+(other)` | Concatenate iterables | `Iterable<T>` |
| `forEachIndexed(action)` | Iterate with index | `void` |
| `indexed` | Elements with indices | `Iterable<MapEntry<int, T>>` |
| `sum()` | Sum of elements (num only) | `T` |
| `sumOrNull` | Sum or null if empty | `T?` |
| `average` | Average of elements | `double?` |

## Performance Notes

- Most methods use lazy evaluation and don't materialize collections unnecessarily
- `reversed` materializes the iterable into a list first
- `chunked()` yields chunks as they're created
- Mathematical operations (`sum`, `average`) work only with numeric types

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.
