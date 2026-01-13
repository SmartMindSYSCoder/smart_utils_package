import 'package:intl/intl.dart' as intl;

/// A comprehensive number formatting utility that provides various number
/// formatting options including currency, percentage, compact notation, and more.
///
/// Example:
/// ```dart
/// // Currency formatting
/// final price = SmartNumberFormat.currency(1234.56); // "$1,234.56"
///
/// // Percentage
/// final percent = SmartNumberFormat.percentage(0.856); // "85.60%"
///
/// // Compact notation
/// final large = SmartNumberFormat.compact(1500000); // "1.5M"
///
/// // File size
/// final size = SmartNumberFormat.fileSize(1536000); // "1.46 MB"
/// ```
class SmartNumberFormat {
  // Private constructor to prevent instantiation
  SmartNumberFormat._();

  // ============================================================================
  // CURRENCY FORMATTING
  // ============================================================================

  /// Formats a number as currency with customizable options.
  ///
  /// [value]: The numeric value to format
  /// [symbol]: Currency symbol (default: '$')
  /// [decimalDigits]: Number of decimal places (default: 2)
  /// [locale]: Locale for formatting (default: 'en_US')
  /// [symbolPosition]: Position of currency symbol - 'before' or 'after' (default: 'before')
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.currency(1234.56); // "$1,234.56"
  /// SmartNumberFormat.currency(1234.56, symbol: '€', symbolPosition: 'after'); // "1,234.56€"
  /// ```
  static String currency(
    double value, {
    String symbol = '\$',
    int decimalDigits = 2,
    String locale = 'en_US',
    String symbolPosition = 'before',
  }) {
    final formatter = intl.NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );

    final formatted = formatter.format(value);

    if (symbolPosition == 'after') {
      return '$formatted$symbol';
    } else {
      return '$symbol$formatted';
    }
  }

  /// Formats a number as currency without the currency symbol.
  ///
  /// Useful for displaying amounts where the currency is already known.
  static String currencyWithoutSymbol(
    double value, {
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    final formatter = intl.NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );

    return formatter.format(value).trim();
  }

  // ============================================================================
  // PERCENTAGE FORMATTING
  // ============================================================================

  /// Formats a number as a percentage.
  ///
  /// [value]: The numeric value (0.0 to 1.0 for 0% to 100%)
  /// [decimalDigits]: Number of decimal places (default: 2)
  /// [showSymbol]: Whether to show the % symbol (default: true)
  /// [multiply100]: Whether to multiply by 100 (default: true, set false if value is already in 0-100 range)
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.percentage(0.856); // "85.60%"
  /// SmartNumberFormat.percentage(85.6, multiply100: false); // "85.60%"
  /// ```
  static String percentage(
    double value, {
    int decimalDigits = 2,
    bool showSymbol = true,
    bool multiply100 = true,
  }) {
    final actualValue = multiply100 ? value * 100 : value;
    final formatted = actualValue.toStringAsFixed(decimalDigits);

    return showSymbol ? '$formatted%' : formatted;
  }

  // ============================================================================
  // COMPACT NOTATION (K, M, B, T)
  // ============================================================================

  /// Formats a number in compact notation (1K, 1M, 1B, 1T).
  ///
  /// [value]: The numeric value to format
  /// [decimalDigits]: Number of decimal places (default: 1)
  /// [locale]: Locale for formatting (default: 'en_US')
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.compact(1500); // "1.5K"
  /// SmartNumberFormat.compact(1500000); // "1.5M"
  /// SmartNumberFormat.compact(1500000000); // "1.5B"
  /// ```
  static String compact(
    num value, {
    int decimalDigits = 1,
    String locale = 'en_US',
  }) {
    final formatter = intl.NumberFormat.compact(locale: locale);
    return formatter.format(value);
  }

  /// Formats a number in compact long notation (1 thousand, 1 million, etc.).
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.compactLong(1500); // "1.5 thousand"
  /// SmartNumberFormat.compactLong(1500000); // "1.5 million"
  /// ```
  static String compactLong(num value, {String locale = 'en_US'}) {
    final formatter = intl.NumberFormat.compactLong(locale: locale);
    return formatter.format(value);
  }

  // ============================================================================
  // FILE SIZE FORMATTING
  // ============================================================================

  /// Formats a byte count as a human-readable file size.
  ///
  /// [bytes]: The number of bytes
  /// [decimalDigits]: Number of decimal places (default: 2)
  /// [useBase1024]: Use 1024 as base (true) or 1000 (false) (default: true)
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.fileSize(1536); // "1.50 KB"
  /// SmartNumberFormat.fileSize(1536000); // "1.46 MB"
  /// SmartNumberFormat.fileSize(1536000000); // "1.43 GB"
  /// ```
  static String fileSize(
    int bytes, {
    int decimalDigits = 2,
    bool useBase1024 = true,
  }) {
    if (bytes < 0) return '0 B';

    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

    if (bytes == 0) return '0 B';

    final exp = (bytes.bitLength - 1) ~/ (useBase1024 ? 10 : 10);
    final unitIndex = exp.clamp(0, units.length - 1);

    final value = bytes / (1 << (unitIndex * 10));
    final formatted = value.toStringAsFixed(decimalDigits);

    return '$formatted ${units[unitIndex]}';
  }

  // ============================================================================
  // DECIMAL FORMATTING
  // ============================================================================

  /// Formats a number with specified decimal precision.
  ///
  /// [value]: The numeric value to format
  /// [decimalDigits]: Number of decimal places (default: 2)
  /// [removeTrailingZeros]: Remove trailing zeros (default: false)
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.decimal(123.456); // "123.46"
  /// SmartNumberFormat.decimal(123.400, removeTrailingZeros: true); // "123.4"
  /// ```
  static String decimal(
    double value, {
    int decimalDigits = 2,
    bool removeTrailingZeros = false,
  }) {
    final formatted = value.toStringAsFixed(decimalDigits);

    if (removeTrailingZeros) {
      return formatted.replaceAll(RegExp(r'\.?0+$'), '');
    }

    return formatted;
  }

  // ============================================================================
  // THOUSAND SEPARATOR
  // ============================================================================

  /// Formats a number with thousand separators.
  ///
  /// [value]: The numeric value to format
  /// [separator]: The separator character (default: ',')
  /// [decimalDigits]: Number of decimal places (default: 0)
  /// [locale]: Locale for formatting (default: 'en_US')
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.withSeparator(1234567); // "1,234,567"
  /// SmartNumberFormat.withSeparator(1234567.89, decimalDigits: 2); // "1,234,567.89"
  /// ```
  static String withSeparator(
    num value, {
    String separator = ',',
    int decimalDigits = 0,
    String locale = 'en_US',
  }) {
    final formatter = intl.NumberFormat.decimalPattern(locale);
    formatter.minimumFractionDigits = decimalDigits;
    formatter.maximumFractionDigits = decimalDigits;

    return formatter.format(value);
  }

  // ============================================================================
  // CUSTOM PATTERN
  // ============================================================================

  /// Formats a number using a custom pattern.
  ///
  /// [value]: The numeric value to format
  /// [pattern]: The format pattern (e.g., "#,##0.00", "000.0")
  /// [locale]: Locale for formatting (default: 'en_US')
  ///
  /// Pattern symbols:
  /// - `#`: Digit, zero shows as absent
  /// - `0`: Digit, zero shows as 0
  /// - `.`: Decimal separator
  /// - `,`: Grouping separator
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.custom(1234.5, "#,##0.00"); // "1,234.50"
  /// SmartNumberFormat.custom(5, "000"); // "005"
  /// ```
  static String custom(num value, String pattern, {String locale = 'en_US'}) {
    final formatter = intl.NumberFormat(pattern, locale);
    return formatter.format(value);
  }

  // ============================================================================
  // ORDINAL NUMBERS
  // ============================================================================

  /// Formats a number as an ordinal (1st, 2nd, 3rd, etc.).
  ///
  /// [value]: The numeric value to format
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.ordinal(1); // "1st"
  /// SmartNumberFormat.ordinal(22); // "22nd"
  /// SmartNumberFormat.ordinal(103); // "103rd"
  /// ```
  static String ordinal(int value) {
    if (value <= 0) return '${value}th';

    final lastTwoDigits = value % 100;
    final lastDigit = value % 10;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      return '${value}th';
    }

    switch (lastDigit) {
      case 1:
        return '${value}st';
      case 2:
        return '${value}nd';
      case 3:
        return '${value}rd';
      default:
        return '${value}th';
    }
  }

  // ============================================================================
  // PARSING
  // ============================================================================

  /// Parses a formatted string back to a number.
  ///
  /// Handles:
  /// - Currency symbols
  /// - Thousand separators
  /// - Percentage symbols
  ///
  /// [value]: The formatted string to parse
  ///
  /// Returns the parsed number or null if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.parseFormatted("$1,234.56"); // 1234.56
  /// SmartNumberFormat.parseFormatted("85.6%"); // 85.6
  /// ```
  static double? parseFormatted(String value) {
    if (value.isEmpty) return null;

    // Remove common formatting characters
    String cleaned = value
        .replaceAll(RegExp(r'[\$€£¥,\s]'), '')
        .replaceAll('%', '');

    return double.tryParse(cleaned);
  }

  // ============================================================================
  // RANGE FORMATTING
  // ============================================================================

  /// Formats a number range.
  ///
  /// [min]: The minimum value
  /// [max]: The maximum value
  /// [decimalDigits]: Number of decimal places (default: 0)
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.range(10, 20); // "10 - 20"
  /// SmartNumberFormat.range(10.5, 20.8, decimalDigits: 1); // "10.5 - 20.8"
  /// ```
  static String range(num min, num max, {int decimalDigits = 0}) {
    final minStr = decimalDigits > 0
        ? min.toStringAsFixed(decimalDigits)
        : min.toString();
    final maxStr = decimalDigits > 0
        ? max.toStringAsFixed(decimalDigits)
        : max.toString();

    return '$minStr - $maxStr';
  }

  // ============================================================================
  // SIGNED NUMBER
  // ============================================================================

  /// Formats a number with explicit sign (+ or -).
  ///
  /// [value]: The numeric value to format
  /// [decimalDigits]: Number of decimal places (default: 0)
  /// [showPlusSign]: Show + for positive numbers (default: true)
  ///
  /// Example:
  /// ```dart
  /// SmartNumberFormat.signed(5); // "+5"
  /// SmartNumberFormat.signed(-5); // "-5"
  /// SmartNumberFormat.signed(0); // "+0"
  /// ```
  static String signed(
    num value, {
    int decimalDigits = 0,
    bool showPlusSign = true,
  }) {
    final formatted = decimalDigits > 0
        ? value.toStringAsFixed(decimalDigits)
        : value.toString();

    if (value > 0 && showPlusSign) {
      return '+$formatted';
    }

    return formatted;
  }
}
