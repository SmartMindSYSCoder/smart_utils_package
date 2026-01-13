# Type Converters

Type-safe conversion utilities with guaranteed non-null returns and nullable variants.

## Overview

The `TypeConverter` class provides robust type conversion methods that handle edge cases gracefully. Each type has two variants:

1. **Nullable** (`toIntOrNull`, `toBoolOrNull`, etc.) - Returns `null` for invalid inputs
2. **Non-nullable** (`toInt`, `toBool`, etc.) - Returns a default value for invalid inputs

## Architecture

All conversion logic is centralized in private methods to eliminate code duplication:

```dart
// Private method - contains all conversion logic
static bool? _convertToBool(dynamic value) {
  // ... conversion logic
}

// Public nullable - returns null for invalid
static bool? toBoolOrNull(dynamic value) => _convertToBool(value);

// Public non-nullable - returns default for invalid
static bool toBool(dynamic value, {bool defaultValue = false}) {
  return _convertToBool(value) ?? defaultValue;
}
```

## Boolean Conversion

### `toBoolOrNull(value)`

Converts any value to a nullable boolean.

**Returns `true` for:**
- Boolean `true`
- Strings: `"true"`, `"yes"`, `"1"`, `"on"` (case-insensitive)
- Numbers: any non-zero value

**Returns `false` for:**
- Boolean `false`
- Strings: `"false"`, `"no"`, `"0"`, `"off"` (case-insensitive)
- Numbers: `0`

**Returns `null` for:**
- `null` or any invalid input

```dart
TypeConverter.toBoolOrNull(true);      // true
TypeConverter.toBoolOrNull("yes");     // true
TypeConverter.toBoolOrNull(1);         // true
TypeConverter.toBoolOrNull("false");   // false
TypeConverter.toBoolOrNull(0);         // false
TypeConverter.toBoolOrNull("abc");     // null
TypeConverter.toBoolOrNull(null);      // null
```

### `toBool(value, {defaultValue})`

Converts any value to a non-null boolean with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `false`)

```dart
TypeConverter.toBool("yes");                           // true
TypeConverter.toBool("abc");                           // false (default)
TypeConverter.toBool("abc", defaultValue: true);       // true
TypeConverter.toBool(null, defaultValue: true);        // true
```

---

## Integer Conversion

### `toIntOrNull(value)`

Converts any value to a nullable integer.

**Handles:**
- Integers directly
- Doubles (truncates decimal part)
- Booleans (`true` = 1, `false` = 0)
- Numeric strings (`"123"` → `123`)
- Decimal strings (`"123.45"` → `123`)

```dart
TypeConverter.toIntOrNull(42);         // 42
TypeConverter.toIntOrNull(3.14);       // 3
TypeConverter.toIntOrNull(true);       // 1
TypeConverter.toIntOrNull(false);      // 0
TypeConverter.toIntOrNull("123");      // 123
TypeConverter.toIntOrNull("123.45");   // 123
TypeConverter.toIntOrNull("abc");      // null
TypeConverter.toIntOrNull(null);       // null
```

### `toInt(value, {defaultValue})`

Converts any value to a non-null integer with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `0`)

```dart
TypeConverter.toInt("123");                        // 123
TypeConverter.toInt("abc");                        // 0 (default)
TypeConverter.toInt("abc", defaultValue: -1);      // -1
TypeConverter.toInt(null, defaultValue: 100);      // 100
```

---

## Double Conversion

### `toDoubleOrNull(value)`

Converts any value to a nullable double.

**Handles:**
- Doubles directly
- Integers
- Booleans (`true` = 1.0, `false` = 0.0)
- Numeric strings (`"123.45"` → `123.45`)

```dart
TypeConverter.toDoubleOrNull(3.14);        // 3.14
TypeConverter.toDoubleOrNull(42);          // 42.0
TypeConverter.toDoubleOrNull(true);        // 1.0
TypeConverter.toDoubleOrNull("123.45");    // 123.45
TypeConverter.toDoubleOrNull("abc");       // null
```

### `toDouble(value, {defaultValue})`

Converts any value to a non-null double with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `0.0`)

```dart
TypeConverter.toDouble("3.14");                        // 3.14
TypeConverter.toDouble("abc");                         // 0.0 (default)
TypeConverter.toDouble("abc", defaultValue: -1.0);     // -1.0
```

---

## String Conversion

### `toStringOrNull(value)`

Converts any value to a nullable string.

**Returns:**
- `null` if value is `null`
- `toString()` for all other values

```dart
TypeConverter.toStringOrNull(123);         // "123"
TypeConverter.toStringOrNull(true);        // "true"
TypeConverter.toStringOrNull(3.14);        // "3.14"
TypeConverter.toStringOrNull(null);        // null
```

### `toStr(value, {defaultValue})`

Converts any value to a non-null string with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if value is null (default: `''`)

```dart
TypeConverter.toStr(123);                              // "123"
TypeConverter.toStr(null);                             // "" (default)
TypeConverter.toStr(null, defaultValue: "N/A");        // "N/A"
```

---

## List Conversion

### `toListOrNull<T>(value)`

Converts any value to a nullable List.

**Handles:**
- Lists directly
- JSON array strings (`'[1,2,3]'` → `[1,2,3]`)
- Single values (wraps in a list)

```dart
TypeConverter.toListOrNull<int>([1, 2, 3]);           // [1, 2, 3]
TypeConverter.toListOrNull<int>('[1,2,3]');           // [1, 2, 3]
TypeConverter.toListOrNull<String>('hello');          // ['hello']
TypeConverter.toListOrNull<int>('invalid');           // null
TypeConverter.toListOrNull<int>(null);                // null
```

### `toList<T>(value, {defaultValue})`

Converts any value to a non-null List with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `[]`)

```dart
TypeConverter.toList<int>([1, 2, 3]);                 // [1, 2, 3]
TypeConverter.toList<int>('invalid');                 // [] (default)
TypeConverter.toList<int>('invalid', defaultValue: [-1]); // [-1]
```

---

## Map Conversion

### `toMapOrNull(value)`

Converts any value to a nullable Map.

**Handles:**
- Maps directly
- JSON object strings (`'{"key":"value"}'` → `{key: value}`)

```dart
TypeConverter.toMapOrNull({'key': 'value'});          // {key: value}
TypeConverter.toMapOrNull('{"key":"value"}');         // {key: value}
TypeConverter.toMapOrNull('invalid');                 // null
TypeConverter.toMapOrNull(null);                      // null
```

### `toMap(value, {defaultValue})`

Converts any value to a non-null Map with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `{}`)

```dart
TypeConverter.toMap({'key': 'value'});                // {key: value}
TypeConverter.toMap('invalid');                       // {} (default)
TypeConverter.toMap('invalid', defaultValue: {'error': true}); // {error: true}
```

---

## DateTime Conversion

### `toDateTimeOrNull(value)`

Converts any value to a nullable DateTime.

**Handles:**
- DateTime objects directly
- ISO 8601 strings (`"2024-01-15T10:30:00.000Z"`)
- Unix timestamps in milliseconds

```dart
TypeConverter.toDateTimeOrNull(DateTime.now());       // DateTime object
TypeConverter.toDateTimeOrNull("2024-01-15");         // DateTime(2024, 1, 15)
TypeConverter.toDateTimeOrNull(1705315200000);        // DateTime from timestamp
TypeConverter.toDateTimeOrNull("invalid");            // null
TypeConverter.toDateTimeOrNull(null);                 // null
```

### `toDateTime(value, {defaultValue})`

Converts any value to a non-null DateTime with a default fallback.

**Parameters:**
- `value`: The value to convert
- `defaultValue`: Value to return if conversion fails (default: `DateTime.now()`)

```dart
TypeConverter.toDateTime("2024-01-15");               // DateTime(2024, 1, 15)
TypeConverter.toDateTime("invalid");                  // DateTime.now() (default)
TypeConverter.toDateTime("invalid", defaultValue: DateTime(2000, 1, 1)); // DateTime(2000, 1, 1)
```

---

## Best Practices

### 1. Use Nullable Variants for Optional Data

```dart
// Good - explicitly handles null case
final age = TypeConverter.toIntOrNull(userData['age']);
if (age != null) {
  print('Age: $age');
} else {
  print('Age not provided');
}
```

### 2. Use Non-Nullable Variants with Meaningful Defaults

```dart
// Good - provides sensible default
final retryCount = TypeConverter.toInt(
  config['retries'],
  defaultValue: 3,
);
```

### 3. Handle Edge Cases in API Responses

```dart
// API might return various types
final response = await api.getUserData();

final isActive = TypeConverter.toBool(
  response['is_active'],  // Could be bool, "true", 1, etc.
  defaultValue: false,
);

final score = TypeConverter.toDouble(
  response['score'],  // Could be int, double, string
  defaultValue: 0.0,
);
```

### 4. Use for JSON Parsing

```dart
class User {
  final int id;
  final String name;
  final bool isActive;
  final DateTime? createdAt;

  User.fromJson(Map<String, dynamic> json)
      : id = TypeConverter.toInt(json['id'], defaultValue: 0),
        name = TypeConverter.toStr(json['name'], defaultValue: 'Unknown'),
        isActive = TypeConverter.toBool(json['is_active'], defaultValue: false),
        createdAt = TypeConverter.toDateTimeOrNull(json['created_at']);
}
```

---

## Complete API Reference

| Method | Return Type | Default Value | Description |
|--------|-------------|---------------|-------------|
| `toBoolOrNull(value)` | `bool?` | - | Nullable boolean conversion |
| `toBool(value, {defaultValue})` | `bool` | `false` | Non-null boolean conversion |
| `toIntOrNull(value)` | `int?` | - | Nullable integer conversion |
| `toInt(value, {defaultValue})` | `int` | `0` | Non-null integer conversion |
| `toDoubleOrNull(value)` | `double?` | - | Nullable double conversion |
| `toDouble(value, {defaultValue})` | `double` | `0.0` | Non-null double conversion |
| `toStringOrNull(value)` | `String?` | - | Nullable string conversion |
| `toStr(value, {defaultValue})` | `String` | `''` | Non-null string conversion |
| `toListOrNull<T>(value)` | `List<T>?` | - | Nullable list conversion |
| `toList<T>(value, {defaultValue})` | `List<T>` | `[]` | Non-null list conversion |
| `toMapOrNull(value)` | `Map<String, dynamic>?` | - | Nullable map conversion |
| `toMap(value, {defaultValue})` | `Map<String, dynamic>` | `{}` | Non-null map conversion |
| `toDateTimeOrNull(value)` | `DateTime?` | - | Nullable DateTime conversion |
| `toDateTime(value, {defaultValue})` | `DateTime` | `DateTime.now()` | Non-null DateTime conversion |

---

## See Also

- [Enum Converters](ENUM_CONVERTERS.md) - Enum conversion utilities
- [Number Formatters](NUMBER_FORMATTERS.md) - Number formatting utilities
- [Main README](../README.md) - Package overview
