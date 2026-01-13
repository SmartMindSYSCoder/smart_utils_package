/// A comprehensive collection of input validators for common form fields.
///
/// This class provides static methods that return validator functions
/// for use with Flutter's TextFormField.validator property.
class SmartInputValidators {
  SmartInputValidators._();

  /// Validates email addresses.
  ///
  /// [required]: Whether the field is required (default: true)
  /// [fieldName]: Custom field name for error messages (default: 'Email')
  /// [customErrorMessage]: Custom error message to override default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.email(
  ///     customErrorMessage: 'Please provide a valid email',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) email({
    bool required = true,
    String fieldName = 'Email',
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return required
            ? (customErrorMessage ?? '$fieldName is required')
            : null;
      }

      // Email regex pattern
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (!emailRegex.hasMatch(value.trim())) {
        return customErrorMessage ?? 'Please enter a valid email address';
      }

      return null;
    };
  }

  /// Validates person names.
  ///
  /// [required]: Whether the field is required (default: true)
  /// [fieldName]: Custom field name for error messages (default: 'Name')
  /// [minLength]: Minimum name length (default: 2)
  /// [customErrorMessage]: Custom error message to override default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.name(
  ///     customErrorMessage: 'Please enter your full name',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) name({
    bool required = true,
    String fieldName = 'Name',
    int minLength = 2,
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return required
            ? (customErrorMessage ?? '$fieldName is required')
            : null;
      }

      final trimmedValue = value.trim();

      if (trimmedValue.length < minLength) {
        return customErrorMessage ??
            '$fieldName must be at least $minLength characters';
      }

      // Allow letters (English and Arabic), spaces, hyphens, and apostrophes
      final nameRegex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s\-']+$");

      if (!nameRegex.hasMatch(trimmedValue)) {
        return customErrorMessage ??
            '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
      }

      return null;
    };
  }

  /// Validates mobile phone numbers.
  ///
  /// [required]: Whether the field is required (default: true)
  /// [fieldName]: Custom field name for error messages (default: 'Mobile number')
  /// [minLength]: Minimum number length (default: 10)
  /// [maxLength]: Maximum number length (default: 15)
  /// [customErrorMessage]: Custom error message to override default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.mobile(
  ///     customErrorMessage: 'Invalid phone number',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) mobile({
    bool required = true,
    String fieldName = 'Mobile number',
    int minLength = 10,
    int maxLength = 15,
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return required
            ? (customErrorMessage ?? '$fieldName is required')
            : null;
      }

      final trimmedValue = value.trim();

      // Check if contains only digits
      if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
        return customErrorMessage ?? '$fieldName must contain only digits';
      }

      if (trimmedValue.length < minLength) {
        return customErrorMessage ??
            '$fieldName must be at least $minLength digits';
      }

      if (trimmedValue.length > maxLength) {
        return customErrorMessage ??
            '$fieldName must not exceed $maxLength digits';
      }

      return null;
    };
  }

  /// Validates that a field is not empty.
  ///
  /// [fieldName]: Custom field name for error messages (default: 'This field')
  /// [customErrorMessage]: Custom error message to override default message
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.required(
  ///     'Username',
  ///     customErrorMessage: 'Username cannot be empty',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) required(
    String fieldName, {
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return customErrorMessage ?? '$fieldName is required';
      }
      return null;
    };
  }

  /// Validates that a field contains only numeric values.
  ///
  /// [required]: Whether the field is required (default: true)
  /// [fieldName]: Custom field name for error messages (default: 'This field')
  /// [allowDecimal]: Whether to allow decimal numbers (default: false)
  /// [customErrorMessage]: Custom error message to override default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.numeric(
  ///     customErrorMessage: 'Only numbers allowed',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) numeric({
    bool required = true,
    String fieldName = 'This field',
    bool allowDecimal = false,
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return required
            ? (customErrorMessage ?? '$fieldName is required')
            : null;
      }

      final trimmedValue = value.trim();

      if (allowDecimal) {
        // Allow decimal numbers
        if (!RegExp(r'^\d*\.?\d+$').hasMatch(trimmedValue)) {
          return customErrorMessage ?? '$fieldName must be a valid number';
        }
      } else {
        // Only integers
        if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
          return customErrorMessage ?? '$fieldName must contain only digits';
        }
      }

      return null;
    };
  }

  /// Validates password strength.
  ///
  /// [required]: Whether the field is required (default: true)
  /// [minLength]: Minimum password length (default: 4)
  /// [requireUppercase]: Require at least one uppercase letter (default: false)
  /// [requireLowercase]: Require at least one lowercase letter (default: false)
  /// [requireNumbers]: Require at least one number (default: false)
  /// [requireSpecialChars]: Require at least one special character (default: false)
  /// [customErrorMessage]: Custom error message to override all default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.password(
  ///     customErrorMessage: 'Password does not meet requirements',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) password({
    bool required = true,
    int minLength = 4,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireNumbers = false,
    bool requireSpecialChars = false,
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return required ? (customErrorMessage ?? 'Password is required') : null;
      }

      if (value.length < minLength) {
        return customErrorMessage ??
            'Password must be at least $minLength characters';
      }

      if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
        return customErrorMessage ??
            'Password must contain at least one uppercase letter';
      }

      if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
        return customErrorMessage ??
            'Password must contain at least one lowercase letter';
      }

      if (requireNumbers && !RegExp(r'[0-9]').hasMatch(value)) {
        return customErrorMessage ??
            'Password must contain at least one number';
      }

      if (requireSpecialChars &&
          !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return customErrorMessage ??
            'Password must contain at least one special character';
      }

      return null;
    };
  }

  /// Validates that two password fields match.
  ///
  /// [password]: The original password to compare against
  /// [customErrorMessage]: Custom error message to override default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: SmartInputValidators.confirmPassword(
  ///     _passwordController.text,
  ///     customErrorMessage: 'Passwords must be identical',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) confirmPassword(
    String password, {
    String? customErrorMessage,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return customErrorMessage ?? 'Please confirm your password';
      }

      if (value != password) {
        return customErrorMessage ?? 'Passwords do not match';
      }

      return null;
    };
  }

  /// Custom validator with flexible validation rules.
  ///
  /// Allows combining multiple validation rules in a single validator.
  ///
  /// [required]: Whether the field is required (default: false)
  /// [minLength]: Minimum length of the input
  /// [maxLength]: Maximum length of the input
  /// [pattern]: RegExp pattern that the input must match
  /// [isNumeric]: Whether the input must be numeric (default: false)
  /// [isEmail]: Whether the input must be a valid email (default: false)
  /// [isAlphabetic]: Whether the input must contain only letters (default: false)
  /// [customValidator]: Custom validation function for additional logic
  /// [fieldName]: Custom field name for error messages (default: 'This field')
  /// [customErrorMessage]: Custom error message to override all default messages
  ///
  /// Returns null if valid, error message if invalid.
  ///
  /// Example:
  /// ```dart
  /// // Numeric field with range
  /// TextFormField(
  ///   validator: SmartInputValidators.custom(
  ///     required: true,
  ///     isNumeric: true,
  ///     minLength: 1,
  ///     maxLength: 3,
  ///     fieldName: 'Age',
  ///   ),
  /// )
  ///
  /// // Email with custom validation
  /// TextFormField(
  ///   validator: SmartInputValidators.custom(
  ///     required: true,
  ///     isEmail: true,
  ///     customValidator: (value) {
  ///       if (value?.endsWith('@company.com') != true) {
  ///         return 'Must be a company email';
  ///       }
  ///       return null;
  ///     },
  ///   ),
  /// )
  ///
  /// // Pattern matching
  /// TextFormField(
  ///   validator: SmartInputValidators.custom(
  ///     pattern: RegExp(r'^[A-Z]{2}\d{4}$'),
  ///     customErrorMessage: 'Format must be: XX1234',
  ///   ),
  /// )
  /// ```
  static String? Function(String?) custom({
    bool required = false,
    int? minLength,
    int? maxLength,
    RegExp? pattern,
    bool isNumeric = false,
    bool isEmail = false,
    bool isAlphabetic = false,
    String? Function(String?)? customValidator,
    String fieldName = 'This field',
    String? customErrorMessage,
  }) {
    return (String? value) {
      // Check required
      if (value == null || value.trim().isEmpty) {
        return required
            ? (customErrorMessage ?? '$fieldName is required')
            : null;
      }

      final trimmedValue = value.trim();

      // Check min length
      if (minLength != null && trimmedValue.length < minLength) {
        return customErrorMessage ??
            '$fieldName must be at least $minLength characters';
      }

      // Check max length
      if (maxLength != null && trimmedValue.length > maxLength) {
        return customErrorMessage ??
            '$fieldName must not exceed $maxLength characters';
      }

      // Check numeric
      if (isNumeric && !RegExp(r'^\d+$').hasMatch(trimmedValue)) {
        return customErrorMessage ?? '$fieldName must contain only digits';
      }

      // Check email
      if (isEmail) {
        final emailRegex = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        );
        if (!emailRegex.hasMatch(trimmedValue)) {
          return customErrorMessage ?? 'Please enter a valid email address';
        }
      }

      // Check alphabetic
      if (isAlphabetic && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmedValue)) {
        return customErrorMessage ??
            '$fieldName must contain only letters and spaces';
      }

      // Check pattern
      if (pattern != null && !pattern.hasMatch(trimmedValue)) {
        return customErrorMessage ?? '$fieldName format is invalid';
      }

      // Run custom validator
      if (customValidator != null) {
        final customError = customValidator(value);
        if (customError != null) {
          return customErrorMessage ?? customError;
        }
      }

      return null;
    };
  }
}
