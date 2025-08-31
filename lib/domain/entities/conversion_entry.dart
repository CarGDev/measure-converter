/// Represents a conversion history entry stored in the database
class ConversionEntry {
  final String id;
  final String userId;
  final ConversionCategory category;
  final String fromUnit;
  final String toUnit;
  final double inputValue;
  final double outputValue;
  final DateTime createdAt;

  const ConversionEntry({
    required this.id,
    required this.userId,
    required this.category,
    required this.fromUnit,
    required this.toUnit,
    required this.inputValue,
    required this.outputValue,
    required this.createdAt,
  });

  /// Creates a ConversionEntry from a JSON map
  factory ConversionEntry.fromJson(Map<String, dynamic> json) {
    return ConversionEntry(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      category: ConversionCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
      fromUnit: json['from_unit'] as String,
      toUnit: json['to_unit'] as String,
      inputValue: (json['input_value'] as num).toDouble(),
      outputValue: (json['output_value'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Converts the ConversionEntry to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category': category.name,
      'from_unit': fromUnit,
      'to_unit': toUnit,
      'input_value': inputValue,
      'output_value': outputValue,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Creates a copy of this ConversionEntry with the given fields replaced
  ConversionEntry copyWith({
    String? id,
    String? userId,
    ConversionCategory? category,
    String? fromUnit,
    String? toUnit,
    double? inputValue,
    double? outputValue,
    DateTime? createdAt,
  }) {
    return ConversionEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      inputValue: inputValue ?? this.inputValue,
      outputValue: outputValue ?? this.outputValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversionEntry &&
        other.id == id &&
        other.userId == userId &&
        other.category == category &&
        other.fromUnit == fromUnit &&
        other.toUnit == toUnit &&
        other.inputValue == inputValue &&
        other.outputValue == outputValue &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      category,
      fromUnit,
      toUnit,
      inputValue,
      outputValue,
      createdAt,
    );
  }

  @override
  String toString() {
    return 'ConversionEntry(id: $id, userId: $userId, category: $category, '
        'fromUnit: $fromUnit, toUnit: $toUnit, inputValue: $inputValue, '
        'outputValue: $outputValue, createdAt: $createdAt)';
  }
}

/// Enum representing the category of conversion
enum ConversionCategory {
  distance,
  weight,
}

/// Extension to provide display names for conversion categories
extension ConversionCategoryExtension on ConversionCategory {
  String get displayName {
    switch (this) {
      case ConversionCategory.distance:
        return 'Distance';
      case ConversionCategory.weight:
        return 'Weight';
    }
  }
}
