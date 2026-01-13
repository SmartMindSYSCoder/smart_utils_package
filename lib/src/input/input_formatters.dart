import 'package:flutter/services.dart';

/// A comprehensive collection of input formatters for common form fields.
///
/// This class provides static methods that return lists of [TextInputFormatter]
/// for various input types like mobile numbers, emails, names, etc.
class SmartInputFormatters {
  SmartInputFormatters._();

  /// Returns formatters for mobile phone numbers.
  ///
  /// Formats:
  /// - Allows only digits
  /// - Maximum length: 15 digits (international standard)
  /// - Optional: Can restrict starting digits
  ///
  /// [maxLength]: Maximum length of mobile number (default: 15)
  /// [startDigits]: List of allowed starting digits (empty = allow any)
  ///
  /// Example: +1234567890
  static List<TextInputFormatter> mobile({
    int maxLength = 15,
    List<int> startDigits = const [],
  }) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
      if (startDigits.isNotEmpty)
        _IdNumberStartFormatter(allowedStartDigits: startDigits),
    ];
  }

  /// Returns formatters for email addresses.
  ///
  /// Formats:
  /// - Allows alphanumeric, @, ., -, _
  /// - Maximum length: 50 characters (default, customizable)
  /// - Prevents spaces
  ///
  /// [maxLength]: Maximum length of email (default: 50)
  static List<TextInputFormatter> email({int maxLength = 50}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-]')),
      LengthLimitingTextInputFormatter(maxLength),
      _NoSpaceFormatter(),
    ];
  }

  /// Returns formatters for person names.
  ///
  /// Formats:
  /// - Allows Arabic and English letters, spaces, hyphens, and apostrophes
  /// - Maximum length: 100 characters
  /// - Prevents multiple consecutive spaces
  ///
  /// Supports both Arabic (\u0600-\u06FF) and English (a-zA-Z) characters
  static List<TextInputFormatter> name({int maxLength = 100}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\u0600-\u06FF\s\-']")),
      LengthLimitingTextInputFormatter(maxLength),
      _SingleSpaceFormatter(),
    ];
  }

  /// Returns formatters for vital signs and numeric measurements.
  ///
  /// A dynamic formatter for numeric input fields with customizable constraints.
  ///
  /// [allowDecimal]: Whether to allow decimal values (default: false)
  /// [maxDigitsBeforeDecimal]: Maximum digits before decimal point (default: null - no limit)
  /// [maxDigitsAfterDecimal]: Maximum digits after decimal point (default: 2)
  /// [minValue]: Minimum allowed value
  /// [maxValue]: Maximum allowed value
  /// [maxLength]: Maximum total input length (default: 6)
  ///
  /// Example:
  /// ```dart
  /// // Temperature: max 2 digits before decimal, 1 after (e.g., 99.9)
  /// SmartInputFormatters.vitalSign(
  ///   allowDecimal: true,
  ///   maxDigitsBeforeDecimal: 2,
  ///   maxDigitsAfterDecimal: 1,
  ///   maxValue: 999.9,
  /// )
  ///
  /// // Heart rate: integer only (e.g., 999)
  /// SmartInputFormatters.vitalSign(maxValue: 999.0, maxLength: 3)
  ///
  /// // Weight: max 3 before, 2 after (e.g., 999.99)
  /// SmartInputFormatters.vitalSign(
  ///   allowDecimal: true,
  ///   maxDigitsBeforeDecimal: 3,
  ///   maxDigitsAfterDecimal: 2,
  /// )
  ///
  /// // Percentage (0-100)
  /// SmartInputFormatters.vitalSign(maxValue: 100.0, maxLength: 3)
  /// ```
  static List<TextInputFormatter> vitalSign({
    bool allowDecimal = false,
    int? maxDigitsBeforeDecimal,
    int maxDigitsAfterDecimal = 2,
    double? minValue,
    double? maxValue,
    int maxLength = 6,
  }) {
    final formatters = <TextInputFormatter>[];

    // Add appropriate input filter
    if (allowDecimal) {
      // For decimal values with digit restrictions
      formatters.add(
        _DecimalFormatter(
          maxDigitsBeforeDecimal: maxDigitsBeforeDecimal,
          maxDigitsAfterDecimal: maxDigitsAfterDecimal,
        ),
      );
    } else {
      // For integer values only
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    // Add length limiter
    formatters.add(LengthLimitingTextInputFormatter(maxLength));

    // Add range validators
    if (minValue != null || maxValue != null) {
      formatters.add(_RangeFormatter(minValue: minValue, maxValue: maxValue));
    }

    return formatters;
  }

  /// Returns formatters for ID numbers (National ID).
  ///
  /// Formats:
  /// - Must start with 1 or 2 (configurable)
  /// - Allows only digits
  /// - Maximum length: 20 digits (customizable)
  ///
  /// [startDigits]: List of allowed starting digits (default: [1, 2])
  /// [maxLength]: Maximum length of ID number (default: 20)
  static List<TextInputFormatter> idNumber({
    List<int> startDigits = const [1, 2],
    int maxLength = 20,
  }) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
      _IdNumberStartFormatter(allowedStartDigits: startDigits),
    ];
  }

  /// Returns formatters for passport numbers.
  ///
  /// Formats:
  /// - Allows alphanumeric characters only
  /// - Maximum length: 20 characters
  /// - Converts to uppercase
  static List<TextInputFormatter> passport({int maxLength = 20}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
      LengthLimitingTextInputFormatter(maxLength),
      UpperCaseTextFormatter(),
    ];
  }

  /// Returns formatters for password input (unrestricted).
  ///
  /// Formats:
  /// - No character restrictions
  /// - Maximum length: 50 characters (customizable)
  ///
  /// [maxLength]: Maximum length of password (default: 50)
  static List<TextInputFormatter> password({int maxLength = 50}) {
    return [LengthLimitingTextInputFormatter(maxLength)];
  }

  /// Returns formatters for secure password input with validation.
  ///
  /// Formats:
  /// - Validates password strength requirements in real-time
  /// - Customizable requirements for uppercase, lowercase, numbers, special chars
  /// - Min/max length constraints
  ///
  /// [requireUppercase]: Require at least one uppercase letter (default: true)
  /// [requireLowercase]: Require at least one lowercase letter (default: true)
  /// [requireNumbers]: Require at least one number (default: true)
  /// [requireSpecialChars]: Require at least one special character (default: true)
  /// [minLength]: Minimum password length (default: 8)
  /// [maxLength]: Maximum password length (default: 50)
  ///
  /// Example:
  /// ```dart
  /// // Strict password (all requirements)
  /// SmartInputFormatters.securePassword()
  ///
  /// // Relaxed password (only lowercase and numbers)
  /// SmartInputFormatters.securePassword(
  ///   requireUppercase: false,
  ///   requireSpecialChars: false,
  /// )
  /// ```
  static List<TextInputFormatter> securePassword({
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
    int minLength = 8,
    int maxLength = 50,
  }) {
    return [
      LengthLimitingTextInputFormatter(maxLength),
      _SecurePasswordFormatter(
        requireUppercase: requireUppercase,
        requireLowercase: requireLowercase,
        requireNumbers: requireNumbers,
        requireSpecialChars: requireSpecialChars,
        minLength: minLength,
      ),
    ];
  }

  /// Returns formatters for postal/zip codes.
  ///
  /// Formats:
  /// - Allows alphanumeric and hyphens
  /// - Maximum length: 10 characters
  static List<TextInputFormatter> postalCode({int maxLength = 10}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-]')),
      LengthLimitingTextInputFormatter(maxLength),
      UpperCaseTextFormatter(),
    ];
  }

  /// Returns formatters for credit card numbers.
  ///
  /// Formats:
  /// - Allows only digits
  /// - Maximum length: 16 digits
  /// - Auto-formats with spaces (XXXX XXXX XXXX XXXX)
  static List<TextInputFormatter> creditCard() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(16),
      _CreditCardFormatter(),
    ];
  }

  /// Returns formatters for CVV/CVC codes.
  ///
  /// Formats:
  /// - Allows only digits
  /// - Maximum length: 4 digits (for AMEX) or 3 digits (default)
  static List<TextInputFormatter> cvv({int maxLength = 3}) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  /// Returns formatters for age input.
  ///
  /// Formats:
  /// - Allows only digits
  /// - Maximum length: 3 digits (0-999)
  static List<TextInputFormatter> age({int maxLength = 3}) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  /// Returns formatters for percentage values.
  ///
  /// Formats:
  /// - Allows digits and one decimal point
  /// - Maximum value: 100
  /// - Maximum 2 decimal places
  static List<TextInputFormatter> percentage() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      LengthLimitingTextInputFormatter(6),
      _PercentageFormatter(),
    ];
  }

  /// Returns formatters for currency/money input.
  ///
  /// Formats:
  /// - Allows digits and one decimal point
  /// - Maximum 2 decimal places
  /// - Optional maximum value
  static List<TextInputFormatter> currency({double? maxValue}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      if (maxValue != null) _MaxValueFormatter(maxValue: maxValue),
      _DecimalFormatter(maxDigitsAfterDecimal: 2),
    ];
  }

  /// Returns formatters for username input.
  ///
  /// Formats:
  /// - Allows alphanumeric, underscore, and hyphen
  /// - No spaces
  /// - Maximum length: 30 characters
  /// - Converts to lowercase
  static List<TextInputFormatter> username({int maxLength = 30}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_\-]')),
      LengthLimitingTextInputFormatter(maxLength),
      LowerCaseTextFormatter(),
    ];
  }

  /// Returns formatters for URL input.
  ///
  /// Formats:
  /// - Allows alphanumeric and URL special characters
  /// - No spaces
  /// - Maximum length: 2048 characters
  static List<TextInputFormatter> url({int maxLength = 2048}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9:/.?=&_\-#]')),
      LengthLimitingTextInputFormatter(maxLength),
      _NoSpaceFormatter(),
    ];
  }
}

// ============================================================================
// Custom Formatters
// ============================================================================

/// Formatter that removes spaces from input
class _NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.contains(' ')) {
      return newValue;
    }

    final text = newValue.text.replaceAll(' ', '');

    // Calculate new selection
    int selectionIndex = newValue.selection.baseOffset;
    int spacesRemovedBeforeSelection = 0;

    for (int i = 0; i < selectionIndex; i++) {
      if (i < newValue.text.length && newValue.text[i] == ' ') {
        spacesRemovedBeforeSelection++;
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(
        offset: selectionIndex - spacesRemovedBeforeSelection,
      ),
    );
  }
}

/// Formatter that prevents multiple consecutive spaces
class _SingleSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    int selectionIndex = newValue.selection.baseOffset;

    // Let's iterate and build.
    final buffer = StringBuffer();
    int newSelection = selectionIndex;

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && text[i] == ' ' && text[i - 1] == ' ') {
        // This is a duplicate space
        if (i < selectionIndex) {
          newSelection--;
        }
      } else {
        buffer.write(text[i]);
      }
    }

    text = buffer.toString();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: newSelection),
    );
  }
}

/// Formatter for secure password validation
class _SecurePasswordFormatter extends TextInputFormatter {
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireNumbers;
  final bool requireSpecialChars;
  final int minLength;

  _SecurePasswordFormatter({
    required this.requireUppercase,
    required this.requireLowercase,
    required this.requireNumbers,
    required this.requireSpecialChars,
    required this.minLength,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Allow typing even if requirements aren't met yet
    // This formatter only blocks invalid characters, not incomplete passwords

    // Check for required character types
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(newValue.text)) {
      // Allow typing if we're still building the password
      if (newValue.text.length < minLength) {
        return newValue;
      }
    }

    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(newValue.text)) {
      if (newValue.text.length < minLength) {
        return newValue;
      }
    }

    if (requireNumbers && !RegExp(r'[0-9]').hasMatch(newValue.text)) {
      if (newValue.text.length < minLength) {
        return newValue;
      }
    }

    if (requireSpecialChars &&
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newValue.text)) {
      if (newValue.text.length < minLength) {
        return newValue;
      }
    }

    return newValue;
  }
}

/// Formatter that ensures ID number starts with specific digits
class _IdNumberStartFormatter extends TextInputFormatter {
  final List<int> allowedStartDigits;

  _IdNumberStartFormatter({required this.allowedStartDigits});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // If no start digits specified, allow any digit
    if (allowedStartDigits.isEmpty) {
      return newValue;
    }

    final firstDigit = int.tryParse(newValue.text[0]);
    if (firstDigit == null || !allowedStartDigits.contains(firstDigit)) {
      return oldValue;
    }

    return newValue;
  }
}

/// Formatter that converts text to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Formatter that converts text to lowercase
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

/// Formatter for decimal numbers with specified digit restrictions
class _DecimalFormatter extends TextInputFormatter {
  final int? maxDigitsBeforeDecimal;
  final int maxDigitsAfterDecimal;

  _DecimalFormatter({
    this.maxDigitsBeforeDecimal,
    required this.maxDigitsAfterDecimal,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Allow only digits and one decimal point
    if (!RegExp(r'^[\d.]*$').hasMatch(newValue.text)) {
      return oldValue;
    }

    // Count decimal points
    final decimalCount = '.'.allMatches(newValue.text).length;
    if (decimalCount > 1) {
      return oldValue;
    }

    // Check digit restrictions
    if (newValue.text.contains('.')) {
      final parts = newValue.text.split('.');

      // Check digits before decimal
      if (maxDigitsBeforeDecimal != null &&
          parts[0].length > maxDigitsBeforeDecimal!) {
        return oldValue;
      }

      // Check digits after decimal
      if (parts.length > 1 && parts[1].length > maxDigitsAfterDecimal) {
        return oldValue;
      }
    } else {
      // No decimal point yet, check digits before decimal
      if (maxDigitsBeforeDecimal != null &&
          newValue.text.length > maxDigitsBeforeDecimal!) {
        return oldValue;
      }
    }

    return newValue;
  }
}

/// Formatter for percentage values (0-100)
class _PercentageFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null || value > 100) {
      return oldValue;
    }

    return newValue;
  }
}

/// Formatter for maximum value constraint
class _MaxValueFormatter extends TextInputFormatter {
  final double maxValue;

  _MaxValueFormatter({required this.maxValue});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null || value > maxValue) {
      return oldValue;
    }

    return newValue;
  }
}

/// Formatter for credit card numbers (adds spaces every 4 digits)
class _CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(' ', '');
    // If it's just deleting a space, handle it specifically or let the logic handle it?
    // If we just stripped spaces, we lost cursor info relative to spaces.
    // But we are REBUILDING the string with spaces.

    // First, let's see where the cursor is relative to the *clean* text.
    // newValue has the raw text user typed (with spaces if they typed them, or without if they deleted).
    // Wait, newValue comes from the framework. If user typed a digit, it's there.

    // Let's map original cursor to "clean cursor" (index in text without spaces).
    int selectionIndex = newValue.selection.baseOffset;
    int cleanSelectionIndex = 0;

    for (int i = 0; i < selectionIndex; i++) {
      if (i < newValue.text.length && newValue.text[i] != ' ') {
        cleanSelectionIndex++;
      }
    }

    final buffer = StringBuffer();
    int newSelectionIndex = 0;

    // Rebuild with spaces
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
        if (i < cleanSelectionIndex) {
          // If the inserted space is BEFORE our cursor, shift cursor rights
          // This logic is tricky.
          // Let's count spaces added.
        }
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    // Calculate new cursor position based on cleanSelectionIndex
    // For every 4 chars in clean text, we add 1 space.
    // So newPos = cleanPos + (cleanPos / 4) ?

    newSelectionIndex =
        cleanSelectionIndex +
        (cleanSelectionIndex > 0 ? (cleanSelectionIndex - 1) ~/ 4 : 0);

    // Edge case handling if mapped index exceeds length
    if (newSelectionIndex > formatted.length) {
      newSelectionIndex = formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}

/// Formatter for range validation (min/max values)
class _RangeFormatter extends TextInputFormatter {
  final double? minValue;
  final double? maxValue;

  _RangeFormatter({this.minValue, this.maxValue});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Skip validation if text ends with decimal point
    if (newValue.text.endsWith('.')) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null) {
      return oldValue;
    }

    if (minValue != null && value < minValue!) {
      return oldValue;
    }

    if (maxValue != null && value > maxValue!) {
      return oldValue;
    }

    return newValue;
  }
}
