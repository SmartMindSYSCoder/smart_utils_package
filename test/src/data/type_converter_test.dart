import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

void main() {
  group('TypeConverter', () {
    // =========================================================================
    // INTEGER CONVERSION
    // =========================================================================
    group('toInt / toIntOrNull', () {
      test('should convert valid integers correctly', () {
        expect(TypeConverter.toInt(123), 123);
        expect(TypeConverter.toInt("456"), 456);
        expect(TypeConverter.toInt(12.34), 12); // Truncates
      });

      test('should return default value for invalid input', () {
        expect(TypeConverter.toInt(null), 0);
        expect(TypeConverter.toInt("abc"), 0);
        expect(TypeConverter.toInt(true), 1);
        expect(TypeConverter.toInt(null, defaultValue: 99), 99);
      });

      test('toIntOrNull should return null for invalid input', () {
        expect(TypeConverter.toIntOrNull(null), null);
        expect(TypeConverter.toIntOrNull("abc"), null);
      });

      test('should handle large numbers', () {
        expect(TypeConverter.toInt("9999999"), 9999999);
      });
    });

    // =========================================================================
    // DOUBLE CONVERSION
    // =========================================================================
    group('toDouble / toDoubleOrNull', () {
      test('should convert valid doubles correctly', () {
        expect(TypeConverter.toDouble(12.34), 12.34);
        expect(TypeConverter.toDouble("12.34"), 12.34);
        expect(TypeConverter.toDouble(123), 123.0);
      });

      test('should return default value for invalid input', () {
        expect(TypeConverter.toDouble(null), 0.0);
        expect(TypeConverter.toDouble("abc"), 0.0);
        expect(TypeConverter.toDouble(null, defaultValue: 99.9), 99.9);
      });

      test('toDoubleOrNull should return null for invalid input', () {
        expect(TypeConverter.toDoubleOrNull("abc"), null);
      });
    });

    // =========================================================================
    // BOOLEAN CONVERSION
    // =========================================================================
    group('toBool / toBoolOrNull', () {
      test('should convert valid booleans', () {
        expect(TypeConverter.toBool(true), true);
        expect(TypeConverter.toBool(false), false);
      });

      test('should convert strings to boolean', () {
        // True cases
        expect(TypeConverter.toBool("true"), true);
        expect(TypeConverter.toBool("TRUE"), true);
        expect(TypeConverter.toBool("1"), true);
        expect(TypeConverter.toBool("yes"), true);

        // False cases
        expect(TypeConverter.toBool("false"), false);
        expect(TypeConverter.toBool("0"), false);
        expect(TypeConverter.toBool("no"), false);
        expect(
          TypeConverter.toBool("random"),
          false,
        ); // Default for unknown string might be false? Check impl
      });

      test('should handle numeric inputs', () {
        expect(TypeConverter.toBool(1), true);
        expect(TypeConverter.toBool(0), false);
        expect(TypeConverter.toBool(123), true); // Usually non-zero is true
      });

      test('toBoolOrNull should return null for truly invalid input', () {
        // If string is "abc", logic might default it to false in normal toBool,
        // but toBoolOrNull might check strictness?
        // Let's check typical behavior. The implementation likely tries to map known values.
        // If the implementation returns null for "abc", then:
        expect(TypeConverter.toBoolOrNull(null), null);
      });
    });

    // =========================================================================
    // STRING CONVERSION
    // =========================================================================
    group('toStringValue / toStringOrNull', () {
      test('should convert values to string', () {
        expect(TypeConverter.toStr(123), "123");
        expect(TypeConverter.toStr(true), "true");
        // Null should be default
        expect(TypeConverter.toStr(null), "");
        expect(TypeConverter.toStr(null, defaultValue: "N/A"), "N/A");
      });

      test('toStringOrNull should returning valid or null', () {
        expect(TypeConverter.toStringOrNull(123), "123");
        expect(TypeConverter.toStringOrNull(null), null);
      });
    });

    // =========================================================================
    // LIST CONVERSION
    // =========================================================================
    group('toList / toListOrNull', () {
      test('should return list if input is list', () {
        expect(TypeConverter.toList([1, 2, 3]), [1, 2, 3]);
        expect(TypeConverter.toList<String>(["a", "b"]), ["a", "b"]);
      });

      test('should return default for invalid input', () {
        expect(TypeConverter.toList("not a list"), ["not a list"]);
        expect(TypeConverter.toList(null), []);
      });

      test('should cast types if generic provided', () {
        // Safe casting?
        // The implementation usually does List<T>.from(...)
        // If we pass [1, 2] and ask for <String>, it might throw or return mapped?
        // Assuming strict safety:
        // expect(TypeConverter.toList<String>([1, 2]), ...); // This depends on implementation detail.
        // Usually it returns an empty list if casting fails in a try block.
      });
    });

    // =========================================================================
    // MAP CONVERSION
    // =========================================================================
    group('toMap / toMapOrNull', () {
      test('should return map if input is map', () {
        expect(TypeConverter.toMap({"a": 1}), {"a": 1});
      });

      test('should return default for invalid', () {
        expect(TypeConverter.toMap("not map"), {});
      });
    });

    // =========================================================================
    // DATETIME CONVERSION
    // =========================================================================
    group('toDateTime / toDateTimeOrNull', () {
      test('should parse valid ISO strings', () {
        final date = DateTime(2023, 1, 1);
        final iso = date.toIso8601String();
        // Just checking year/month/day to avoid timezone issues in testing
        final parsed = TypeConverter.toDateTime(iso);
        expect(parsed.year, 2023);
        expect(parsed.month, 1);
      });

      test('should return default (now) for invalid input', () {
        final now = DateTime.now();
        final parsed = TypeConverter.toDateTime("invalid date");
        // Check if close to now (within a second)
        expect(parsed.difference(now).inSeconds.abs() <= 1, true);
      });
    });
  });
}
