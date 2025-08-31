class ConvertDistance {
  double milesToKilometers(double miles) {
    if (miles < 0) {
      throw ArgumentError('Distance cannot be negative');
    }
    return miles * 1.60934;
  }

  double kilometersToMiles(double kilometers) {
    if (kilometers < 0) {
      throw ArgumentError('Distance cannot be negative');
    }
    return kilometers * 0.621371;
  }

  double convert(double value, String fromUnit, String toUnit) {
    if (value < 0) {
      throw ArgumentError('Distance cannot be negative');
    }

    final normalizedFromUnit = _normalizeUnit(fromUnit);
    final normalizedToUnit = _normalizeUnit(toUnit);

    if (normalizedFromUnit == normalizedToUnit) {
      return value;
    }

    switch (normalizedFromUnit) {
      case 'miles':
        if (normalizedToUnit == 'km') {
          return milesToKilometers(value);
        }
        break;
      case 'km':
        if (normalizedToUnit == 'miles') {
          return kilometersToMiles(value);
        }
        break;
    }

    throw ArgumentError('Unsupported conversion from $fromUnit to $toUnit');
  }

  String _normalizeUnit(String unit) {
    final lowerUnit = unit.toLowerCase().trim();
    switch (lowerUnit) {
      case 'miles':
      case 'mile':
      case 'mi':
        return 'miles';
      case 'kilometers':
      case 'kilometer':
      case 'km':
      case 'kms':
        return 'km';
      default:
        throw ArgumentError('Unsupported distance unit: $unit');
    }
  }

  List<String> get availableUnits => ['miles', 'km'];

  Map<String, String> get unitDisplayNames => {
    'miles': 'Miles',
    'km': 'Kilometers',
  };
}
