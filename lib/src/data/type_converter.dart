import 'dart:convert';

/// A comprehensive type converter utility that provides type-safe conversions.
///
/// Each type has two public methods:
/// 1. Nullable variant (e.g., `toBool`) - Returns null for invalid inputs
/// 2. Non-nullable variant (e.g., `toBoolValue`) - Returns a default value for invalid inputs
///
/// Example:
/// ```dart
/// // Nullable return
/// final optional = TypeConverter.toBool("abc"); // null
/// final valid = TypeConverter.toBool("true"); // true
///
/// // Non-nullable return with default
/// final flag = TypeConverter.toBoolValue("abc", defaultValue: false); // false
/// final checked = TypeConverter.toBoolValue("yes", defaultValue: false); // true
/// ```
class TypeConverter {
  // Private constructor to prevent instantiation
  TypeConverter._();

  // ============================================================================
  // BOOLEAN CONVERTERS
  // ============================================================================

  /// Private method containing the core boolean conversion logic.
  static bool? _convertToBool(dynamic value) {
    if (value == null) return null;

    if (value is bool) return value;

    if (value is num) return value != 0;

    if (value is String) {
      final lower = value.toLowerCase().trim();
      if (lower == 'true' || lower == 'yes' || lower == '1' || lower == 'on') {
        return true;
      }
      if (lower == 'false' || lower == 'no' || lower == '0' || lower == 'off') {
        return false;
      }
    }

    return null;
  }

  /// Converts any value to a nullable boolean.
  ///
  /// Returns `true` for: boolean true, "true", "yes", "1", "on", non-zero numbers
  /// Returns `false` for: boolean false, "false", "no", "0", "off", zero
  /// Returns `null` for: null or invalid inputs
  static bool? toBoolOrNull(dynamic value) => _convertToBool(value);

  /// Converts any value to a non-null boolean with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: false)
  static bool toBool(dynamic value, {bool defaultValue = false}) {
    return _convertToBool(value) ?? defaultValue;
  }

  // ============================================================================
  // INTEGER CONVERTERS
  // ============================================================================

  /// Private method containing the core integer conversion logic.
  static int? _convertToInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;

    if (value is double) return value.toInt();

    if (value is bool) return value ? 1 : 0;

    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;

      // Try parsing as double first, then convert to int
      final parsedDouble = double.tryParse(value.trim());
      if (parsedDouble != null) return parsedDouble.toInt();
    }

    return null;
  }

  /// Converts any value to a nullable integer.
  ///
  /// Handles: integers, doubles, booleans (true=1, false=0), numeric strings
  /// Returns `null` for: null or invalid inputs
  static int? toIntOrNull(dynamic value) => _convertToInt(value);

  /// Converts any value to a non-null integer with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: 0)
  static int toInt(dynamic value, {int defaultValue = 0}) {
    return _convertToInt(value) ?? defaultValue;
  }

  // ============================================================================
  // DOUBLE CONVERTERS
  // ============================================================================

  /// Private method containing the core double conversion logic.
  static double? _convertToDouble(dynamic value) {
    if (value == null) return null;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    if (value is bool) return value ? 1.0 : 0.0;

    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null) return parsed;
    }

    return null;
  }

  /// Converts any value to a nullable double.
  ///
  /// Handles: doubles, integers, booleans (true=1.0, false=0.0), numeric strings
  /// Returns `null` for: null or invalid inputs
  static double? toDoubleOrNull(dynamic value) => _convertToDouble(value);

  /// Converts any value to a non-null double with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: 0.0)
  static double toDouble(dynamic value, {double defaultValue = 0.0}) {
    return _convertToDouble(value) ?? defaultValue;
  }

  // ============================================================================
  // STRING CONVERTERS
  // ============================================================================

  /// Private method containing the core string conversion logic.
  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  /// Converts any value to a nullable string.
  ///
  /// Returns `null` for: null
  /// Returns toString() for: all other values
  static String? toStringOrNull(dynamic value) => _convertToString(value);

  /// Converts any value to a non-null string with a default value.
  ///
  /// [defaultValue]: Value to return if value is null (default: '')
  static String toStr(dynamic value, {String defaultValue = ''}) {
    return _convertToString(value) ?? defaultValue;
  }

  // ============================================================================
  // LIST CONVERTERS
  // ============================================================================

  /// Private method containing the core list conversion logic.
  static List<T>? _convertToList<T>(dynamic value) {
    if (value == null) return null;

    if (value is List<T>) return value;

    if (value is List) {
      try {
        return value.cast<T>();
      } catch (_) {
        return null;
      }
    }

    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded.cast<T>();
        }
      } catch (_) {
        // Not a valid JSON array
      }
    }

    // Try to wrap single value in a list
    try {
      return [value as T];
    } catch (_) {
      return null;
    }
  }

  /// Converts any value to a nullable List.
  ///
  /// Handles: Lists, JSON array strings, single values (wraps in list)
  /// Returns `null` for: null or invalid inputs
  static List<T>? toListOrNull<T>(dynamic value) => _convertToList<T>(value);

  /// Converts any value to a non-null List with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: [])
  static List<T> toList<T>(dynamic value, {List<T>? defaultValue}) {
    return _convertToList<T>(value) ?? defaultValue ?? <T>[];
  }

  // ============================================================================
  // MAP CONVERTERS
  // ============================================================================

  /// Private method containing the core map conversion logic.
  static Map<String, dynamic>? _convertToMap(dynamic value) {
    if (value == null) return null;

    if (value is Map<String, dynamic>) return value;

    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (_) {
        return null;
      }
    }

    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        // Not a valid JSON object
      }
    }

    return null;
  }

  /// Converts any value to a nullable Map.
  ///
  /// Handles: Maps, JSON object strings
  /// Returns `null` for: null or invalid inputs
  static Map<String, dynamic>? toMapOrNull(dynamic value) =>
      _convertToMap(value);

  /// Converts any value to a non-null Map with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: {})
  static Map<String, dynamic> toMap(
    dynamic value, {
    Map<String, dynamic>? defaultValue,
  }) {
    return _convertToMap(value) ?? defaultValue ?? <String, dynamic>{};
  }

  // ============================================================================
  // DATETIME CONVERTERS
  // ============================================================================

  /// Private method containing the core DateTime conversion logic.
  static DateTime? _convertToDateTime(dynamic value) {
    if (value == null) return null;

    if (value is DateTime) return value;

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }

    if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  /// Converts any value to a nullable DateTime.
  ///
  /// Handles: DateTime objects, ISO 8601 strings, Unix timestamps (milliseconds)
  /// Returns `null` for: null or invalid inputs
  static DateTime? toDateTimeOrNull(dynamic value) => _convertToDateTime(value);

  /// Converts any value to a non-null DateTime with a default value.
  ///
  /// [defaultValue]: Value to return if conversion fails (default: DateTime.now())
  static DateTime toDateTime(dynamic value, {DateTime? defaultValue}) {
    return _convertToDateTime(value) ?? defaultValue ?? DateTime.now();
  }
}
