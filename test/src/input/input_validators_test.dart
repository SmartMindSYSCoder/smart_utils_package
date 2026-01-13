import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

void main() {
  group('SmartInputValidators', () {
    // =========================================================================
    // REQUIRED
    // =========================================================================
    test('required', () {
      final validator = SmartInputValidators.required('Field Name');
      expect(validator(null), isA<String>());
      expect(validator(""), isA<String>());
      expect(validator("text"), isNull);
    });

    // =========================================================================
    // EMAIL
    // =========================================================================
    test('email', () {
      final validator = SmartInputValidators.email();
      expect(validator("test@email.com"), isNull);
      expect(validator("invalid"), isA<String>());

      // Test required=false
      final optionalValidator = SmartInputValidators.email(required: false);
      expect(optionalValidator(""), isNull); // Empty is valid if not required
      expect(
        optionalValidator("invalid"),
        isA<String>(),
      ); // If value provided, must be valid
    });

    // =========================================================================
    // NAME
    // =========================================================================
    test('name', () {
      final validator = SmartInputValidators.name(minLength: 3);
      expect(validator("Jo"), isA<String>()); // Too short
      expect(validator("John"), isNull);
      expect(validator("John123"), isA<String>()); // Invalid chars
    });

    // =========================================================================
    // MOBILE
    // =========================================================================
    test('mobile', () {
      final validator = SmartInputValidators.mobile(minLength: 5);
      expect(validator("123"), isA<String>()); // Too short
      expect(validator("12345"), isNull);
      expect(validator("abc"), isA<String>()); // Not digits
    });

    // =========================================================================
    // NUMERIC
    // =========================================================================
    test('numeric', () {
      final validator = SmartInputValidators.numeric();
      expect(validator("123"), isNull);
      expect(validator("abc"), isA<String>());

      // Integers only by default
      expect(validator("12.34"), isA<String>());

      // Allow decimal
      final decimalValidator = SmartInputValidators.numeric(allowDecimal: true);
      expect(decimalValidator("12.34"), isNull);
    });

    // =========================================================================
    // PASSWORD & CONFIRM
    // =========================================================================
    test('password', () {
      final validator = SmartInputValidators.password(
        minLength: 5,
        requireUppercase: true,
      );
      expect(validator("pass"), isA<String>()); // Too short
      expect(validator("password"), isA<String>()); // No uppercase
      expect(validator("Password"), isNull);
    });

    test('confirmPassword', () {
      final original = "Secret";
      final validator = SmartInputValidators.confirmPassword(original);
      expect(validator("Secret"), isNull);
      expect(validator("Wrong"), isA<String>());
    });

    // =========================================================================
    // CUSTOM
    // =========================================================================
    test('custom - pattern', () {
      final validator = SmartInputValidators.custom(
        pattern: RegExp(r'^[A-Z]+$'),
      );
      expect(validator("ABC"), isNull);
      expect(validator("Abc"), isA<String>());
    });

    test('custom - min/max length', () {
      final validator = SmartInputValidators.custom(minLength: 3, maxLength: 5);
      expect(validator("Hi"), isA<String>());
      expect(validator("Hello"), isNull);
      expect(validator("Hello World"), isA<String>());
    });

    test('custom - customValidator callback', () {
      final validator = SmartInputValidators.custom(
        customValidator: (val) => val == "magic" ? null : "Not magic",
      );
      expect(validator("magic"), isNull);
      expect(validator("normal"), "Not magic");
    });
  });
}
