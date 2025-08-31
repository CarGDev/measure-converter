import 'package:flutter_test/flutter_test.dart';
import 'package:measure_converter/domain/usecases/convert_weight.dart';

void main() {
  group('ConvertWeight', () {
    late ConvertWeight converter;

    setUp(() {
      converter = ConvertWeight();
    });

    group('kilogramsToPounds', () {
      test('should convert kilograms to pounds correctly', () {
        // Test basic conversion
        final result = converter.kilogramsToPounds(1.0);
        expect(result, closeTo(2.20462, 0.001));

        // Test zero
        final zeroResult = converter.kilogramsToPounds(0.0);
        expect(zeroResult, equals(0.0));

        // Test large number
        final largeResult = converter.kilogramsToPounds(100.0);
        expect(largeResult, closeTo(220.462, 0.001));
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.kilogramsToPounds(-1.0),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.kilogramsToPounds(-100.0),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle decimal values correctly', () {
        final result = converter.kilogramsToPounds(0.5);
        expect(result, closeTo(1.10231, 0.001));

        final result2 = converter.kilogramsToPounds(2.5);
        expect(result2, closeTo(5.51155, 0.001));
      });
    });

    group('poundsToKilograms', () {
      test('should convert pounds to kilograms correctly', () {
        // Test basic conversion
        final result = converter.poundsToKilograms(1.0);
        expect(result, closeTo(0.453592, 0.001));

        // Test zero
        final zeroResult = converter.poundsToKilograms(0.0);
        expect(zeroResult, equals(0.0));

        // Test large number
        final largeResult = converter.poundsToKilograms(100.0);
        expect(largeResult, closeTo(45.3592, 0.001));
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.poundsToKilograms(-1.0),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.poundsToKilograms(-100.0),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle decimal values correctly', () {
        final result = converter.poundsToKilograms(0.5);
        expect(result, closeTo(0.226796, 0.001));

        final result2 = converter.poundsToKilograms(2.5);
        expect(result2, closeTo(1.13398, 0.001));
      });
    });

    group('convert', () {
      test('should convert between different units correctly', () {
        // Kilograms to pounds
        final kgToLbs = converter.convert(10.0, 'kg', 'lbs');
        expect(kgToLbs, closeTo(22.0462, 0.001));

        // Pounds to kilograms
        final lbsToKg = converter.convert(10.0, 'lbs', 'kg');
        expect(lbsToKg, closeTo(4.53592, 0.001));
      });

      test('should return same value when converting to same unit', () {
        final result1 = converter.convert(10.0, 'kg', 'kg');
        expect(result1, equals(10.0));

        final result2 = converter.convert(10.0, 'lbs', 'lbs');
        expect(result2, equals(10.0));
      });

      test('should handle unit variations', () {
        // Test different ways to write kilograms
        final result1 = converter.convert(1.0, 'kilogram', 'lbs');
        final result2 = converter.convert(1.0, 'kgs', 'lbs');
        expect(result1, equals(result2));

        // Test different ways to write pounds
        final result3 = converter.convert(1.0, 'kg', 'pound');
        final result4 = converter.convert(1.0, 'kg', 'lb');
        expect(result3, equals(result4));
      });

      test('should throw error for unsupported conversions', () {
        expect(
          () => converter.convert(10.0, 'kg', 'miles'),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.convert(10.0, 'miles', 'kg'),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.convert(-10.0, 'kg', 'lbs'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('availableUnits', () {
      test('should return correct list of units', () {
        final units = converter.availableUnits;
        expect(units, containsAll(['kg', 'lbs']));
        expect(units.length, equals(2));
      });
    });

    group('unitDisplayNames', () {
      test('should return correct display names', () {
        final displayNames = converter.unitDisplayNames;
        expect(displayNames['kg'], equals('Kilograms'));
        expect(displayNames['lbs'], equals('Pounds'));
        expect(displayNames.length, equals(2));
      });
    });
  });
}
