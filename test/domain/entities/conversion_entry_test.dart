import 'package:flutter_test/flutter_test.dart';
import 'package:measure_converter/domain/entities/conversion_entry.dart';

void main() {
  group('ConversionEntry', () {
    final testEntry = ConversionEntry(
      id: 'test-id-123',
      userId: 'user-123',
      category: ConversionCategory.distance,
      fromUnit: 'miles',
      toUnit: 'km',
      inputValue: 10.0,
      outputValue: 16.0934,
      createdAt: DateTime.utc(2024, 1, 1, 12, 0, 0),
    );

    group('fromJson', () {
      test('should create ConversionEntry from valid JSON', () {
        final json = {
          'id': 'test-id-123',
          'user_id': 'user-123',
          'category': 'distance',
          'from_unit': 'miles',
          'to_unit': 'km',
          'input_value': 10.0,
          'output_value': 16.0934,
          'created_at': '2024-01-01T12:00:00.000Z',
        };

        final result = ConversionEntry.fromJson(json);

        expect(result.id, equals('test-id-123'));
        expect(result.userId, equals('user-123'));
        expect(result.category, equals(ConversionCategory.distance));
        expect(result.fromUnit, equals('miles'));
        expect(result.toUnit, equals('km'));
        expect(result.inputValue, equals(10.0));
        expect(result.outputValue, equals(16.0934));
        expect(result.createdAt, equals(DateTime.utc(2024, 1, 1, 12, 0, 0)));
      });

      test('should handle weight category', () {
        final json = {
          'id': 'test-id-456',
          'user_id': 'user-456',
          'category': 'weight',
          'from_unit': 'kg',
          'to_unit': 'lbs',
          'input_value': 5.0,
          'output_value': 11.0231,
          'created_at': '2024-01-01T12:00:00.000Z',
        };

        final result = ConversionEntry.fromJson(json);

        expect(result.category, equals(ConversionCategory.weight));
        expect(result.fromUnit, equals('kg'));
        expect(result.toUnit, equals('lbs'));
      });

      test('should throw error for invalid category', () {
        final json = {
          'id': 'test-id',
          'user_id': 'user-123',
          'category': 'invalid_category',
          'from_unit': 'miles',
          'to_unit': 'km',
          'input_value': 10.0,
          'output_value': 16.0934,
          'created_at': '2024-01-01T12:00:00.000Z',
        };

        expect(
          () => ConversionEntry.fromJson(json),
          throwsA(isA<StateError>()),
        );
      });
    });

    group('toJson', () {
      test('should convert ConversionEntry to JSON', () {
        final json = testEntry.toJson();

        expect(json['id'], equals('test-id-123'));
        expect(json['user_id'], equals('user-123'));
        expect(json['category'], equals('distance'));
        expect(json['from_unit'], equals('miles'));
        expect(json['to_unit'], equals('km'));
        expect(json['input_value'], equals(10.0));
        expect(json['output_value'], equals(16.0934));
        expect(json['created_at'], equals('2024-01-01T12:00:00.000Z'));
      });

      test('should handle weight category in JSON', () {
        final weightEntry = ConversionEntry(
          id: 'test-id-456',
          userId: 'user-456',
          category: ConversionCategory.weight,
          fromUnit: 'kg',
          toUnit: 'lbs',
          inputValue: 5.0,
          outputValue: 11.0231,
          createdAt: DateTime.utc(2024, 1, 1, 12, 0, 0),
        );

        final json = weightEntry.toJson();

        expect(json['category'], equals('weight'));
        expect(json['from_unit'], equals('kg'));
        expect(json['to_unit'], equals('lbs'));
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        final updatedEntry = testEntry.copyWith(
          inputValue: 20.0,
          outputValue: 32.1868,
        );

        expect(updatedEntry.id, equals(testEntry.id));
        expect(updatedEntry.userId, equals(testEntry.userId));
        expect(updatedEntry.category, equals(testEntry.category));
        expect(updatedEntry.fromUnit, equals(testEntry.fromUnit));
        expect(updatedEntry.toUnit, equals(testEntry.toUnit));
        expect(updatedEntry.inputValue, equals(20.0));
        expect(updatedEntry.outputValue, equals(32.1868));
        expect(updatedEntry.createdAt, equals(testEntry.createdAt));
      });

      test('should create copy with all fields updated', () {
        final updatedEntry = testEntry.copyWith(
          id: 'new-id',
          userId: 'new-user',
          category: ConversionCategory.weight,
          fromUnit: 'kg',
          toUnit: 'lbs',
          inputValue: 15.0,
          outputValue: 33.0693,
          createdAt: DateTime.utc(2024, 1, 2, 12, 0, 0),
        );

        expect(updatedEntry.id, equals('new-id'));
        expect(updatedEntry.userId, equals('new-user'));
        expect(updatedEntry.category, equals(ConversionCategory.weight));
        expect(updatedEntry.fromUnit, equals('kg'));
        expect(updatedEntry.toUnit, equals('lbs'));
        expect(updatedEntry.inputValue, equals(15.0));
        expect(updatedEntry.outputValue, equals(33.0693));
        expect(updatedEntry.createdAt, equals(DateTime.utc(2024, 1, 2, 12, 0, 0)));
      });
    });

    group('equality', () {
      test('should be equal to identical entry', () {
        final identicalEntry = ConversionEntry(
          id: 'test-id-123',
          userId: 'user-123',
          category: ConversionCategory.distance,
          fromUnit: 'miles',
          toUnit: 'km',
          inputValue: 10.0,
          outputValue: 16.0934,
          createdAt: DateTime.utc(2024, 1, 1, 12, 0, 0),
        );

        expect(testEntry, equals(identicalEntry));
        expect(testEntry.hashCode, equals(identicalEntry.hashCode));
      });

      test('should not be equal to different entry', () {
        final differentEntry = ConversionEntry(
          id: 'different-id',
          userId: 'user-123',
          category: ConversionCategory.distance,
          fromUnit: 'miles',
          toUnit: 'km',
          inputValue: 10.0,
          outputValue: 16.0934,
          createdAt: DateTime.utc(2024, 1, 1, 12, 0, 0),
        );

        expect(testEntry, isNot(equals(differentEntry)));
        expect(testEntry.hashCode, isNot(equals(differentEntry.hashCode)));
      });
    });

    group('toString', () {
      test('should return meaningful string representation', () {
        final string = testEntry.toString();

        expect(string, contains('test-id-123'));
        expect(string, contains('user-123'));
        expect(string, contains('distance'));
        expect(string, contains('miles'));
        expect(string, contains('km'));
        expect(string, contains('10.0'));
        expect(string, contains('16.0934'));
      });
    });
  });

  group('ConversionCategory', () {
    test('should have correct values', () {
      expect(ConversionCategory.values.length, equals(2));
      expect(ConversionCategory.values, contains(ConversionCategory.distance));
      expect(ConversionCategory.values, contains(ConversionCategory.weight));
    });

    test('should have correct display names', () {
      expect(ConversionCategory.distance.displayName, equals('Distance'));
      expect(ConversionCategory.weight.displayName, equals('Weight'));
    });
  });
}
