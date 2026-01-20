/// Extension to convert a country code string (ISO 3166-1 alpha-2) into its corresponding flag emoji.
///
/// This extension provides a convenient way to display country flags using
/// their two-letter country codes.
///
/// Example:
/// ```dart
/// String usFlag = 'US'.toFlag;  // 🇺🇸
/// String yemenFlag = 'YE'.toFlag;  // 🇾🇪
/// String saudiFlag = 'SA'.toFlag;  // 🇸🇦
/// ```
extension ConvertFlag on String {
  /// Converts the string to a flag emoji.
  ///
  /// Takes a two-letter country code (ISO 3166-1 alpha-2) and converts it
  /// to the corresponding flag emoji.
  ///
  /// **How it works:**
  /// This works by converting each letter of the country code into its
  /// corresponding Regional Indicator Symbol. The Regional Indicator Symbols
  /// are Unicode characters (U+1F1E6 to U+1F1FF) that combine to form flag emojis.
  ///
  /// **Examples:**
  /// ```dart
  /// 'US'.toFlag  // 🇺🇸 (United States)
  /// 'YE'.toFlag  // 🇾🇪 (Yemen)
  /// 'SA'.toFlag  // 🇸🇦 (Saudi Arabia)
  /// 'GB'.toFlag  // 🇬🇧 (United Kingdom)
  /// 'FR'.toFlag  // 🇫🇷 (France)
  /// 'DE'.toFlag  // 🇩🇪 (Germany)
  /// 'JP'.toFlag  // 🇯🇵 (Japan)
  /// 'CN'.toFlag  // 🇨🇳 (China)
  /// ```
  ///
  /// **Note:**
  /// - The country code must be a valid ISO 3166-1 alpha-2 code (2 letters)
  /// - Invalid codes will still produce output, but may not display as flags
  /// - Case-insensitive (automatically converts to uppercase)
  String get toFlag {
    return toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }

  /// Checks if the string is a valid ISO 3166-1 alpha-2 country code format.
  ///
  /// Returns `true` if the string is exactly 2 letters (A-Z, case-insensitive).
  ///
  /// Example:
  /// ```dart
  /// 'US'.isValidCountryCode  // true
  /// 'USA'.isValidCountryCode  // false (too long)
  /// 'U1'.isValidCountryCode  // false (contains number)
  /// ```
  @Deprecated('Use isValidCountryCodeFormat instead')
  bool get isValidCountryCode => isValidCountryCodeFormat;

  /// Checks if the string is a valid ISO 3166-1 alpha-2 country code format.
  ///
  /// Returns `true` if the string is exactly 2 letters (A-Z, case-insensitive).
  ///
  /// **Note:** This only validates the format, not whether the code actually
  /// exists in the ISO 3166-1 standard.
  ///
  /// Example:
  /// ```dart
  /// 'US'.isValidCountryCodeFormat  // true
  /// 'YE'.isValidCountryCodeFormat  // true
  /// 'USA'.isValidCountryCodeFormat  // false (too long)
  /// 'U1'.isValidCountryCodeFormat  // false (contains number)
  /// 'U'.isValidCountryCodeFormat  // false (too short)
  /// ```
  bool get isValidCountryCodeFormat {
    return RegExp(r'^[A-Za-z]{2}$').hasMatch(this);
  }
}
