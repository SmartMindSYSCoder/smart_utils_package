# UI Utilities

A collection of Flutter UI utility widgets and extensions that simplify common UI patterns and improve code readability.

## 📦 Components

- [DoubleTapExitWrapper](#doubletapexitwrapper) - Double-tap to exit functionality
- [AppWrapper](#appwrapper) - Text scaling and safe area management
- [SliverExtensions](#sliverextensions) - Widget to Sliver conversion utilities
- [SpacingExtension](#spacingextension) - Convenient spacing and divider helpers

---

## DoubleTapExitWrapper

A wrapper widget that requires double-tap on the back button to exit the app.

### Features

- ✅ Prevents accidental app exits
- ✅ Customizable timeout duration
- ✅ Optional snackbar notification
- ✅ Fully customizable styling

### Basic Usage

```dart
DoubleTapExitWrapper(
  child: MyHomePage(),
)
```

### Advanced Usage

```dart
DoubleTapExitWrapper(
  child: MyHomePage(),
  exitMessage: 'اضغط مرة أخرى للخروج',
  exitTimeoutSeconds: 3,
  snackbarBackgroundColor: Colors.blue.shade700,
  snackbarTextColor: Colors.white,
  snackbarMargin: EdgeInsets.all(20),
  snackbarBorderRadius: 16,
)
```

### Parameters

| Parameter                 | Type                  | Default                      | Description                                            |
| ------------------------- | --------------------- | ---------------------------- | ------------------------------------------------------ |
| `child`                   | `Widget`              | **required**                 | The child widget to wrap                               |
| `exitMessage`             | `String`              | `'Press back again to exit'` | Message to display on first back press                 |
| `exitTimeoutSeconds`      | `int`                 | `2`                          | Timeout in seconds before requiring another double-tap |
| `showSnackbar`            | `bool`                | `true`                       | Whether to show a snackbar message                     |
| `snackbarBackgroundColor` | `Color?`              | `Theme secondary color`      | Background color of the snackbar                       |
| `snackbarTextColor`       | `Color?`              | `Colors.white`               | Text color of the snackbar                             |
| `snackbarMargin`          | `EdgeInsetsGeometry?` | `EdgeInsets.all(16)`         | Margin around the snackbar                             |
| `snackbarBorderRadius`    | `double?`             | `12.0`                       | Border radius of the snackbar                          |

---

## AppWrapper

A wrapper widget that controls text scaling and handles safe area padding.

### Features

- ✅ Limits text scale to prevent UI breaking
- ✅ Automatic safe area padding handling
- ✅ Customizable min/max text scale
- ✅ Optional custom padding

### Basic Usage

```dart
AppWrapper(
  child: MyApp(),
)
```

### Advanced Usage

```dart
AppWrapper(
  child: MyApp(),
  minTextScale: 0.8,
  maxTextScale: 1.5,
  applyBottomPadding: true,
)
```

### Custom Padding

```dart
AppWrapper(
  child: MyApp(),
  customPadding: EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 24,
  ),
)
```

### Parameters

| Parameter            | Type                  | Default      | Description                                     |
| -------------------- | --------------------- | ------------ | ----------------------------------------------- |
| `child`              | `Widget`              | **required** | The child widget to wrap                        |
| `minTextScale`       | `double`              | `1.0`        | Minimum text scale factor                       |
| `maxTextScale`       | `double`              | `1.2`        | Maximum text scale factor                       |
| `applyBottomPadding` | `bool`                | `true`       | Whether to apply bottom safe area padding       |
| `customPadding`      | `EdgeInsetsGeometry?` | `null`       | Custom padding (overrides `applyBottomPadding`) |

---

## SliverExtensions

Extension methods for converting regular widgets to Sliver widgets.

### Features

- ✅ Simple widget to sliver conversion
- ✅ Padded sliver helper
- ✅ Animated sliver transitions
- ✅ Fill remaining space utility

### Basic Conversion

```dart
CustomScrollView(
  slivers: [
    Text('Hello World').toSliver(),
    MyWidget().toSliver(),
  ],
)
```

### Padded Sliver

```dart
CustomScrollView(
  slivers: [
    MyCard().toPaddedSliver(
      padding: EdgeInsets.all(16),
    ),
  ],
)
```

### Animated Sliver

```dart
CustomScrollView(
  slivers: [
    Obx(() => controller.isLoading.value
      ? CircularProgressIndicator()
      : ContentWidget()
    ).toAnimatedSliver(
      duration: Duration(milliseconds: 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
    ),
  ],
)
```

### Fill Remaining Space

```dart
CustomScrollView(
  slivers: [
    // ... other slivers
    EmptyStateWidget().toSliverFillRemaining(
      hasScrollBody: false,
    ),
  ],
)
```

### Available Methods

| Method                         | Return Type           | Description                                    |
| ------------------------------ | --------------------- | ---------------------------------------------- |
| `toSliver()`                   | `SliverToBoxAdapter`  | Wraps widget in a SliverToBoxAdapter           |
| `toPaddedSliver({padding})`    | `SliverToBoxAdapter`  | Wraps widget with padding in a sliver          |
| `toAnimatedSliver({...})`      | `SliverToBoxAdapter`  | Wraps widget in AnimatedSwitcher inside sliver |
| `toSliverFillRemaining({...})` | `SliverFillRemaining` | Creates a sliver that fills remaining space    |

---

## SpacingExtension

Extension on `num` to provide convenient spacing and divider widgets.

### Features

- ✅ Simple width/height spacing
- ✅ Horizontal and vertical dividers
- ✅ Customizable divider styling
- ✅ Clean, readable syntax

### Width Spacing

```dart
Row(
  children: [
    Text('Hello'),
    16.width, // Adds 16 logical pixels spacing
    Text('World'),
  ],
)
```

### Height Spacing

```dart
Column(
  children: [
    Text('Title'),
    20.height, // Adds 20 logical pixels spacing
    Text('Content'),
  ],
)
```

### Horizontal Divider

```dart
Column(
  children: [
    Text('Section 1'),
    16.hDivider(), // Default divider
    Text('Section 2'),
    16.hDivider(
      color: Colors.grey,
      thickness: 2,
      indent: 16,
      endIndent: 16,
    ),
    Text('Section 3'),
  ],
)
```

### Vertical Divider

```dart
Row(
  children: [
    Text('Item 1'),
    24.vDivider(color: Colors.grey.shade300),
    Text('Item 2'),
  ],
)
```

### Available Properties

| Property | Return Type | Description                |
| -------- | ----------- | -------------------------- |
| `width`  | `SizedBox`  | Creates horizontal spacing |
| `height` | `SizedBox`  | Creates vertical spacing   |

### Available Methods

| Method       | Parameters                                  | Description                |
| ------------ | ------------------------------------------- | -------------------------- |
| `hDivider()` | `color`, `thickness`, `indent`, `endIndent` | Creates horizontal divider |
| `vDivider()` | `color`, `thickness`, `indent`, `endIndent` | Creates vertical divider   |

---

## 💡 Tips & Best Practices

### DoubleTapExitWrapper

- Place at the root of your main screen/scaffold
- Customize the message for better UX in your locale
- Adjust timeout based on user testing feedback

### AppWrapper

- Use at the app root level (wrap MaterialApp/CupertinoApp)
- Set appropriate min/max scale based on your design constraints
- Test with different accessibility settings

### SliverExtensions

- Use `toSliver()` for simple conversions
- Prefer `toPaddedSliver()` over wrapping in Padding manually
- Use `toAnimatedSliver()` for dynamic content changes
- Use `toSliverFillRemaining()` for empty states

### SpacingExtension

- Use consistent spacing values (8, 12, 16, 24, 32, etc.)
- Prefer this over manual SizedBox creation for cleaner code
- Customize divider colors to match your theme

---

## 🔗 Related Documentation

- [Type Converters](TYPE_CONVERTERS.md)
- [Number Formatters](NUMBER_FORMATTERS.md)
- [Input Validators](INPUT_VALIDATORS.md)
