## 0.0.4

### Added

- **UI Utilities Module**: New widgets and extensions for common UI patterns
  - `AppWrapper`: Controls text scaling and handles safe area padding
  - `DoubleTapExitWrapper`: Requires double-tap on back button to exit app
  - `SliverExtensions`: Convert regular widgets to Sliver widgets
    - `toSliver()` - Basic conversion to SliverToBoxAdapter
    - `toPaddedSliver()` - Sliver with padding
    - `toAnimatedSliver()` - Animated sliver transitions
    - `toSliverFillRemaining()` - Fill remaining viewport space
  - `SpacingExtension`: Convenient spacing and divider helpers
    - `width` and `height` properties for spacing
    - `hDivider()` and `vDivider()` methods with customization
  - Comprehensive documentation in `UI_UTILITIES.md`
- **Country Flag Extension**: Convert ISO country codes to flag emojis
  - `toFlag` - Convert country code to flag emoji (e.g., 'US'.toFlag → 🇺🇸)
  - `isValidCountryCodeFormat` - Validate country code format
- Added UI Utilities demo page to example app
- Updated main example app to demonstrate `AppWrapper` and `DoubleTapExitWrapper`

## 0.0.3

### Added

- **Vital Signs Formatter**: General-purpose formatter for medical vital signs
  - Predefined configurations for 11 common vital signs (temperature, blood pressure, heart rate, SpO2, glucose, etc.)
  - Smart decimal/integer handling based on vital type
  - Range validation with min/max values
  - Special blood pressure formatting (systolic/diastolic)
  - Fully customizable for custom vital signs
  - Comprehensive documentation in `VITAL_SIGNS_FORMATTER.md`
- Added vital signs section to example app

### Changed

- **Name Formatter**: Now supports both Arabic (ا-ي) and English (a-z, A-Z) letters
- **Email Formatter**: Added `maxLength` parameter (default: 50, customizable)
- Updated README with vital signs examples and usage
- Updated INPUT_FORMATTERS.md with Arabic support documentation

## 0.0.2

### Added

- **Input Formatters Module**: Comprehensive collection of input formatters for common form fields
  - Personal Information: `name()`, `age()`
  - Contact Information: `mobile()`, `email()`
  - Physical Measurements: `height()`, `weight()`
  - Identification Documents: `idNumber()`, `passport()`, `postalCode()`
  - Payment Information: `creditCard()`, `cvv()`, `currency()`
  - Account Information: `username()`, `url()`
  - Date & Time: `date()`, `time()`
  - Other: `percentage()`
- Custom formatters: `UpperCaseTextFormatter`, `LowerCaseTextFormatter`
- Comprehensive example app demonstrating all input formatters
- Detailed documentation in `INPUT_FORMATTERS.md`

### Changed

- Updated README with comprehensive usage examples
- Added example app with beautiful UI showcasing all formatters

## 0.0.1

### Added

- Initial release
- Date & Time helpers
- Enum converter utilities
- Model parser utilities
- Type converter utilities
