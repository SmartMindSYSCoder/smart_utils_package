# Smart Utils Package - Quick Reference

## Import

```dart
import 'package:smart_utils_package/smart_utils_package.dart';
```

---

## UI Utilities

### AppWrapper

Wrap your app to control text scaling and safe areas:

```dart
AppWrapper(
  minTextScale: 0.8,
  maxTextScale: 1.2,
  child: MaterialApp(...),
)
```

### DoubleTapExitWrapper

Require double-tap to exit:

```dart
DoubleTapExitWrapper(
  exitMessage: 'Press back again to exit',
  child: HomePage(),
)
```

### SpacingExtension

Quick spacing and dividers:

```dart
// Spacing
16.width  // Horizontal spacing
20.height // Vertical spacing

// Dividers
16.hDivider(color: Colors.grey, thickness: 2)
24.vDivider(color: Colors.blue)
```

### SliverExtensions

Convert widgets to slivers:

```dart
CustomScrollView(
  slivers: [
    Text('Hello').toSliver(),
    MyWidget().toPaddedSliver(padding: EdgeInsets.all(16)),
    LoadingWidget().toAnimatedSliver(duration: Duration(milliseconds: 300)),
    EmptyState().toSliverFillRemaining(),
  ],
)
```

**📖 Full Docs:** [UI_UTILITIES.md](docs/UI_UTILITIES.md)

---

## Country Flags

### Convert Country Code to Flag Emoji

```dart
// Basic usage
String usFlag = 'US'.toFlag;  // 🇺🇸
String yemenFlag = 'YE'.toFlag;  // 🇾🇪
String saudiFlag = 'SA'.toFlag;  // 🇸🇦

// In widgets
Text('United States ${'US'.toFlag}')
Text('Yemen ${'YE'.toFlag}')

// Validate format
bool isValid = 'US'.isValidCountryCodeFormat;  // true
bool invalid = 'USA'.isValidCountryCodeFormat;  // false
```

---

## Input Formatters

| Formatter        | Usage                               | Key Features                          |
| ---------------- | ----------------------------------- | ------------------------------------- |
| **Personal**     |                                     |                                       |
| `name()`         | `SmartInputFormatters.name()`       | Letters, spaces, hyphens, apostrophes |
| `age()`          | `SmartInputFormatters.age()`        | Digits only, max 3 chars              |
| **Contact**      |                                     |                                       |
| `mobile()`       | `SmartInputFormatters.mobile()`     | Digits only, max 15 chars             |
| `email()`        | `SmartInputFormatters.email()`      | Valid email chars, no spaces          |
| **Measurements** |                                     |                                       |
| `height()`       | `SmartInputFormatters.height()`     | Decimal, max 2 places, 0-999.99 cm    |
| `weight()`       | `SmartInputFormatters.weight()`     | Decimal, max 2 places, 0-999.99 kg    |
| **ID Documents** |                                     |                                       |
| `idNumber()`     | `SmartInputFormatters.idNumber()`   | Must start with 1 or 2, digits only   |
| `passport()`     | `SmartInputFormatters.passport()`   | Alphanumeric, auto-uppercase          |
| `postalCode()`   | `SmartInputFormatters.postalCode()` | Alphanumeric + hyphens, uppercase     |
| **Payment**      |                                     |                                       |
| `creditCard()`   | `SmartInputFormatters.creditCard()` | Auto-formats: XXXX XXXX XXXX XXXX     |
| `cvv()`          | `SmartInputFormatters.cvv()`        | 3-4 digits                            |
| `currency()`     | `SmartInputFormatters.currency()`   | Decimal, max 2 places                 |
| **Account**      |                                     |                                       |
| `username()`     | `SmartInputFormatters.username()`   | Alphanumeric + \_-, auto-lowercase    |
| `url()`          | `SmartInputFormatters.url()`        | Valid URL chars, no spaces            |
| **Date & Time**  |                                     |                                       |
| `date()`         | `SmartInputFormatters.date()`       | Auto-formats: DD/MM/YYYY              |
| `time()`         | `SmartInputFormatters.time()`       | Auto-formats: HH:MM                   |
| **Other**        |                                     |                                       |
| `percentage()`   | `SmartInputFormatters.percentage()` | 0-100, max 2 decimal places           |

## Common Patterns

### Basic TextField

```dart
TextField(
  inputFormatters: SmartInputFormatters.mobile(),
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(labelText: 'Mobile'),
)
```

### With Validation

```dart
TextFormField(
  inputFormatters: SmartInputFormatters.email(),
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
)
```

### Custom Parameters

```dart
// Custom max length
SmartInputFormatters.mobile(maxLength: 10)

// Custom start digits for ID
SmartInputFormatters.idNumber(startDigits: [1, 2, 3], maxLength: 15)

// Max value for currency
SmartInputFormatters.currency(maxValue: 10000.0)

// Custom CVV length for AMEX
SmartInputFormatters.cvv(maxLength: 4)
```

## Keyboard Types

| Formatter                    | Recommended Keyboard Type                        |
| ---------------------------- | ------------------------------------------------ |
| `mobile()`                   | `TextInputType.phone`                            |
| `email()`                    | `TextInputType.emailAddress`                     |
| `height()`, `weight()`       | `TextInputType.numberWithOptions(decimal: true)` |
| `idNumber()`, `age()`        | `TextInputType.number`                           |
| `creditCard()`, `cvv()`      | `TextInputType.number`                           |
| `currency()`, `percentage()` | `TextInputType.numberWithOptions(decimal: true)` |
| `url()`                      | `TextInputType.url`                              |
| `date()`, `time()`           | `TextInputType.number`                           |

## Examples

### Registration Form

```dart
Column(
  children: [
    TextFormField(
      inputFormatters: SmartInputFormatters.name(),
      decoration: InputDecoration(labelText: 'Full Name'),
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
  ],
)
```

### Payment Form

```dart
Column(
  children: [
    TextFormField(
      inputFormatters: SmartInputFormatters.creditCard(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Card Number'),
    ),
    Row(
      children: [
        Expanded(
          child: TextFormField(
            inputFormatters: SmartInputFormatters.date(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Expiry (MM/YY)'),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            inputFormatters: SmartInputFormatters.cvv(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'CVV'),
          ),
        ),
      ],
    ),
  ],
)
```

### Health Form

```dart
Column(
  children: [
    TextFormField(
      inputFormatters: SmartInputFormatters.age(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Age'),
    ),
    TextFormField(
      inputFormatters: SmartInputFormatters.height(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Height (cm)'),
    ),
    TextFormField(
      inputFormatters: SmartInputFormatters.weight(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Weight (kg)'),
    ),
  ],
)
```

## Tips

1. **Always set appropriate keyboard types** for better UX
2. **Combine with validators** for complete validation
3. **Customize parameters** when needed (max length, start digits, etc.)
4. **Use const constructors** where possible for better performance
5. **Test on real devices** to ensure formatters work as expected

## See Also

- [Full Documentation](INPUT_FORMATTERS.md) - Detailed documentation with all features
- [Example App](example/) - Comprehensive demo app
- [README](README.md) - Package overview and installation
