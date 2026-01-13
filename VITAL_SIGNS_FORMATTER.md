# Vital Signs Formatter - Complete Guide

## Overview

The `vitalSign()` formatter is a powerful, general-purpose input formatter designed specifically for medical vital signs measurements. It provides predefined configurations for common vital signs while allowing full customization for custom use cases.

## Key Features

✅ **Predefined Configurations** - Ready-to-use settings for 11 common vital signs  
✅ **Smart Decimal Handling** - Automatic decimal/integer detection based on vital type  
✅ **Range Validation** - Built-in min/max value constraints  
✅ **Blood Pressure Support** - Special formatting for systolic/diastolic (120/80)  
✅ **Fully Customizable** - Override any setting for custom vital signs  

## Predefined Vital Types

### 1. Temperature
```dart
SmartInputFormatters.vitalSign(vitalType: 'temperature')
```
- **Type**: Decimal (1 decimal place)
- **Range**: 0-999.9
- **Example**: `37.5`, `98.6`
- **Use for**: Body temperature in °C or °F

### 2. Blood Pressure
```dart
SmartInputFormatters.vitalSign(vitalType: 'bloodPressure')
```
- **Type**: Integer with slash separator
- **Format**: systolic/diastolic
- **Range**: Systolic (40-300), Diastolic (20-200)
- **Example**: `120/80`, `140/90`
- **Special**: Validates both values independently

### 3. Heart Rate
```dart
SmartInputFormatters.vitalSign(vitalType: 'heartRate')
```
- **Type**: Integer only
- **Range**: 0-999 bpm
- **Example**: `72`, `120`
- **Use for**: Pulse rate, beats per minute

### 4. Respiratory Rate
```dart
SmartInputFormatters.vitalSign(vitalType: 'respiratoryRate')
```
- **Type**: Integer only
- **Range**: 0-999 breaths/min
- **Example**: `16`, `20`
- **Use for**: Breathing rate

### 5. Oxygen Saturation (SpO2)
```dart
SmartInputFormatters.vitalSign(vitalType: 'oxygenSaturation')
// or
SmartInputFormatters.vitalSign(vitalType: 'spo2')
```
- **Type**: Integer only
- **Range**: 0-100%
- **Example**: `98`, `95`
- **Use for**: Blood oxygen saturation percentage

### 6. Blood Glucose
```dart
SmartInputFormatters.vitalSign(vitalType: 'glucose')
// or
SmartInputFormatters.vitalSign(vitalType: 'glucometer')
```
- **Type**: Integer only
- **Range**: 0-9999 mg/dL
- **Example**: `100`, `250`
- **Use for**: Blood sugar levels

### 7. Height (cm)
```dart
SmartInputFormatters.vitalSign(vitalType: 'heightCm')
```
- **Type**: Decimal (2 decimal places)
- **Range**: 0-999.99 cm
- **Example**: `175.5`, `180.25`

### 8. Weight (kg)
```dart
SmartInputFormatters.vitalSign(vitalType: 'weightKg')
```
- **Type**: Decimal (2 decimal places)
- **Range**: 0-999.99 kg
- **Example**: `70.5`, `85.25`

### 9. BMI (Body Mass Index)
```dart
SmartInputFormatters.vitalSign(vitalType: 'bmi')
```
- **Type**: Decimal (2 decimal places)
- **Range**: 0-99.99
- **Example**: `22.5`, `28.75`

## Complete Usage Examples

### Basic Usage
```dart
// Temperature field
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(vitalType: 'temperature'),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: 'Temperature (°C)',
    hintText: '37.5',
  ),
)

// Blood Pressure field
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(vitalType: 'bloodPressure'),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: 'Blood Pressure',
    hintText: '120/80',
  ),
)

// SpO2 field
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(vitalType: 'spo2'),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: 'SpO2 (%)',
    hintText: '98',
  ),
)
```

### Custom Vital Signs
```dart
// Custom vital with decimal
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    allowDecimal: true,
    maxDecimalPlaces: 2,
    maxValue: 500.0,
    minValue: 0.0,
    maxLength: 6,
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(labelText: 'Custom Measurement'),
)

// Custom integer vital with range
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    allowDecimal: false,
    maxValue: 200.0,
    minValue: 50.0,
    maxLength: 3,
  ),
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Custom Count'),
)
```

### Override Predefined Settings
```dart
// Temperature with custom range
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    vitalType: 'temperature',
    maxValue: 45.0,  // Override default max
    minValue: 30.0,  // Add minimum
  ),
)

// Glucose with decimal (override default integer-only)
TextField(
  inputFormatters: SmartInputFormatters.vitalSign(
    vitalType: 'glucose',
    allowDecimal: true,
    maxDecimalPlaces: 1,
  ),
)
```

## Complete Form Example

```dart
import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class VitalSignsForm extends StatefulWidget {
  @override
  State<VitalSignsForm> createState() => _VitalSignsFormState();
}

class _VitalSignsFormState extends State<VitalSignsForm> {
  final _temperatureController = TextEditingController();
  final _bpController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _spo2Controller = TextEditingController();
  final _glucoseController = TextEditingController();

  @override
  void dispose() {
    _temperatureController.dispose();
    _bpController.dispose();
    _heartRateController.dispose();
    _spo2Controller.dispose();
    _glucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Temperature
          TextFormField(
            controller: _temperatureController,
            inputFormatters: SmartInputFormatters.vitalSign(
              vitalType: 'temperature',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Temperature (°C)',
              hintText: '37.5',
              prefixIcon: Icon(Icons.thermostat),
            ),
          ),
          
          // Blood Pressure
          TextFormField(
            controller: _bpController,
            inputFormatters: SmartInputFormatters.vitalSign(
              vitalType: 'bloodPressure',
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Blood Pressure',
              hintText: '120/80',
              prefixIcon: Icon(Icons.favorite),
            ),
          ),
          
          // Heart Rate
          TextFormField(
            controller: _heartRateController,
            inputFormatters: SmartInputFormatters.vitalSign(
              vitalType: 'heartRate',
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Heart Rate (bpm)',
              hintText: '72',
              prefixIcon: Icon(Icons.monitor_heart),
            ),
          ),
          
          // SpO2
          TextFormField(
            controller: _spo2Controller,
            inputFormatters: SmartInputFormatters.vitalSign(
              vitalType: 'spo2',
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'SpO2 (%)',
              hintText: '98',
              prefixIcon: Icon(Icons.air),
            ),
          ),
          
          // Glucose
          TextFormField(
            controller: _glucoseController,
            inputFormatters: SmartInputFormatters.vitalSign(
              vitalType: 'glucose',
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Blood Glucose (mg/dL)',
              hintText: '100',
              prefixIcon: Icon(Icons.bloodtype),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Parameters Reference

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `vitalType` | `String?` | `null` | Predefined vital type (see list above) |
| `allowDecimal` | `bool?` | Auto-detected | Whether to allow decimal values |
| `maxDecimalPlaces` | `int?` | 1 or 2 | Maximum decimal places allowed |
| `minValue` | `double?` | `null` | Minimum allowed value |
| `maxValue` | `double?` | Auto-detected | Maximum allowed value |
| `maxLength` | `int?` | 6 | Maximum input length |

## Validation Behavior

### Decimal Validation
- Automatically prevents more than one decimal point
- Limits decimal places based on configuration
- Allows typing decimal point even if no digits after it yet

### Range Validation
- Validates on each keystroke
- Prevents values outside min/max range
- Allows partial input (e.g., typing "1" when max is "100")

### Blood Pressure Special Handling
- Allows only one slash (/)
- Validates systolic (40-300 mmHg)
- Validates diastolic (20-200 mmHg)
- Prevents slash at the beginning
- Format: `systolic/diastolic`

## Best Practices

### 1. Always Set Keyboard Type
```dart
// For decimal vitals
keyboardType: TextInputType.numberWithOptions(decimal: true)

// For integer vitals
keyboardType: TextInputType.number
```

### 2. Add Validation
```dart
TextFormField(
  inputFormatters: SmartInputFormatters.vitalSign(vitalType: 'temperature'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Temperature is required';
    }
    final temp = double.tryParse(value);
    if (temp == null) {
      return 'Invalid temperature';
    }
    if (temp < 35.0 || temp > 42.0) {
      return 'Temperature out of normal range';
    }
    return null;
  },
)
```

### 3. Provide Clear Hints
```dart
decoration: InputDecoration(
  labelText: 'Temperature (°C)',
  hintText: '37.5',
  helperText: 'Normal range: 36.1-37.2°C',
)
```

### 4. Use Appropriate Icons
```dart
Icons.thermostat       // Temperature
Icons.favorite         // Blood Pressure / Heart
Icons.monitor_heart    // Heart Rate
Icons.air              // SpO2
Icons.bloodtype        // Glucose
Icons.height           // Height
Icons.monitor_weight   // Weight
```

## Common Use Cases

### Medical Records App
```dart
SmartInputFormatters.vitalSign(vitalType: 'temperature')
SmartInputFormatters.vitalSign(vitalType: 'bloodPressure')
SmartInputFormatters.vitalSign(vitalType: 'heartRate')
SmartInputFormatters.vitalSign(vitalType: 'spo2')
```

### Fitness Tracking App
```dart
SmartInputFormatters.vitalSign(vitalType: 'heartRate')
SmartInputFormatters.vitalSign(vitalType: 'weightKg')
SmartInputFormatters.vitalSign(vitalType: 'bmi')
```

### Diabetes Management App
```dart
SmartInputFormatters.vitalSign(vitalType: 'glucose')
SmartInputFormatters.vitalSign(vitalType: 'weightKg')
SmartInputFormatters.vitalSign(vitalType: 'bmi')
```

## Tips & Tricks

1. **Case Insensitive**: Vital types are case-insensitive (`'temperature'` = `'Temperature'` = `'TEMPERATURE'`)

2. **Aliases**: Some vitals have aliases:
   - `'spo2'` = `'oxygenSaturation'`
   - `'glucose'` = `'glucometer'`

3. **Custom Ranges**: Override default ranges for specific medical contexts:
   ```dart
   // Pediatric temperature range
   SmartInputFormatters.vitalSign(
     vitalType: 'temperature',
     minValue: 35.0,
     maxValue: 40.0,
   )
   ```

4. **Combine with Other Formatters**: You can combine with other formatters if needed:
   ```dart
   inputFormatters: [
     ...SmartInputFormatters.vitalSign(vitalType: 'temperature'),
     // Add custom formatters here
   ]
   ```

## Troubleshooting

**Q: The formatter isn't working**  
A: Make sure you're using the correct keyboard type (`TextInputType.number` or `TextInputType.numberWithOptions(decimal: true)`)

**Q: Blood pressure slash isn't working**  
A: Ensure you're using `vitalType: 'bloodPressure'` exactly

**Q: Decimal values aren't allowed**  
A: Check that `allowDecimal: true` is set or use a vital type that supports decimals

**Q: Values are being rejected**  
A: Check the min/max range - you might need to customize it for your use case

## Support

For issues or feature requests, please visit the [GitHub repository](https://github.com/SmartMind-New/smart_utils_package).
