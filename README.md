# Smart Utils Package

A comprehensive Flutter utility package providing input formatters, validators, data converters, and formatting helpers for common development tasks.

## Features

### 🎯 Input Formatters
Comprehensive collection of input formatters for various field types:
- **Personal Info**: Name, Age
- **Contact**: Mobile, Email
- **Measurements**: Height, Weight (via vitalSign formatter)
- **Vital Signs**: Temperature, Blood Pressure, Heart Rate, SpO2, Glucose with dynamic configuration
- **Identification**: ID Number, Passport, Postal Code
- **Payment**: Credit Card, CVV, Currency
- **Account**: Username, URL, Password (free and secure)
- **Other**: Percentage, and more

### ✅ Input Validators
Comprehensive form validators with customizable error messages:
- **Field-Specific**: Email, Name, Mobile, Password
- **Standalone**: Required, Numeric
- **Flexible**: Custom validator with composable rules
- **Password Matching**: Confirm password validator

### 📊 Data Utilities
- **Enum Converter**: Convert between enums and their string representations
- **Model Parser**: Parse and convert JSON data to Dart models
- **Type Converter**: Handle type conversions safely

### 📅 Date & Time Helpers
- Format dates and times with ease
- Parse and manipulate date/time values

## Installation

Add this to your package's `pubspec.yaml` file:

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

## Usage

### Input Formatters

Import the package:
```dart
import 'package:smart_utils_package/smart_utils_package.dart';
```

#### Mobile Number Formatter
```dart
// Allow any starting digit (default)
TextField(
  inputFormatters: SmartInputFormatters.mobile(),
  keyboardType: TextInputType.phone,
)

// Only allow starting with 0 or 5
TextField(
  inputFormatters: SmartInputFormatters.mobile(startDigits: [0, 5]),
  keyboardType: TextInputType.phone,
)

// Saudi Arabia numbers (start with 5)
TextField(
  inputFormatters: SmartInputFormatters.mobile(startDigits: [5]),
  keyboardType: TextInputType.phone,
)
```

#### ID Number Formatter
```dart
// Default: must start with 1 or 2
TextField(
  inputFormatters: SmartInputFormatters.idNumber(),
  keyboardType: TextInputType.number,
)

// Allow any starting digit
TextField(
  inputFormatters: SmartInputFormatters.idNumber(startDigits: []),
  keyboardType: TextInputType.number,
)

// Custom start digits (e.g., 1, 2, or 3)
TextField(
  inputFormatters: SmartInputFormatters.idNumber(
    startDigits: [1, 2, 3],
    maxLength: 15,
  ),
  keyboardType: TextInputType.number,
)
```

#### Email Formatter
```dart
TextField(
  inputFormatters: SmartInputFormatters.email(maxLength: 50),
  keyboardType: TextInputType.emailAddress,
)
```

#### Name Formatter
```dart
TextField(
  inputFormatters: SmartInputFormatters.name(),
)
```
**Note:** Supports both Arabic and English letters.

#### Vital Signs Formatter (Dynamic)
```dart
// Temperature (max 2 digits before, 1 after decimal)
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    allowDecimal: true,
    maxDigitsBeforeDecimal: 2,
    maxDigitsAfterDecimal: 1,
    maxValue: 50.0,  // Realistic max temperature
  ),
)

// Blood Pressure - Systolic
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    minValue: 40,
    maxValue: 250,  // Realistic max systolic BP
    maxLength: 3,
  ),
)

// Heart Rate
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    maxValue: 250,  // Realistic max heart rate
    maxLength: 3,
  ),
)
```

#### Password Formatters
```dart
// Free password (no restrictions)
TextField(
  inputFormatters: SmartInputFormatters.password(maxLength: 50),
  obscureText: true,
)

// Secure password with requirements
TextField(
  inputFormatters: SmartInputFormatters.securePassword(
    requireUppercase: true,
    requireLowercase: true,
    requireNumbers: true,
    requireSpecialChars: true,
    minLength: 8,
  ),
  obscureText: true,
)
```

### Input Validators

#### Email Validator
```dart
TextFormField(
  validator: SmartInputValidators.email(
    required: true,
    customErrorMessage: 'Please provide a valid email',
  ),
)
```

#### Name Validator
```dart
TextFormField(
  validator: SmartInputValidators.name(
    required: true,
    minLength: 2,
  ),
)
```

#### Mobile Validator
```dart
TextFormField(
  validator: SmartInputValidators.mobile(
    required: true,
    minLength: 10,
    maxLength: 15,
  ),
)
```

#### Required Validator
```dart
TextFormField(
  validator: SmartInputValidators.required(
    'Username',
    customErrorMessage: 'Username cannot be empty',
  ),
)
```

#### Numeric Validator
```dart
TextFormField(
  validator: SmartInputValidators.numeric(
    required: true,
    allowDecimal: true,
  ),
)
```

#### Password Validator
```dart
TextFormField(
  validator: SmartInputValidators.password(
    required: true,
    minLength: 4,  // Default: 4
    requireUppercase: true,  // Default: false
    requireLowercase: true,  // Default: false
    requireNumbers: true,  // Default: false
    requireSpecialChars: true,  // Default: false
  ),
  obscureText: true,
)
```

#### Confirm Password Validator
```dart
TextFormField(
  validator: SmartInputValidators.confirmPassword(
    _passwordController.text,
    customErrorMessage: 'Passwords must match',
  ),
  obscureText: true,
)
```

#### Custom Validator (Flexible)
```dart
// Age field (numeric, 1-3 digits)
TextFormField(
  validator: SmartInputValidators.custom(
    required: true,
    isNumeric: true,
    minLength: 1,
    maxLength: 3,
    fieldName: 'Age',
  ),
)

// Company email only
TextFormField(
  validator: SmartInputValidators.custom(
    required: true,
    isEmail: true,
    customValidator: (value) {
      if (value?.endsWith('@company.com') != true) {
        return 'Must be a company email';
      }
      return null;
    },
  ),
)

// Pattern matching (e.g., license plate)
TextFormField(
  validator: SmartInputValidators.custom(
    pattern: RegExp(r'^[A-Z]{2}\d{4}$'),
    customErrorMessage: 'Format must be: XX1234',
  ),
)
```

**Custom Validator Rules:**
- `required` - Field is required
- `minLength` / `maxLength` - Length constraints
- `isNumeric` - Must contain only digits
- `isEmail` - Must be valid email format
- `isAlphabetic` - Must contain only letters
- `pattern` - Must match RegExp pattern
- `customValidator` - Custom validation function

### Available Input Formatters

| Formatter | Description | Key Parameters |
|-----------|-------------|----------------|
| `mobile()` | Mobile phone numbers | `maxLength` |
| `email()` | Email addresses | `maxLength` |
| `name()` | Person names | `maxLength` |
| `vitalSign()` | Vital signs/numeric | `allowDecimal`, `maxDigitsBeforeDecimal`, `maxDigitsAfterDecimal`, `minValue`, `maxValue` |
| `idNumber()` | National ID numbers | `startDigits`, `maxLength` |
| `passport()` | Passport numbers | `maxLength` |
| `password()` | Free password | `maxLength` |
| `securePassword()` | Secure password | `requireUppercase`, `requireLowercase`, `requireNumbers`, `requireSpecialChars`, `minLength` |
| `postalCode()` | Postal/ZIP codes | `maxLength` |
| `creditCard()` | Credit card numbers | None |
| `cvv()` | CVV/CVC codes | `maxLength` |
| `age()` | Age values | `maxLength` |
| `percentage()` | Percentage (0-100) | None |
| `currency()` | Money/currency | `maxValue` |
| `username()` | Usernames | `maxLength` |
| `url()` | URLs | `maxLength` |

### Available Input Validators

| Validator | Description | Key Parameters |
|-----------|-------------|----------------|
| `email()` | Email validation | `required`, `fieldName`, `customErrorMessage` |
| `name()` | Name validation | `required`, `minLength`, `customErrorMessage` |
| `mobile()` | Mobile validation | `required`, `minLength`, `maxLength`, `customErrorMessage` |
| `required()` | Required field | `fieldName`, `customErrorMessage` |
| `numeric()` | Numeric validation | `required`, `allowDecimal`, `customErrorMessage` |
| `password()` | Password strength | `minLength`, `requireUppercase`, `requireLowercase`, `requireNumbers`, `requireSpecialChars`, `customErrorMessage` |
| `confirmPassword()` | Password matching | `customErrorMessage` |
| `custom()` | Flexible validator | `required`, `minLength`, `maxLength`, `isNumeric`, `isEmail`, `isAlphabetic`, `pattern`, `customValidator` |

## Example App

Check out the `/example` folder for a comprehensive demo app showcasing all input formatters and validators with a beautiful UI.

To run the example:
```bash
cd example
flutter pub get
flutter run
```

## Additional Features

### Date & Time Helpers
```dart
// Use the date/time formatting utilities
// (Check the source code for available methods)
```

### Enum Converter
```dart
// Convert enums to/from strings
// (Check the source code for available methods)
```

### Model Parser
```dart
// Parse JSON to Dart models
// (Check the source code for available methods)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/SmartMind-New/smart_utils_package).
