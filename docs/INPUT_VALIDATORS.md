# Input Validators Documentation

## Overview

The `SmartInputValidators` class provides a comprehensive set of form validators for common use cases. These validators are designed to be used with Flutter's `Form` and `TextFormField` widgets, supporting custom error messages and flexible configuration.

## Table of Contents

1. [Required Validator](#required-validator)
2. [Email Validator](#email-validator)
3. [Password Validators](#password-validators)
4. [Contact Validators](#contact-validators)
5. [Numeric Validators](#numeric-validators)
6. [Custom & Flexible Validators](#custom--flexible-validators)

---

## Required Validator

**Method:** `SmartInputValidators.required(String fieldName, {String? customErrorMessage})`

**Description:** Ensures a field is not empty.

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.required(
    'Username',
    customErrorMessage: 'Please enter your username',
  ),
)
```

---

## Email Validator

**Method:** `SmartInputValidators.email({bool required = true, String? fieldName, String? customErrorMessage})`

**Description:** Validates email format.

**Features:**
- Checks for standard email pattern
- Optional: Can be optional (only validates if not empty)

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.email(
    required: true,
    customErrorMessage: 'Invalid email address provided',
  ),
)
```

---

## Password Validators

### Standard Password

**Method:** `SmartInputValidators.password({bool required = true, int minLength = 4, bool requireUppercase = false, bool requireLowercase = false, bool requireNumbers = false, bool requireSpecialChars = false, String? customErrorMessage})`

**Description:** Checks password strength requirements.

**Features:**
- Minimum length check
- Complexity checks (uppercase, lowercase, numbers, special chars)

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.password(
    required: true,
    minLength: 8,
    requireUppercase: true,
    requireNumbers: true,
  ),
  obscureText: true,
)
```

### Confirm Password

**Method:** `SmartInputValidators.confirmPassword(String originalPassword, {String? customErrorMessage})`

**Description:** Validates that the input matches another password.

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.confirmPassword(
    _passwordController.text,
    customErrorMessage: 'Passwords do not match',
  ),
  obscureText: true,
)
```

---

## Contact Validators

### Mobile Validator

**Method:** `SmartInputValidators.mobile({bool required = true, int minLength = 9, int maxLength = 15, String? customErrorMessage})`

**Description:** Validates mobile number length and format (digits only).

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.mobile(
    required: true,
    minLength: 10,
    maxLength: 10,
  ),
)
```

### Name Validator

**Method:** `SmartInputValidators.name({bool required = true, int minLength = 2, String? customErrorMessage})`

**Description:** Validates that a name doesn't contain invalid characters (numbers, special symbols usually forbidden in simple names, though strictness depends on implementation).

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.name(
    required: true,
    minLength: 3,
  ),
)
```

---

## Numeric Validators

**Method:** `SmartInputValidators.numeric({bool required = true, bool allowDecimal = true, String? customErrorMessage})`

**Description:** Ensures the input is a valid number.

**Usage:**
```dart
TextFormField(
  validator: SmartInputValidators.numeric(
    required: true,
    allowDecimal: true, // Set to false for integers only
  ),
)
```

---

## Custom & Flexible Validators

### Custom Validator

**Method:** `SmartInputValidators.custom({bool required = false, bool isNumeric = false, bool isEmail = false, bool isAlphabetic = false, int? minLength, int? maxLength, RegExp? pattern, String? fieldName, String Function(String?)? customValidator, String? customErrorMessage})`

**Description:** A Swiss-army knife validator that combines multiple checks.

**Features:**
- Mix and match rules (required + numeric + length)
- Add regex patterns
- valid other built-in checks
- Add a custom callback function

**Usage:**
```dart
// Validation: Required, Numeric, 3 digits exactly
TextFormField(
  validator: SmartInputValidators.custom(
    required: true,
    isNumeric: true,
    minLength: 3,
    maxLength: 3,
    fieldName: 'CVV',
  ),
)

// Validation: Regex Pattern
TextFormField(
  validator: SmartInputValidators.custom(
    required: true,
    pattern: RegExp(r'^[A-Z]{3}\d{4}$'), // e.g., ABC1234
    customErrorMessage: 'Invalid format (Format: ABC1234)',
  ),
)

// Custom Logic Callback
TextFormField(
  validator: SmartInputValidators.custom(
    required: true,
    customValidator: (value) {
      if (value != 'MagicWord') {
        return 'Wrong secret word';
      }
      return null;
    },
  ),
)
```

---

## Best Practices

1. **User Feedback:** Always provide clear error messages.
2. **Real-time vs Submit:**
   - Use `autovalidateMode: AutovalidateMode.onUserInteraction` to give feedback as they type (or after focus loss).
3. **Consistency:** Use consistent rules across your app (e.g., all passwords must be 8+ chars).

```dart
TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: SmartInputValidators.email(),
  // ...
)
```

## See Also

- [Input Formatters](INPUT_FORMATTERS.md)
- [Main README](../README.md)
