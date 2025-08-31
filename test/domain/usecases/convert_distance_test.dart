import 'package:flutter_test/flutter_test.dart';
import 'package:measure_converter/domain/usecases/convert_distance.dart';

void main() {
  group('ConvertDistance', () {
    late ConvertDistance converter;

    setUp(() {
      converter = ConvertDistance();
    });

    group('milesToKilometers', () {
      test('should convert miles to kilometers correctly', () {
        // Test basic conversion
        final result = converter.milesToKilometers(1.0);
        expect(result, closeTo(1.60934, 0.001));

        // Test zero
        final zeroResult = converter.milesToKilometers(0.0);
        expect(zeroResult, equals(0.0));

        // Test large number
        final largeResult = converter.milesToKilometers(100.0);
        expect(largeResult, closeTo(160.934, 0.001));
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.milesToKilometers(-1.0),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.milesToKilometers(-100.0),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle decimal values correctly', () {
        final result = converter.milesToKilometers(0.5);
        expect(result, closeTo(0.80467, 0.001));

        final result2 = converter.milesToKilometers(2.5);
        expect(result2, closeTo(4.02335, 0.001));
      });
    });

    group('kilometersToMiles', () {
      test('should convert kilometers to miles correctly', () {
        // Test basic conversion
        final result = converter.kilometersToMiles(1.0);
        expect(result, closeTo(0.621371, 0.001));

        // Test zero
        final zeroResult = converter.kilometersToMiles(0.0);
        expect(zeroResult, equals(0.0));

        // Test large number
        final largeResult = converter.kilometersToMiles(100.0);
        expect(largeResult, closeTo(62.1371, 0.001));
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.kilometersToMiles(-1.0),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.kilometersToMiles(-100.0),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should handle decimal values correctly', () {
        final result = converter.kilometersToMiles(0.5);
        expect(result, closeTo(0.3106855, 0.001));

        final result2 = converter.kilometersToMiles(2.5);
        expect(result2, closeTo(1.5534275, 0.001));
      });
    });

    group('convert', () {
      test('should convert between different units correctly', () {
        // Miles to kilometers
        final milesToKm = converter.convert(10.0, 'miles', 'km');
        expect(milesToKm, closeTo(16.0934, 0.001));

        // Kilometers to miles
        final kmToMiles = converter.convert(10.0, 'km', 'miles');
        expect(kmToMiles, closeTo(6.21371, 0.001));
      });

      test('should return same value when converting to same unit', () {
        final result1 = converter.convert(10.0, 'miles', 'miles');
        expect(result1, equals(10.0));

        final result2 = converter.convert(10.0, 'km', 'km');
        expect(result2, equals(10.0));
      });

      test('should handle unit variations', () {
        // Test different ways to write miles
        final result1 = converter.convert(1.0, 'mile', 'km');
        final result2 = converter.convert(1.0, 'mi', 'km');
        expect(result1, equals(result2));

        // Test different ways to write kilometers
        final result3 = converter.convert(1.0, 'miles', 'kilometer');
        final result4 = converter.convert(1.0, 'miles', 'kms');
        expect(result3, equals(result4));
      });

      test('should throw error for unsupported conversions', () {
        expect(
          () => converter.convert(10.0, 'miles', 'pounds'),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => converter.convert(10.0, 'kg', 'miles'),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw error for negative values', () {
        expect(
          () => converter.convert(-10.0, 'miles', 'km'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('availableUnits', () {
      test('should return correct list of units', () {
        final units = converter.availableUnits;
        expect(units, containsAll(['miles', 'km']));
        expect(units.length, equals(2));
      });
    });

    group('unitDisplayNames', () {
      test('should return correct display names', () {
        final displayNames = converter.unitDisplayNames;
        expect(displayNames['miles'], equals('Miles'));
        expect(displayNames['km'], equals('Kilometers'));
        expect(displayNames.length, equals(2));
      });
    });
  });
}
