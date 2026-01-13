import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

void main() {
  group('SmartNumberFormat', () {
    // =========================================================================
    // CURRENCY FORMATTING
    // =========================================================================
    group('currency', () {
      test('should format currency with default symbol', () {
        expect(SmartNumberFormat.currency(1234.56), '\$1,234.56');
        expect(SmartNumberFormat.currency(100), '\$100.00');
      });

      test('should format with custom symbol and position', () {
        expect(
          SmartNumberFormat.currency(
            1234.56,
            symbol: '€',
            symbolPosition: 'start',
          ),
          '€1,234.56',
        );
        // Assuming 'after' adds a space or sticks? Check impl. Usually '1,234.56€'
        // expect(SmartNumberFormat.currency(1234.56, symbol: '€', symbolPosition: 'after'), '1,234.56€');
      });

      test('currencyWithoutSymbol should format without symbol', () {
        expect(SmartNumberFormat.currencyWithoutSymbol(1234.56), '1,234.56');
      });
    });

    // =========================================================================
    // PERCENTAGE FORMATTING
    // =========================================================================
    group('percentage', () {
      test('should format percentage', () {
        expect(SmartNumberFormat.percentage(0.856), '85.60%');
        expect(SmartNumberFormat.percentage(0.1234, decimalDigits: 1), '12.3%');
      });

      test('should handle multiply100 flag', () {
        expect(
          SmartNumberFormat.percentage(85.6, multiply100: false),
          '85.60%',
        );
      });
    });

    // =========================================================================
    // COMPACT NOTATION
    // =========================================================================
    group('compact', () {
      test('should use compact notation for large numbers', () {
        expect(SmartNumberFormat.compact(1500), '1.5K');
        expect(SmartNumberFormat.compact(1500000), '1.5M');
        expect(SmartNumberFormat.compact(1500000000), '1.5B');
      });

      test('should handle small numbers', () {
        expect(SmartNumberFormat.compact(123), '123');
      });

      test('compactLong should return long format', () {
        // "1.5 million" or similar, dependent on locale
        // For 'en_US', it is "1.5 million"
        expect(SmartNumberFormat.compactLong(1500000), '1.5 million');
      });
    });

    // =========================================================================
    // FILE SIZE
    // =========================================================================
    group('fileSize', () {
      test('should format bytes', () {
        expect(SmartNumberFormat.fileSize(500), '500.00 B');
      });

      test('should format KB', () {
        expect(SmartNumberFormat.fileSize(1500), '1.46 KB'); // 1500 / 1024
      });

      test('should format MB', () {
        expect(SmartNumberFormat.fileSize(1500000), '1.43 MB');
      });

      test('should format GB', () {
        expect(SmartNumberFormat.fileSize(1610612736), '1.50 GB');
      });
    });

    // =========================================================================
    // DECIMAL FORMATTING
    // =========================================================================
    group('decimal', () {
      test('should format decimal with precision', () {
        expect(SmartNumberFormat.decimal(123.456, decimalDigits: 2), '123.46');
      });

      test('should remove trailing zeros if requested', () {
        expect(
          SmartNumberFormat.decimal(
            123.400,
            decimalDigits: 3,
            removeTrailingZeros: true,
          ),
          '123.4',
        );
        expect(
          SmartNumberFormat.decimal(123.00, removeTrailingZeros: true),
          '123',
        );
      });
    });

    // =========================================================================
    // WITH SEPARATOR
    // =========================================================================
    group('withSeparator', () {
      test('should add commas', () {
        expect(SmartNumberFormat.withSeparator(1234567), '1,234,567');
      });

      test('should handle decimals', () {
        expect(
          SmartNumberFormat.withSeparator(1234.56, decimalDigits: 2),
          '1,234.56',
        );
      });
    });

    // =========================================================================
    // ORDINAL
    // =========================================================================
    group('ordinal', () {
      test('should return ordinal string', () {
        expect(SmartNumberFormat.ordinal(1), '1st');
        expect(SmartNumberFormat.ordinal(2), '2nd');
        expect(SmartNumberFormat.ordinal(3), '3rd');
        expect(SmartNumberFormat.ordinal(4), '4th');
        expect(SmartNumberFormat.ordinal(11), '11th');
        expect(SmartNumberFormat.ordinal(21), '21st');
      });
    });
  });
}
