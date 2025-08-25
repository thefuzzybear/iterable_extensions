# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-08-25

### Added
- New extension method `indexOfOrNull(value)`  
  Returns the index of the first occurrence of a given value in the iterable, or `null` if the value is not found.

---

## [1.0.0] - 2025-08-23

### Added
- Initial release of iterable_extensions package
- Null-safe extension methods:
  - `firstWhereOrNull()`
  - `lastWhereOrNull()`
  - `singleWhereOrNull()`
  - `firstOrNull` getter
  - `lastOrNull` getter
  - `singleOrNull` getter
  - `elementAtOrNull()`
- Collection utility methods:
  - `groupBy()`
  - `distinctBy()` and `distinct` getter
  - `chunked()`
  - `reversed` getter
  - `+` operator for concatenation
- Functional programming helpers:
  - `all()` method (alias for `every()`)
  - `none()` method
  - `forEachIndexed()`
  - `indexed` getter
- Mathematical operations:
  - `sum()` and `sumOrNull` getter
  - `average` getter
  - `minOrNull` and `maxOrNull` getters
  - `minByOrNull()` and `maxByOrNull()`
- Comprehensive documentation with usage examples
- Full test coverage
- Example project demonstrating usage

### Changed
- N/A (initial release)

### Deprecated
- N/A (initial release)

### Removed
- N/A (initial release)

### Fixed
- N/A (initial release)

### Security
- N/A (initial release)