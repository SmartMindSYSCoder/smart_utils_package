/// A comprehensive enum converter utility that provides flexible enum conversions
/// with support for case-insensitive matching, display formatting, and bulk operations.
///
/// Example:
/// ```dart
/// enum UserStatus { active, inactive, pending }
///
/// // Case-insensitive conversion
/// final status = EnumConverter.fromString(
///   value: 'ACTIVE',
///   values: UserStatus.values,
///   defaultValue: UserStatus.inactive,
/// );
///
/// // Display name formatting
/// final display = EnumConverter.toDisplayName(UserStatus.active); // "Active"
///
/// // JSON value
/// final json = EnumConverter.toJsonValue(UserStatus.active); // "active"
/// ```
class EnumConverter {
  // Private constructor to prevent instantiation
  EnumConverter._();

  // ============================================================================
  // STRING TO ENUM CONVERSION
  // ============================================================================

  /// Converts a string to an enum value with flexible matching options.
  ///
  /// [value]: The string value to convert
  /// [values]: List of all possible enum values (e.g., UserStatus.values)
  /// [defaultValue]: The default value to return if no match is found
  /// [caseSensitive]: Whether the comparison should be case-sensitive (default: false)
  ///
  /// Returns the matching enum value or [defaultValue] if no match is found.
  static T fromString<T>({
    required String value,
    required List<T> values,
    required T defaultValue,
    bool caseSensitive = false,
  }) {
    final searchValue = caseSensitive ? value : value.toLowerCase();

    return values.firstWhere((e) {
      final enumName = e.toString().split('.').last;
      final compareValue = caseSensitive ? enumName : enumName.toLowerCase();
      return compareValue == searchValue;
    }, orElse: () => defaultValue);
  }

  /// Converts a string to a nullable enum value.
  ///
  /// Returns `null` if no match is found instead of a default value.
  static T? fromStringOrNull<T>({
    required String value,
    required List<T> values,
    bool caseSensitive = false,
  }) {
    final searchValue = caseSensitive ? value : value.toLowerCase();

    try {
      return values.firstWhere((e) {
        final enumName = e.toString().split('.').last;
        final compareValue = caseSensitive ? enumName : enumName.toLowerCase();
        return compareValue == searchValue;
      });
    } catch (_) {
      return null;
    }
  }

  // ============================================================================
  // ENUM TO STRING CONVERSION
  // ============================================================================

  /// Converts an enum to its short string representation.
  ///
  /// Example: UserStatus.active → "active"
  static String toShortString(Enum enumValue) {
    return enumValue.toString().split('.').last;
  }

  /// Converts an enum to a JSON-friendly lowercase string.
  ///
  /// Example: UserStatus.active → "active"
  static String toJsonValue(Enum enumValue) {
    return enumValue.toString().split('.').last.toLowerCase();
  }

  /// Converts an enum to a human-readable display name.
  ///
  /// Converts camelCase to Title Case with spaces.
  ///
  /// Examples:
  /// - UserStatus.active → "Active"
  /// - UserStatus.pendingApproval → "Pending Approval"
  /// - OrderStatus.shippedToCustomer → "Shipped To Customer"
  static String toDisplayName(Enum enumValue) {
    final name = enumValue.toString().split('.').last;
    return _camelCaseToTitleCase(name);
  }

  /// Converts an enum to a nullable display string.
  ///
  /// Returns `null` if the enum value is null.
  static String? toDisplayString<T>(T? enumValue) {
    if (enumValue == null) return null;
    return enumValue.toString().split('.').last;
  }

  // ============================================================================
  // BULK OPERATIONS
  // ============================================================================

  /// Converts a list of strings to a list of enum values.
  ///
  /// [values]: List of string values to convert
  /// [enumValues]: List of all possible enum values
  /// [defaultValue]: Default value for strings that don't match
  /// [caseSensitive]: Whether the comparison should be case-sensitive
  ///
  /// Returns a list of enum values, using [defaultValue] for unmatched strings.
  static List<T> fromStringList<T>({
    required List<String> values,
    required List<T> enumValues,
    required T defaultValue,
    bool caseSensitive = false,
  }) {
    return values
        .map(
          (value) => fromString<T>(
            value: value,
            values: enumValues,
            defaultValue: defaultValue,
            caseSensitive: caseSensitive,
          ),
        )
        .toList();
  }

  /// Converts a list of enum values to a list of short strings.
  ///
  /// Example: [UserStatus.active, UserStatus.inactive] → ["active", "inactive"]
  static List<String> toStringList(List<Enum> values) {
    return values.map((e) => toShortString(e)).toList();
  }

  /// Converts a list of enum values to a list of JSON values.
  ///
  /// Example: [UserStatus.active, UserStatus.inactive] → ["active", "inactive"]
  static List<String> toJsonList(List<Enum> values) {
    return values.map((e) => toJsonValue(e)).toList();
  }

  /// Converts a list of enum values to a list of display names.
  ///
  /// Example: [UserStatus.active, UserStatus.pendingApproval] → ["Active", "Pending Approval"]
  static List<String> toDisplayNameList(List<Enum> values) {
    return values.map((e) => toDisplayName(e)).toList();
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Converts camelCase string to Title Case with spaces.
  ///
  /// Examples:
  /// - "active" → "Active"
  /// - "pendingApproval" → "Pending Approval"
  /// - "shippedToCustomer" → "Shipped To Customer"
  static String _camelCaseToTitleCase(String input) {
    if (input.isEmpty) return input;

    // Insert space before uppercase letters
    final withSpaces = input.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    // Capitalize first letter and trim
    final trimmed = withSpaces.trim();
    if (trimmed.isEmpty) return trimmed;

    return trimmed[0].toUpperCase() + trimmed.substring(1);
  }

  /// Checks if a string matches any enum value.
  ///
  /// [value]: The string value to check
  /// [enumValues]: List of all possible enum values
  /// [caseSensitive]: Whether the comparison should be case-sensitive
  ///
  /// Returns `true` if a match is found, `false` otherwise.
  static bool isValidValue<T>({
    required String value,
    required List<T> enumValues,
    bool caseSensitive = false,
  }) {
    final searchValue = caseSensitive ? value : value.toLowerCase();

    return enumValues.any((e) {
      final enumName = e.toString().split('.').last;
      final compareValue = caseSensitive ? enumName : enumName.toLowerCase();
      return compareValue == searchValue;
    });
  }

  /// Gets all possible string values for an enum type.
  ///
  /// Example: getAllValues(UserStatus.values) → ["active", "inactive", "pending"]
  static List<String> getAllValues<T>(List<T> enumValues) {
    return enumValues.map((e) => e.toString().split('.').last).toList();
  }
}
