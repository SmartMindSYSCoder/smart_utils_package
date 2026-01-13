# Smart Utils Package - Example App

This example app demonstrates all the input formatters available in the `smart_utils_package`.

## Features Demonstrated

### Personal Information
- **Name Formatter**: Allows letters, spaces, hyphens, and apostrophes
- **Age Formatter**: Digits only, max 3 characters

### Contact Information
- **Mobile Number Formatter**: Digits only, max 15 characters (international standard)
- **Email Formatter**: Valid email format with no spaces

### Physical Measurements
- **Height Formatter**: Decimal numbers with max 2 decimal places (cm)
- **Weight Formatter**: Decimal numbers with max 2 decimal places (kg)

### Identification Documents
- **ID Number Formatter**: Must start with 1 or 2, digits only
- **Passport Formatter**: Alphanumeric, auto-converts to uppercase
- **Postal Code Formatter**: Alphanumeric with hyphens, auto-uppercase

### Payment Information
- **Credit Card Formatter**: Auto-formats with spaces (XXXX XXXX XXXX XXXX)
- **CVV Formatter**: 3-4 digits only
- **Currency Formatter**: Decimal with max 2 decimal places

### Account Information
- **Username Formatter**: Alphanumeric with underscore/hyphen, auto-lowercase
- **URL Formatter**: Valid URL characters, no spaces

### Date & Time
- **Date Formatter**: Auto-formats as DD/MM/YYYY
- **Time Formatter**: Auto-formats as HH:MM

### Other
- **Percentage Formatter**: 0-100 range with max 2 decimal places

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Usage in Your Project

To use these formatters in your own project:

```dart
import 'package:smart_utils_package/smart_utils_package.dart';

// In your TextField or TextFormField
TextField(
  inputFormatters: SmartInputFormatters.mobile(),
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(
    labelText: 'Mobile Number',
  ),
)
```

## Customization

Many formatters accept optional parameters for customization:

```dart
// Custom max length for mobile
SmartInputFormatters.mobile(maxLength: 10)

// Custom allowed start digits for ID number
SmartInputFormatters.idNumber(startDigits: [1, 2, 3])

// Custom max value for currency
SmartInputFormatters.currency(maxValue: 10000.0)
```

## Screenshots

The example app provides a comprehensive form with all input types organized in sections:
- Personal Information
- Contact Information
- Physical Measurements
- Identification Documents
- Payment Information
- Account Information
- Date & Time
- Other

Each field includes:
- Appropriate icon
- Clear label and hint text
- Description of the formatter behavior
- Clear button when text is entered
- Real-time formatting as you type
