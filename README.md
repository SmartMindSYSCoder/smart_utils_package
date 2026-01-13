# Smart Utils Package

A comprehensive Flutter utility package providing type-safe data converters, formatters, input validators, and helpers for common development tasks.

## 📚 Documentation

| Module | Description | Documentation |
|--------|-------------|---------------|
| **Type Converters** | Safe type conversion utilities | [📖 View Docs](docs/TYPE_CONVERTERS.md) |
| **Enum Converters** | Enum to/from string conversion | [📖 View Docs](docs/ENUM_CONVERTERS.md) |
| **Number Formatters** | Currency, percentage, file sizes, etc. | [📖 View Docs](docs/NUMBER_FORMATTERS.md) |
| **Date/Time Helpers** | Date formatting and manipulation | [📖 View Docs](docs/DATETIME_HELPERS.md) |
| **Input Formatters** | Text field input formatters | [📖 View Docs](docs/INPUT_FORMATTERS.md) |
| **Input Validators** | Form field validators | [📖 View Docs](docs/INPUT_VALIDATORS.md) |
| **Vital Signs** | Specialized medical formatters | [📖 View Docs](docs/VITAL_SIGNS_FORMATTER.md) |

## 🚀 Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  smart_utils_package:
    git:
      url: https://github.com/SmartMind-New/smart_utils_package.git
```

Then run:
```bash
flutter pub get
```

### Import

```dart
import 'package:smart_utils_package/smart_utils_package.dart';
```

## 📖 Quick Examples

### Type Converters

```dart
// Nullable conversion
final age = TypeConverter.toIntOrNull("25"); // 25
final invalid = TypeConverter.toIntOrNull("abc"); // null

// Non-nullable with default
final count = TypeConverter.toInt("abc", defaultValue: 0); // 0
final valid = TypeConverter.toInt("42", defaultValue: 0); // 42
```

### Enum Converters

```dart
enum UserStatus { active, inactive, pending }

// String to enum (case-insensitive)
final status = EnumConverter.fromString(
  value: 'ACTIVE',
  values: UserStatus.values,
  defaultValue: UserStatus.inactive,
);

// Enum to display name
final display = EnumConverter.toDisplayName(UserStatus.pending);
// Returns: "Pending"
```

### Number Formatters

```dart
// Currency
SmartNumberFormat.currency(1234.56); // "$1,234.56"

// Percentage
SmartNumberFormat.percentage(0.856); // "85.60%"

// Compact notation
SmartNumberFormat.compact(1500000); // "1.5M"

// File size
SmartNumberFormat.fileSize(1536000); // "1.46 MB"
```

### Input Formatters

```dart
TextField(
  inputFormatters: SmartInputFormatters.mobile(),
  keyboardType: TextInputType.phone,
)

TextField(
  inputFormatters: SmartInputFormatters.email(),
  keyboardType: TextInputType.emailAddress,
)
```

### Input Validators

```dart
TextFormField(
  validator: SmartInputValidators.email(required: true),
)

TextFormField(
  validator: SmartInputValidators.mobile(
    required: true,
    minLength: 10,
  ),
)
```

## 🎯 Features

### ✅ Type Safety
- Guaranteed non-null returns with sensible defaults
- Nullable variants for optional values
- Smart type conversion with edge case handling

### 🎨 Comprehensive Formatting
- Currency, percentage, compact notation
- File sizes, ordinal numbers, signed numbers
- Date/time formatting with multiple presets

### 📝 Input Management
- 15+ input formatters for common fields
- 8+ validators with customizable error messages
- Support for Arabic and English text

### 🔄 Data Conversion
- Type-safe enum conversion
- Case-insensitive matching
- Display name formatting (camelCase → Title Case)

## 📱 Example App

The package includes a comprehensive example app demonstrating all features:

```bash
cd example
flutter pub get
flutter run
```

The example app includes:
- **Type Converters Demo** - All conversion methods with examples
- **Enum Converters Demo** - Enum conversion showcase
- **Number Formatters Demo** - All number formatting options
- **Input Formatters Demo** - Interactive input field examples
- **Input Validators Demo** - Form validation examples

## 📋 API Reference

### Type Converters

| Method | Return Type | Description |
|--------|-------------|-------------|
| `toBoolOrNull(value)` | `bool?` | Convert to nullable bool |
| `toBool(value, {defaultValue})` | `bool` | Convert to bool with default |
| `toIntOrNull(value)` | `int?` | Convert to nullable int |
| `toInt(value, {defaultValue})` | `int` | Convert to int with default |
| `toDoubleOrNull(value)` | `double?` | Convert to nullable double |
| `toDouble(value, {defaultValue})` | `double` | Convert to double with default |
| `toStringOrNull(value)` | `String?` | Convert to nullable string |
| `toStr(value, {defaultValue})` | `String` | Convert to string with default |
| `toListOrNull<T>(value)` | `List<T>?` | Convert to nullable list |
| `toList<T>(value, {defaultValue})` | `List<T>` | Convert to list with default |
| `toMapOrNull(value)` | `Map?` | Convert to nullable map |
| `toMap(value, {defaultValue})` | `Map` | Convert to map with default |
| `toDateTimeOrNull(value)` | `DateTime?` | Convert to nullable DateTime |
| `toDateTime(value, {defaultValue})` | `DateTime` | Convert to DateTime with default |

### Number Formatters

| Method | Description | Example Output |
|--------|-------------|----------------|
| `currency(value)` | Format as currency | "$1,234.56" |
| `percentage(value)` | Format as percentage | "85.60%" |
| `compact(value)` | Compact notation | "1.5M" |
| `fileSize(bytes)` | File size | "1.46 MB" |
| `decimal(value)` | Decimal formatting | "123.46" |
| `withSeparator(value)` | Thousand separator | "1,234,567" |
| `ordinal(value)` | Ordinal numbers | "1st", "2nd" |
| `signed(value)` | Signed numbers | "+5", "-3" |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Links

- [GitHub Repository](https://github.com/SmartMind-New/smart_utils_package)
- [Issue Tracker](https://github.com/SmartMind-New/smart_utils_package/issues)
- [Changelog](CHANGELOG.md)

## 💡 Support

For questions, issues, or feature requests, please visit our [GitHub repository](https://github.com/SmartMind-New/smart_utils_package).
