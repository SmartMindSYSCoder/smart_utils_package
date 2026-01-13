# Date & Time Helpers

A collection of utilities for parsing, formatting, and manipulating dates and times.

## Overview

The `DateTimeHelper` mixin provides robust methods for handling dates, times, and durations in Flutter applications.

## Parsing Dates

Safely parse strings into DateTime objects with support for multiple formats.

```dart
// Parse ISO 8601
DateTime? date = DateTimeHelper.fromString("2024-01-15T10:30:00Z");

// Parse custom formats (DD-MM-YYYY or YYYY-MM-DD)
DateTime? date2 = DateTimeHelper.fromString("15-01-2024");
DateTime? date3 = DateTimeHelper.fromString("2024-01-15");
```

## Formatting Dates

Format dates into user-friendly strings.

```dart
final date = DateTime(2024, 1, 15, 14, 30);

// Simple date (YYYY-MM-DD)
DateTimeHelper.toSimpleString(date); // "2024-01-15"

// Display string (DD Mon YYYY)
DateTimeHelper.toDisplayString(date); // "15 Jan 2024"

// Formatted string with custom pattern
DateTimeHelper.toFormattedString(date, format: 'dd/MM/yyyy'); // "15/01/2024"

// Complex options
DateTimeHelper.showFormattedDate(
  date,
  withTime: true,
  separator: '/',
); // "02:30 PM  15/01/2024"
```

## Formatting Time

```dart
// Time string (AM/PM)
DateTimeHelper.toTimeString(date); // "02:30 PM"

// 24-hour format
DateTimeHelper.toTimeString(date, use24Hour: true); // "14:30"
```

## Relative Time

Show "time ago" or "in future" strings.

```dart
// Past date
DateTimeHelper.toRelativeString(pastDate); // "2 hours ago"

// Future date
DateTimeHelper.toRelativeString(futureDate); // "in 3 days"
```

## Logic & Helpers

Helper methods for date comparisons and manipulation.

```dart
// Check days
DateTimeHelper.isToday(date);
DateTimeHelper.isYesterday(date);
DateTimeHelper.isTomorrow(date);

// Calculate Age
int? age = DateTimeHelper.getAge(dateOfBirth);

// Date Manipulation
DateTime? nextWeek = DateTimeHelper.addDays(date, 7);
DateTime? lastWeek = DateTimeHelper.subtractDays(date, 7);

// Day Boundaries
DateTime? start = DateTimeHelper.startOfDay(date); // 2024-01-15 00:00:00
DateTime? end = DateTimeHelper.endOfDay(date);     // 2024-01-15 23:59:59
```

## Friendly Grouping

Useful for grouping lists of items by date (e.g., chat history).

```dart
DateTimeHelper.getFriendlyDateGroup(DateTime.now());             // "Today"
DateTimeHelper.getFriendlyDateGroup(yesterday);                  // "Yesterday"
DateTimeHelper.getFriendlyDateGroup(otherDate);                  // "05, Feb 2024"
```

## API Reference

| Method | Description |
|--------|-------------|
| `fromString` | Parse flexible string formats to DateTime |
| `showFormattedDate` | Comprehensive formatting with toggles |
| `toSimpleString` | Convert to YYYY-MM-DD |
| `toDisplayString` | Convert to DD Mon YYYY |
| `toTimeString` | Convert to HH:mm AM/PM |
| `toDateTimeString` | Convert to Date + Time |
| `toRelativeString` | Get "ago" or "in" string |
| `isToday` | Check if date is today |
| `isYesterday` | Check if date is yesterday |
| `isTomorrow` | Check if date is tomorrow |
| `getAge` | Calculate age from birthdate |
| `addDays` | Add days returning new DateTime |
| `subtractDays` | Subtract days returning new DateTime |
| `startOfDay` | Get 00:00:00 of date |
| `endOfDay` | Get 23:59:59 of date |
| `getFriendlyDateGroup` | Get "Today", "Yesterday" or date string |

## See Also

- [Main README](../README.md)
