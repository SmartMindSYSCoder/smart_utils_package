import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

// Helper class to access mixin methods if needed
class DateTimeUtils with DateTimeHelper {}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  group('DateTimeHelper', () {
    // =========================================================================
    // FORMATTING
    // =========================================================================
    group('showFormattedDate', () {
      final date = DateTime(2024, 1, 15, 14, 30); // Jan 15, 2024, 14:30

      test('should format withTime', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            withTime: true,
            localeCod: 'en',
          ),
          '02:30 PM  15 - 01 - 2024', // Checking default format
        );
      });

      test('should format onlyTime', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            onlyTime: true,
            localeCod: 'en',
          ),
          '02:30',
        );
      });

      test('should format onlyTimeWithAMPM', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            onlyTimeWithAMPM: true,
            localeCod: 'en',
          ),
          '02:30 PM',
        );
      });

      test('should format onlyDay', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            onlyDay: true,
            localeCod: 'en',
          ),
          '15',
        );
      });

      test('should format onlyYearAndMonth', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            onlyYearAndMonth: true,
            localeCod: 'en',
          ),
          'January - 2024',
        );
      });

      test('should format dateWithDayName', () {
        expect(
          DateTimeHelper.showFormattedDate(
            date,
            dateWithDayName: true,
            localeCod: 'en',
          ),
          'Mon - 15 - 01 - 2024',
        );
      });

      test('should use default format', () {
        expect(
          DateTimeHelper.showFormattedDate(date, localeCod: 'en'),
          '2024-01-15',
        );
      });
    });

    // =========================================================================
    // PARSING
    // =========================================================================
    group('fromString', () {
      test('should parse ISO string', () {
        final date = DateTimeHelper.fromString("2024-01-15T10:30:00.000");
        expect(date?.year, 2024);
        expect(date?.month, 1);
        expect(date?.day, 15);
      });

      test('should parse simple string (YYYY-MM-DD)', () {
        final date = DateTimeHelper.fromString("2024-01-15");
        expect(date?.year, 2024);
        expect(date?.month, 1);
        expect(date?.day, 15);
      });

      test('should parse alternative formats (DD-MM-YYYY)', () {
        final date = DateTimeHelper.fromString("15-01-2024");
        expect(date?.year, 2024);
        expect(date?.month, 1);
        expect(date?.day, 15);
      });

      test('should return null for invalid', () {
        expect(DateTimeHelper.fromString("invalid"), null);
        expect(DateTimeHelper.fromString(null), null);
      });
    });

    // =========================================================================
    // RELATIVE TIME
    // =========================================================================
    group('toRelativeString', () {
      test('should return "just now" for close dates', () {
        final now = DateTime.now();
        expect(DateTimeHelper.toRelativeString(now), 'just now');
      });

      test('should return "X minutes ago"', () {
        final now = DateTime.now();
        final past = now.subtract(const Duration(minutes: 5));
        expect(DateTimeHelper.toRelativeString(past), '5 minutes ago');
      });

      test('should return "in X minutes"', () {
        final now = DateTime.now();
        final future = now.add(const Duration(minutes: 5));
        expect(DateTimeHelper.toRelativeString(future), 'in 5 minutes');
      });
    });

    // =========================================================================
    // BOOLEAN CHECKS
    // =========================================================================
    group('Boolean Checks', () {
      test('isToday', () {
        expect(DateTimeHelper.isToday(DateTime.now()), true);
        expect(DateTimeHelper.isToday(DateTime(2000, 1, 1)), false);
      });

      test('isYesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(DateTimeHelper.isYesterday(yesterday), true);
      });

      test('isTomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(DateTimeHelper.isTomorrow(tomorrow), true);
      });
    });

    // =========================================================================
    // CONVENIENCE METHODS
    // =========================================================================
    group('Convenience', () {
      test('toDisplayString', () {
        final date = DateTime(2024, 1, 15);
        expect(DateTimeHelper.toDisplayString(date), '15 Jan 2024');
      });

      test('toTimeString', () {
        final date = DateTime(2024, 1, 15, 14, 30);
        expect(DateTimeHelper.toTimeString(date, use24Hour: true), '14:30');
        expect(DateTimeHelper.toTimeString(date, use24Hour: false), '02:30 PM');
      });
    });
  });
}
