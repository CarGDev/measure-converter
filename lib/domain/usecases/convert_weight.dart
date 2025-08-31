class ConvertWeight {
  double kilogramsToPounds(double kilograms) {
    if (kilograms < 0) {
      throw ArgumentError('Weight cannot be negative');
    }
    return kilograms * 2.20462;
  }

  double poundsToKilograms(double pounds) {
    if (pounds < 0) {
      throw ArgumentError('Weight cannot be negative');
    }
    return pounds * 0.453592;
  }

  double convert(double value, String fromUnit, String toUnit) {
    if (value < 0) {
      throw ArgumentError('Weight cannot be negative');
    }

    final normalizedFromUnit = _normalizeUnit(fromUnit);
    final normalizedToUnit = _normalizeUnit(toUnit);

    if (normalizedFromUnit == normalizedToUnit) {
      return value;
    }

    switch (normalizedFromUnit) {
      case 'kg':
        if (normalizedToUnit == 'lbs') {
          return kilogramsToPounds(value);
        }
        break;
      case 'lbs':
        if (normalizedToUnit == 'kg') {
          return poundsToKilograms(value);
        }
        break;
    }

    throw ArgumentError('Unsupported conversion from $fromUnit to $toUnit');
  }

  String _normalizeUnit(String unit) {
    final lowerUnit = unit.toLowerCase().trim();
    switch (lowerUnit) {
      case 'kilograms':
      case 'kilogram':
      case 'kg':
      case 'kgs':
        return 'kg';
      case 'pounds':
      case 'pound':
      case 'lbs':
      case 'lb':
        return 'lbs';
      default:
        throw ArgumentError('Unsupported weight unit: $unit');
    }
  }

  List<String> get availableUnits => ['kg', 'lbs'];

  Map<String, String> get unitDisplayNames => {
    'kg': 'Kilograms',
    'lbs': 'Pounds',
  };
}
