/// General converter for enums using reflection
class EnumConverter {
  // Private constructor to prevent instantiation
  EnumConverter._();

  static T fromString<T>(
      {required String value,
      required List<T> values,
      required T defaultValue}) {
    return values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => defaultValue,
    );
  }

  // Convert Enum to String
  static String toShortString(Enum enumValue) {
    return enumValue.toString().split('.').last;
  }

  /// Convert any Enum to String representation (e.g., 'single', 'married')
  static String? toDisplayString<T>(T enumValue) {
    return enumValue.toString().split('.').last;
  }
}
