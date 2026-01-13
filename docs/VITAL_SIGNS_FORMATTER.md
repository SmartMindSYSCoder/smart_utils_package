# Vital Signs Formatter - Complete Guide

## Overview

The `vitalSign()` formatter is a flexible, general-purpose input formatter designed for medical vital signs and other numeric measurements. It allows you to define constraints like decimal precision, maximum values, and input length to ensure valid data entry.

## Key Features

✅ **Decimal Control** - Enable or disable decimals, set precision  
✅ **Range Validation** - Optional min/max value validation  
✅ **Digit limitations** - Limit digits before/after decimal  
✅ **Length Limiting** - Restrict total max length

## Usage Guide

Since the formatter is generic, you configure it for specific vital signs by passing the appropriate parameters.

### 1. Temperature (°C/°F)
Typical range: 0-100, 1 decimal place.

```dart
// Temperature: usually 30-45 °C
SmartInputFormatters.vitalSign(
  allowDecimal: true,
  maxDigitsBeforeDecimal: 2, // e.g. 42
  maxDigitsAfterDecimal: 1,  // e.g. 37.5
  minValue: 30.0,            // Realistic min
  maxValue: 45.0,            // Realistic max
  maxLength: 4,              // "XX.X"
)
```

### 2. Oxygen Saturation (SpO2)
Integer, 0-100%.

```dart
// Valid SpO2: 70-100%
SmartInputFormatters.vitalSign(
  allowDecimal: false,
  minValue: 70,    // Realistic min
  maxValue: 100,   // Max percentage
  maxLength: 3,
)
```

### 3. Heart Rate (BPM)
Integer, usually 0-300.

```dart
// Heart Rate: 30-220 bpm
SmartInputFormatters.vitalSign(
  allowDecimal: false,
  minValue: 30,    // Realistic min
  maxValue: 220,   // Realistic max
  maxLength: 3,
)
```

### 4. Blood Glucose
Integer, usually 0-600 mg/dL.

```dart
// Blood Glucose: 20-600 mg/dL
SmartInputFormatters.vitalSign(
  allowDecimal: false,
  minValue: 20,
  maxValue: 600,
  maxLength: 3,
)
```

### 5. Height (cm)
Decimal, e.g., 175.5 cm.

```dart
// Height: 30-250 cm
SmartInputFormatters.vitalSign(
  allowDecimal: true,
  maxDigitsBeforeDecimal: 3,
  maxDigitsAfterDecimal: 1,
  minValue: 30.0,
  maxValue: 250.0,
  maxLength: 5,
)
```

### 6. Weight (kg)
Decimal, e.g., 70.55 kg.

```dart
// Weight: 2-300 kg
SmartInputFormatters.vitalSign(
  allowDecimal: true,
  maxDigitsBeforeDecimal: 3,
  maxDigitsAfterDecimal: 2,
  minValue: 2.0,
  maxValue: 300.0,
  maxLength: 6,
)
```

## Parameters Reference

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `allowDecimal` | `bool` | `false` | Whether to allow decimal point input |
| `maxDigitsBeforeDecimal` | `int?` | `null` | Limit digits before decimal point |
| `maxDigitsAfterDecimal` | `int` | `2` | Limit digits after decimal point |
| `minValue` | `double?` | `null` | Minimum allowed value (validation) |
| `maxValue` | `double?` | `null` | Maximum allowed value (validation) |
| `maxLength` | `int` | `6` | Maximum total characters length |

## Note on Blood Pressure
Blood pressure (e.g., "120/80") usually requires a composite format (slash separator). The current `vitalSign` formatter handles **numeric** values. For BP, it is recommended to use:
1. Two separate fields (Systolic / Diastolic) using the integer configuration.
2. Or a custom formatter if a single "120/80" field is required.

## Example

```dart
TextField(
  // Configure for Temperature
  inputFormatters: SmartInputFormatters.vitalSign(
    allowDecimal: true,
    maxValue: 42.0,
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: 'Temperature',
    hintText: '37.5',
    suffixText: '°C'
  ),
)
```



