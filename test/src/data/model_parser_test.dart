import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

// Simple model for testing
class TestModel {
  final int id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(id: json['id'] as int, name: json['name'] as String);
  }
}

void main() {
  group('ModelParser', () {
    // =========================================================================
    // PARSE OBJECT
    // =========================================================================
    group('parseObject', () {
      test('should parse from Map', () {
        final map = {'id': 1, 'name': 'Test'};
        final result = ModelParser.parseObject<TestModel>(
          map,
          TestModel.fromJson,
        );
        expect(result.id, 1);
        expect(result.name, 'Test');
      });

      test('should parse from String', () {
        final json = '{"id": 1, "name": "Test"}';
        final result = ModelParser.parseObject<TestModel>(
          json,
          TestModel.fromJson,
        );
        expect(result.id, 1);
        expect(result.name, 'Test');
      });

      test('should throw if input is not Map or valid String', () {
        expect(
          () => ModelParser.parseObject<TestModel>(123, TestModel.fromJson),
          throwsA(isA<FormatException>()),
        );
        expect(
          () => ModelParser.parseObject<TestModel>("[]", TestModel.fromJson),
          throwsA(isA<FormatException>()),
        );
      });
    });

    // =========================================================================
    // PARSE LIST
    // =========================================================================
    group('parseList', () {
      test('should parse from List', () {
        final list = [
          {'id': 1, 'name': 'One'},
          {'id': 2, 'name': 'Two'},
        ];
        final result = ModelParser.parseList<TestModel>(
          list,
          TestModel.fromJson,
        );
        expect(result.length, 2);
        expect(result[0].name, 'One');
        expect(result[1].name, 'Two');
      });

      test('should parse from String', () {
        final json = '[{"id": 1, "name": "One"}, {"id": 2, "name": "Two"}]';
        final result = ModelParser.parseList<TestModel>(
          json,
          TestModel.fromJson,
        );
        expect(result.length, 2);
      });

      test('should throw if input is not List', () {
        expect(
          () => ModelParser.parseList<TestModel>({}, TestModel.fromJson),
          throwsA(isA<FormatException>()),
        );
      });
    });
  });
}
