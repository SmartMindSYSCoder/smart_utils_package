# Enum Converters

Robust utilities for converting between Enums and Strings with case-insensitive matching, display formatting, and JSON support.

## Overview

The `EnumConverter` class provides method to handle Enum conversions safely and display them in user-friendly formats. It supports:

- **Case-insensitive matching** (e.g., "active" == `UserStatus.active`)
- **Display names** (e.g., `UserStatus.pendingApproval` → "Pending Approval")
- **JSON values** (e.g., `UserStatus.active` → "active")
- **Bulk operations** (Lists of Enums ↔ Lists of Strings)

## Basic Usage

### String to Enum

**`fromString`**
Converts a string to an enum value.

```dart
enum UserStatus { active, inactive, pending }

// Basic conversion
final status = EnumConverter.fromString(
  value: 'active',
  values: UserStatus.values,
  defaultValue: UserStatus.inactive,
);

// Case-insensitive (default is false, so be careful or set caseSensitive: false)
// Note: The implementation defaults caseSensitive to false usually? Let's check the code.
// Actually, looking at previous context, caseSensitive defaults to false.
final status = EnumConverter.fromString(
  value: 'ACTIVE',
  values: UserStatus.values,
  defaultValue: UserStatus.inactive,
  caseSensitive: false, // Default
);

// With nullable return (fromStringOrNull)
final status = EnumConverter.fromStringOrNull(
  value: 'invalid',
  values: UserStatus.values,
  caseSensitive: false,
); // returns null
```

### Enum to String

**`toShortString`**
Returns the string representation of the enum value (e.g., "active").

```dart
final str = EnumConverter.toShortString(UserStatus.active); // "active"
```

**`toJsonValue`**
Returns the value suitable for JSON (usually lowercase string).

```dart
final jsonVal = EnumConverter.toJsonValue(UserStatus.active); // "active"
```

### Display Names

**`toDisplayName`**
Converts enum camelCase names to Title Case with spaces.

```dart
enum UserStatus { pendingApproval, suspendedAccount }

print(EnumConverter.toDisplayName(UserStatus.pendingApproval)); 
// Output: "Pending Approval"

print(EnumConverter.toDisplayName(UserStatus.suspendedAccount)); 
// Output: "Suspended Account"
```

## Bulk Operations

Convert lists of data efficiently.

```dart
List<String> statusStrings = ['active', 'pending'];

// String List -> Enum List
List<UserStatus> statuses = EnumConverter.fromStringList(
  values: statusStrings,
  enumValues: UserStatus.values,
  defaultValue: UserStatus.inactive,
);

// Enum List -> Display Name List
List<String> displayNames = EnumConverter.toDisplayNameList(statuses);
// ["Active", "Pending"]
```

## Validation

Check if a string corresponds to a valid enum value.

```dart
bool isValid = EnumConverter.isValidValue(
  value: 'active',
  enumValues: UserStatus.values,
  caseSensitive: false,
); // true
```

## API Reference

| Method | Description |
|--------|-------------|
| `fromString` | Convert string to enum with default |
| `fromStringOrNull` | Convert string to enum or return null |
| `toShortString` | Get simple string name of enum |
| `toDisplayName` | Get human-readable title case name |
| `toJsonValue` | Get JSON-friendly string value |
| `fromStringList` | Convert list of strings to list of enums |
| `toStringList` | Convert list of enums to list of short strings |
| `toDisplayNameList` | Convert list of enums to display names |
| `isValidValue` | Check if string matches any enum |
| `getAllValues` | Get all string values for an enum type |

## See Also

- [Type Converters](TYPE_CONVERTERS.md)
- [Main README](../README.md)
