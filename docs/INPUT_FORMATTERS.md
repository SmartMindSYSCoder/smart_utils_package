# Input Formatters Documentation

## Overview

The `SmartInputFormatters` class provides a comprehensive collection of static methods that return `TextInputFormatter` lists for various common input field types. These formatters help ensure data integrity and improve user experience by automatically formatting and validating input as users type.

## Table of Contents

1. [Personal Information](#personal-information)
2. [Contact Information](#contact-information)
3. [Physical Measurements](#physical-measurements)
4. [Identification Documents](#identification-documents)
5. [Payment Information](#payment-information)
6. [Account Information](#account-information)
7. [Password & Security](#password--security)
8. [Date & Time](#date--time)
9. [Other Formatters](#other-formatters)
10. [Custom Formatters](#custom-formatters)

---

## Personal Information

### Name Formatter

**Method:** `SmartInputFormatters.name({int maxLength = 100})`

**Description:** Formats person names by allowing Arabic and English letters, spaces, hyphens, and apostrophes.

**Features:**
- Allows: Arabic letters (\u0600-\u06FF), English letters (a-z, A-Z), spaces, hyphens (-), apostrophes (')
- Prevents multiple consecutive spaces
- Default max length: 100 characters
- Supports bilingual input (Arabic and English)

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.name(),
  decoration: InputDecoration(labelText: 'Full Name'),
)

// Custom max length
TextField(
  inputFormatters: SmartInputFormatters.name(maxLength: 50),
)
```

**Examples:**
- ✅ "John Doe"
- ✅ "Mary-Jane O'Connor"
- ✅ "محمد أحمد" (Arabic)
- ✅ "José García"
- ✅ "Ahmed Al-Sayed" (Mixed)
- ❌ "John123" (numbers not allowed)
- ❌ "John@Doe" (special characters not allowed)

---

### Age Formatter

**Method:** `SmartInputFormatters.age({int maxLength = 3})`

**Description:** Formats age input by allowing only digits.

**Features:**
- Allows: Digits only (0-9)
- Default max length: 3 characters (0-999)

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.age(),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Age'),
)
```

---

## Contact Information

### Mobile Number Formatter

**Method:** `SmartInputFormatters.mobile({int maxLength = 15})`

**Description:** Formats mobile phone numbers according to international standards.

**Features:**
- Allows: Digits only (0-9)
- Default max length: 15 digits (E.164 international standard)
- Customizable max length

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.mobile(),
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(labelText: 'Mobile Number'),
)

// Custom length for specific country
TextField(
  inputFormatters: SmartInputFormatters.mobile(maxLength: 10),
)
```

**Examples:**
- ✅ "1234567890"
- ✅ "966501234567" (Saudi Arabia)
- ❌ "123-456-7890" (hyphens not allowed)

---

### Email Formatter

**Method:** `SmartInputFormatters.email({int maxLength = 50})`

**Description:** Formats email addresses by allowing valid email characters.

**Features:**
- Allows: Alphanumeric, @, ., -, _
- Prevents spaces
- Default max length: 50 characters (customizable)

**Usage:**
```dart
// Default max length: 50
TextField(
  inputFormatters: SmartInputFormatters.email(),
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
)

// Custom max length
TextField(
  inputFormatters: SmartInputFormatters.email(maxLength: 100),
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
)
```

**Examples:**
- ✅ "user@example.com"
- ✅ "john.doe@company.co.uk"
- ❌ "user @example.com" (spaces not allowed)

---

## Physical Measurements

### Height Formatter

**Method:** `SmartInputFormatters.height()`

**Description:** Formats height input in centimeters with decimal support.

**Features:**
- Allows: Digits and one decimal point
- Max 2 decimal places
- Max length: 6 characters (e.g., 999.99)
- Range: 0-999.99 cm

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.height(),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: 'Height (cm)',
    hintText: '175.5',
  ),
)
```

**Examples:**
- ✅ "175"
- ✅ "175.5"
- ✅ "175.50"
- ❌ "175.555" (max 2 decimal places)

---

### Weight Formatter

**Method:** `SmartInputFormatters.weight()`

**Description:** Formats weight input in kilograms with decimal support.

**Features:**
- Allows: Digits and one decimal point
- Max 2 decimal places
- Max length: 6 characters (e.g., 999.99)
- Range: 0-999.99 kg

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.weight(),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: 'Weight (kg)',
    hintText: '70.5',
  ),
)
```

---

## Identification Documents

### ID Number Formatter

**Method:** `SmartInputFormatters.idNumber({List<int> startDigits = const [1, 2], int maxLength = 20})`

**Description:** Formats national ID numbers with customizable starting digit requirements.

**Features:**
- Must start with specified digits (default: 1 or 2)
- Allows: Digits only
- Default max length: 20 digits
- Customizable start digits and max length

**Usage:**
```dart
// Default: must start with 1 or 2
TextField(
  inputFormatters: SmartInputFormatters.idNumber(),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'National ID'),
)

// Custom start digits
TextField(
  inputFormatters: SmartInputFormatters.idNumber(
    startDigits: [1, 2, 3],
    maxLength: 15,
  ),
)
```

**Examples:**
- ✅ "1234567890" (starts with 1)
- ✅ "2987654321" (starts with 2)
- ❌ "3234567890" (doesn't start with 1 or 2)

---

### Passport Formatter

**Method:** `SmartInputFormatters.passport({int maxLength = 20})`

**Description:** Formats passport numbers with automatic uppercase conversion.

**Features:**
- Allows: Alphanumeric characters only
- Auto-converts to uppercase
- Default max length: 20 characters

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.passport(),
  decoration: InputDecoration(labelText: 'Passport Number'),
)
```

**Examples:**
- Input: "ab1234567" → Output: "AB1234567"
- ✅ "AB1234567"
- ❌ "AB-1234567" (hyphens not allowed)

---

### Postal Code Formatter

**Method:** `SmartInputFormatters.postalCode({int maxLength = 10})`

**Description:** Formats postal/ZIP codes with automatic uppercase conversion.

**Features:**
- Allows: Alphanumeric and hyphens
- Auto-converts to uppercase
- Default max length: 10 characters

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.postalCode(),
  decoration: InputDecoration(labelText: 'Postal Code'),
)
```

**Examples:**
- Input: "12345" → Output: "12345"
- Input: "sw1a-1aa" → Output: "SW1A-1AA"

---

## Payment Information

### Credit Card Formatter

**Method:** `SmartInputFormatters.creditCard()`

**Description:** Formats credit card numbers with automatic spacing.

**Features:**
- Allows: Digits only
- Max length: 16 digits
- Auto-formats with spaces (XXXX XXXX XXXX XXXX)

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.creditCard(),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Credit Card Number'),
)
```

**Examples:**
- Input: "1234567890123456" → Output: "1234 5678 9012 3456"

---

### CVV Formatter

**Method:** `SmartInputFormatters.cvv({int maxLength = 3})`

**Description:** Formats CVV/CVC security codes.

**Features:**
- Allows: Digits only
- Default max length: 3 digits (4 for AMEX)

**Usage:**
```dart
// Standard CVV (3 digits)
TextField(
  inputFormatters: SmartInputFormatters.cvv(),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'CVV'),
)

// AMEX CVV (4 digits)
TextField(
  inputFormatters: SmartInputFormatters.cvv(maxLength: 4),
)
```

---

### Currency Formatter

**Method:** `SmartInputFormatters.currency({double? maxValue})`

**Description:** Formats currency/money values with decimal support.

**Features:**
- Allows: Digits and one decimal point
- Max 2 decimal places
- Optional maximum value constraint

**Usage:**
```dart
// No max value
TextField(
  inputFormatters: SmartInputFormatters.currency(),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(labelText: 'Amount'),
)

// With max value
TextField(
  inputFormatters: SmartInputFormatters.currency(maxValue: 10000.0),
)
```

**Examples:**
- ✅ "99.99"
- ✅ "1000.50"
- ❌ "99.999" (max 2 decimal places)

---

## Account Information

### Username Formatter

**Method:** `SmartInputFormatters.username({int maxLength = 30})`

**Description:** Formats usernames with automatic lowercase conversion.

**Features:**
- Allows: Alphanumeric, underscore (_), hyphen (-)
- No spaces
- Auto-converts to lowercase
- Default max length: 30 characters

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.username(),
  decoration: InputDecoration(labelText: 'Username'),
)
```

**Examples:**
- Input: "John_Doe" → Output: "john_doe"
- ✅ "john_doe"
- ✅ "user-123"
- ❌ "john doe" (spaces not allowed)

---

### URL Formatter

**Method:** `SmartInputFormatters.url({int maxLength = 2048})`

**Description:** Formats URLs by allowing valid URL characters.

**Features:**
- Allows: Alphanumeric and URL special characters (:/?.=&_-#)
- No spaces
- Default max length: 2048 characters

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.url(),
  keyboardType: TextInputType.url,
  decoration: InputDecoration(labelText: 'Website URL'),
)
```

**Examples:**
- ✅ "https://example.com"
- ✅ "https://example.com/path?query=value"
440: - ❌ "https://example .com" (spaces not allowed)
441: 
442: ---
443: 
444: ## Password & Security
445: 
446: ### Password Formatter
447: 
448: **Method:** `SmartInputFormatters.password({...})`
449: 
450: **Description:** A unified formatter for all password scenarios (Basic, Strict, and Secure).
451: 
452: **Features:**
453: - **strict**: If `true`, allows ONLY English letters, numbers, and ASCII special characters.
454: - **allowSpaces**: If `true`, allows spaces. Defaults to `false`.
455: - **Validation**: Optional complexity requirements (uppercase, lowercase, numbers, specials).
456: - **Length**: Configurable min/max length.
457: 
458: **Usage:**
459: ```dart
460: // Basic (Length limit, No spaces)
461: SmartInputFormatters.password()
462: 
463: // Secure (Enforce complexity)
464: SmartInputFormatters.password(
465:   requireUppercase: true,
466:   requireNumbers: true,
467:   requireSpecialChars: true,
468: )
469: 
470: // Strict Mode (ASCII only, no languages/emoji)
471: SmartInputFormatters.password(strict: true)
472: ```
473: 
474: ### Configuration Guide
475: 
476: Use this table to configure `password()` for your needs:
477: 
478: | Use Case | Configuration |
479: | :--- | :--- |
480: | **Basic Password** | `password()` |
481: | **Allow Spaces** | `password(allowSpaces: true)` |
482: | **Strict (No Unicode)** | `password(strict: true)` |
483: | **Secure (Complexity)** | `password(requireUppercase: true, ...)` |
508: 
509: ### Compare Password Formatters
499: 
500: Use this guide to choose the right formatter for your security needs:
501: 
502: | Feature | Standard `password()` | Strict `strictPassword()` | Secure `securePassword()` |
503: | :--- | :---: | :---: | :---: |
504: | **Allows English Letters** | ✅ | ✅ | ✅ |
505: | **Allows Numbers** | ✅ | ✅ | ✅ |
506: | **Allows Special Char** | ✅ | ✅ | ✅ |
507: | **Allows Spaces** | ✅ | ❌ **Blocked** | ❌ **Blocked** |
508: | **Allows Arabic/Other** | ✅ | ❌ **Blocked** | ✅ |
509: | **Allows Emoji** | ✅ | ❌ **Blocked** | ✅ |
510: | **Primary Use Case** | Basic Input | Legacy Systems / Strict IT Policy | Complexity Validation |

### Core Difference

The main distinction between **Strict** and **Secure** password formatters lies in their approach to allowed characters:

- **Strict Password (`strictPassword`)**: Uses an **Allowlist** approach. It strictly permits *only* standard English letters, numbers, and ASCII special characters. It automatically invalidates/strips any other character (like Arabic letters, Emojis, or invisible unicode characters). Use this when your backend or auth system cannot handle Unicode characters.

- **Secure Password (`securePassword`)**: Uses a **Validation** approach. It allows a broader range of characters (including Unicode/Emoji) to support stronger, more personal passwords, but enforces complexity rules (must have uppercase, number, etc.) to ensure strength. It specifically **blocks spaces** to prevent common whitespace errors, but otherwise gives users more freedom.
511: 
512: ---



## Other Formatters

### Percentage Formatter

**Method:** `SmartInputFormatters.percentage()`

**Description:** Formats percentage values with range validation.

**Features:**
- Allows: Digits and one decimal point
- Range: 0-100
- Max 2 decimal places
- Max length: 6 characters

**Usage:**
```dart
TextField(
  inputFormatters: SmartInputFormatters.percentage(),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: 'Percentage',
    hintText: '75.5',
  ),
)
```

**Examples:**
- ✅ "75"
- ✅ "75.5"
- ✅ "100"
- ❌ "101" (exceeds 100)

---

## Custom Formatters

The package also includes several reusable custom formatters that you can use independently:

### UpperCaseTextFormatter

Converts all input to uppercase.

```dart
TextField(
  inputFormatters: [UpperCaseTextFormatter()],
)
```

### LowerCaseTextFormatter

Converts all input to lowercase.

```dart
TextField(
  inputFormatters: [LowerCaseTextFormatter()],
)
```

---

## Best Practices

1. **Combine with Validation**: Input formatters prevent invalid input, but always validate on submission:
   ```dart
   TextFormField(
     inputFormatters: SmartInputFormatters.email(),
     validator: (value) {
       if (value == null || value.isEmpty) {
         return 'Email is required';
       }
       if (!value.contains('@')) {
         return 'Invalid email format';
       }
       return null;
     },
   )
   ```

2. **Set Appropriate Keyboard Types**: Always set the correct keyboard type for better UX:
   ```dart
   TextField(
     inputFormatters: SmartInputFormatters.mobile(),
     keyboardType: TextInputType.phone, // Shows numeric keyboard
   )
   ```

3. **Customize When Needed**: Most formatters accept parameters for customization:
   ```dart
   SmartInputFormatters.idNumber(
     startDigits: [1, 2, 3, 4],
     maxLength: 15,
   )
   ```

4. **Combine Multiple Formatters**: You can combine formatters for complex requirements:
   ```dart
   TextField(
     inputFormatters: [
       ...SmartInputFormatters.name(),
       // Add custom formatters if needed
     ],
   )
   ```

---

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            inputFormatters: SmartInputFormatters.name(),
            decoration: InputDecoration(labelText: 'Full Name'),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          TextFormField(
            inputFormatters: SmartInputFormatters.mobile(),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'Mobile'),
          ),
          TextFormField(
            inputFormatters: SmartInputFormatters.email(),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            inputFormatters: SmartInputFormatters.idNumber(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'National ID'),
          ),
        ],
      ),
    );
  }
}
```

---

## See Also

- [Vital Signs Formatters](VITAL_SIGNS_FORMATTER.md)
- [Main README](../README.md)
