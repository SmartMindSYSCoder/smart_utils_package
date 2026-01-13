import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

enum TestStatus { active, pending, closed, multipleWords }

void main() {
  group('EnumConverter', () {
    // =========================================================================
    // FROM STRING
    // =========================================================================
    group('fromString', () {
      test('should convert valid strings case-insensitive (default)', () {
        expect(
          EnumConverter.fromString(
            value: 'active',
            values: TestStatus.values,
            defaultValue: TestStatus.closed,
          ),
          TestStatus.active,
        );

        expect(
          EnumConverter.fromString(
            value: 'PENDING',
            values: TestStatus.values,
            defaultValue: TestStatus.closed,
          ),
          TestStatus.pending,
        );
      });

      test('should define default value for invalid input', () {
        expect(
          EnumConverter.fromString(
            value: 'invalid',
            values: TestStatus.values,
            defaultValue: TestStatus.closed,
          ),
          TestStatus.closed,
        );
      });

      test('should handle case sensitivity when enabled', () {
        // Case sensitive ON -> 'ACTIVE' != TestStatus.active
        expect(
          EnumConverter.fromString(
            value: 'ACTIVE',
            values: TestStatus.values,
            defaultValue: TestStatus.closed,
            caseSensitive: true,
          ),
          TestStatus.closed, // Mismatch
        );
      });
    });

    // =========================================================================
    // FROM STRING OR NULL
    // =========================================================================
    group('fromStringOrNull', () {
      test('should return enum for valid strings', () {
        expect(
          EnumConverter.fromStringOrNull(
            value: 'active',
            values: TestStatus.values,
          ),
          TestStatus.active,
        );
      });

      test('should return null for invalid strings', () {
        expect(
          EnumConverter.fromStringOrNull(
            value: 'invalid',
            values: TestStatus.values,
          ),
          null,
        );
      });
    });

    // =========================================================================
    // TO DISPLAY NAME
    // =========================================================================
    group('toDisplayName', () {
      test('should title case enum names', () {
        expect(EnumConverter.toDisplayName(TestStatus.active), 'Active');
        expect(
          EnumConverter.toDisplayName(TestStatus.multipleWords),
          'Multiple Words',
        );
      });
    });

    // =========================================================================
    // BULK OPERATIONS
    // =========================================================================
    group('Bulk Operations', () {
      test('fromStringList convert list of strings', () {
        final result = EnumConverter.fromStringList(
          values: ['active', 'closed', 'invalid'],
          enumValues: TestStatus.values,
          defaultValue: TestStatus.pending,
        );

        expect(result, [
          TestStatus.active,
          TestStatus.closed,
          TestStatus.pending, // Default for 'invalid'
        ]);
      });

      test('toDisplayNameList convert list of enums', () {
        expect(
          EnumConverter.toDisplayNameList([
            TestStatus.active,
            TestStatus.multipleWords,
          ]),
          ['Active', 'Multiple Words'],
        );
      });
    });

    // =========================================================================
    // VALIDATION
    // =========================================================================
    group('Validation', () {
      test('isValidValue should return true for existing values', () {
        expect(
          EnumConverter.isValidValue(
            value: 'active',
            enumValues: TestStatus.values,
          ),
          true,
        );
      });

      test('isValidValue should return false for non-existing values', () {
        expect(
          EnumConverter.isValidValue(
            value: 'random',
            enumValues: TestStatus.values,
          ),
          false,
        );
      });
    });
  });
}
