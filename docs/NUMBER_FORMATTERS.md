# Number Formatters

Comprehensive utilities for formatting numbers, currency, file sizes, and more.

## Overview

The `SmartNumberFormat` class provides high-level formatting options for various numeric data types.

## Features

- **Currency**: Supports symbols, positioning, and custom locales.
- **Compact Notation**: Formats large numbers like 1.5K, 2M, 3B.
- **File Sizes**: Converts bytes to KB, MB, GB, etc.
- **Percentages**: Handles fraction-to-percent conversion.
- **Ordinals**: 1st, 2nd, 3rd, etc.

## Usage Examples

### Currency Formatting

```dart
// Default currency
SmartNumberFormat.currency(1234.56); 
// "$1,234.56"

// Custom Symbol & Position
SmartNumberFormat.currency(
  1234.56, 
  symbol: '€', 
  symbolPosition: 'after'
);
// "1,234.56€"

// Without Symbol
SmartNumberFormat.currencyWithoutSymbol(1234.56);
// "1,234.56"
```

### Compact Notation

Useful for social stats (views, likes) or dashboard metrics.

```dart
SmartNumberFormat.compact(1500);       // "1.5K"
SmartNumberFormat.compact(1500000);    // "1.5M"
SmartNumberFormat.compact(1500000000); // "1.5B"

// Long format
SmartNumberFormat.compactLong(1500000); // "1.5 million"
```

### File Sizes

Automatically chooses the appropriate unit.

```dart
SmartNumberFormat.fileSize(500);        // "500 B"
SmartNumberFormat.fileSize(1024);       // "1.00 KB"
SmartNumberFormat.fileSize(1500000);    // "1.43 MB"
SmartNumberFormat.fileSize(1073741824); // "1.00 GB"
```

### Percentages

```dart
// Standard percentage (multiplies by 100)
SmartNumberFormat.percentage(0.856); 
// "85.60%"

// Pre-calculated percentage
SmartNumberFormat.percentage(85.6, multiply100: false);
// "85.60%"
```

### Other Formatters

**Decimal Precision**
```dart
SmartNumberFormat.decimal(123.45678, decimalDigits: 2); // "123.46"
```

**Thousand Separator**
```dart
SmartNumberFormat.withSeparator(1000000); // "1,000,000"
```

**Ordinal Numbers**
```dart
SmartNumberFormat.ordinal(1);   // "1st"
SmartNumberFormat.ordinal(22);  // "22nd"
SmartNumberFormat.ordinal(33);  // "33rd"
SmartNumberFormat.ordinal(101); // "101st"
```

**Signed Numbers**
```dart
SmartNumberFormat.signed(42);  // "+42"
SmartNumberFormat.signed(-42); // "-42"
```

**Range**
```dart
SmartNumberFormat.range(10, 20); // "10 - 20"
```

## API Reference

| Method | Parameters | Description |
|--------|------------|-------------|
| `currency` | `value`, `symbol`, `decimalDigits`, `locale`, `symbolPosition` | Currency formatting |
| `currencyWithoutSymbol` | `value`, `decimalDigits`, `locale` | Currency without symbol |
| `percentage` | `value`, `decimalDigits`, `multiply100`, `locale` | Percentage formatting |
| `compact` | `value`, `decimalDigits`, `locale` | 1K, 1M, 1B format |
| `compactLong` | `value`, `decimalDigits`, `locale` | 1 thousand, 1 million format |
| `fileSize` | `bytes`, `decimalDigits`, `useBase1024` | File size (KB, MB, GB) |
| `decimal` | `value`, `decimalDigits`, `locale`, `removeTrailingZeros` | Raw decimal formatting |
| `withSeparator` | `value`, `decimalDigits`, `locale` | Adds thousand separators |
| `ordinal` | `value`, `locale` | Ordinal suffix (st, nd, rd, th) |
| `signed` | `value`, `decimalDigits` | Always shows sign (+/-) |
| `custom` | `value`, `pattern`, `locale` | Custom DateFormat pattern |
| `range` | `min`, `max`, `decimalDigits`, `locale` | Formats a range "min - max" |
| `parseFormatted` | `formattedString`, `locale` | Parses string back to num |

## See Also

- [Main README](../README.md)
