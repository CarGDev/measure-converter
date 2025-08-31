import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:measure_converter/domain/entities/conversion_entry.dart';
import 'package:measure_converter/domain/usecases/convert_distance.dart';
import 'package:measure_converter/domain/usecases/convert_weight.dart';
import 'package:measure_converter/data/repositories/conversion_history_repository_memory.dart';

class ConversionState {
  final ConversionCategory selectedCategory;
  final String inputValue;
  final String fromUnit;
  final String toUnit;
  final String? result;
  final String? error;
  final bool isLoading;
  final List<ConversionEntry> conversionHistory;

  const ConversionState({
    this.selectedCategory = ConversionCategory.distance,
    this.inputValue = '',
    this.fromUnit = '',
    this.toUnit = '',
    this.result,
    this.error,
    this.isLoading = false,
    this.conversionHistory = const [],
  });

  ConversionState copyWith({
    ConversionCategory? selectedCategory,
    String? inputValue,
    String? fromUnit,
    String? toUnit,
    String? result,
    String? error,
    bool? isLoading,
    List<ConversionEntry>? conversionHistory,
  }) {
    return ConversionState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      inputValue: inputValue ?? this.inputValue,
      fromUnit: fromUnit ?? this.fromUnit,
      toUnit: toUnit ?? this.toUnit,
      result: result ?? this.result,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      conversionHistory: conversionHistory ?? this.conversionHistory,
    );
  }
}

class ConversionViewModel extends Notifier<ConversionState> {
  late final ConvertDistance _convertDistance;
  late final ConvertWeight _convertWeight;

  @override
  ConversionState build() {
    _convertDistance = ConvertDistance();
    _convertWeight = ConvertWeight();
    
    final initialState = _initializeDefaultValues();
    
    ref.listen(conversionHistoryRepositoryMemoryProvider, (previous, next) {
      _loadConversionHistory();
    });
    
    return initialState;
  }

  ConversionState _initializeDefaultValues() {
    return const ConversionState(
      selectedCategory: ConversionCategory.distance,
      fromUnit: 'miles',
      toUnit: 'km',
    );
  }

  void changeCategory(ConversionCategory category) {
    String fromUnit, toUnit;
    
    if (category == ConversionCategory.distance) {
      fromUnit = 'miles';
      toUnit = 'km';
    } else {
      fromUnit = 'kg';
      toUnit = 'lbs';
    }
    
    state = state.copyWith(
      selectedCategory: category,
      fromUnit: fromUnit,
      toUnit: toUnit,
      inputValue: '',
      result: null,
      error: null,
    );
  }

  void updateInputValue(String value) {
    state = state.copyWith(
      inputValue: value,
      result: null,
      error: null,
    );
  }

  void updateFromUnit(String unit) {
    String toUnit;
    
    if (state.selectedCategory == ConversionCategory.distance) {
      if (unit == 'miles') {
        toUnit = 'km';
      } else if (unit == 'km') {
        toUnit = 'miles';
      } else {
        toUnit = state.toUnit;
      }
    } else {
      if (unit == 'lbs') {
        toUnit = 'kg';
      } else if (unit == 'kg') {
        toUnit = 'lbs';
      } else {
        toUnit = state.toUnit;
      }
    }
    
    state = state.copyWith(
      fromUnit: unit,
      toUnit: toUnit,
      result: null,
      error: null,
    );
  }

  void updateToUnit(String unit) {
    String fromUnit;
    
    if (state.selectedCategory == ConversionCategory.distance) {
      if (unit == 'km') {
        fromUnit = 'miles';
      } else if (unit == 'miles') {
        fromUnit = 'km';
      } else {
        fromUnit = state.fromUnit;
      }
    } else {
      if (unit == 'kg') {
        fromUnit = 'lbs';
      } else if (unit == 'lbs') {
        fromUnit = 'kg';
      } else {
        fromUnit = state.fromUnit;
      }
    }
    
    state = state.copyWith(
      fromUnit: fromUnit,
      toUnit: unit,
      result: null,
      error: null,
    );
  }

  Future<void> convert() async {
    state = state.copyWith(error: null, result: null);
    
    if (state.inputValue.isEmpty) {
      state = state.copyWith(
        error: 'Please enter a value to convert',
        result: null,
      );
      return;
    }

    if (state.fromUnit.isEmpty || state.toUnit.isEmpty) {
      state = state.copyWith(
        error: 'Please select both units',
        result: null,
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: null, result: null);
      
      final inputValue = double.tryParse(state.inputValue);
      if (inputValue == null) {
        throw ArgumentError('Invalid input value');
      }

      double result;
      if (state.selectedCategory == ConversionCategory.distance) {
        result = _convertDistance.convert(inputValue, state.fromUnit, state.toUnit);
      } else {
        result = _convertWeight.convert(inputValue, state.fromUnit, state.toUnit);
      }

      final formattedResult = _formatResult(inputValue, result);
      state = state.copyWith(
        result: formattedResult,
        inputValue: '',
        isLoading: false,
        error: null,
      );

      await _saveToHistory(inputValue, result);
      
    } catch (e) {
      state = state.copyWith(
        error: 'Conversion failed: ${e.toString()}',
        result: null,
        isLoading: false,
      );
    }
  }

  String _formatResult(double inputValue, double result) {
    final category = state.selectedCategory;
    final fromUnit = state.fromUnit;
    final toUnit = state.toUnit;
    
    if (category == ConversionCategory.distance) {
      return '${inputValue.toStringAsFixed(1)} ${_getDisplayName(fromUnit)} are ${result.toStringAsFixed(3)} ${_getDisplayName(toUnit)}';
    } else {
      return '${inputValue.toStringAsFixed(1)} ${_getDisplayName(fromUnit)} are ${result.toStringAsFixed(3)} ${_getDisplayName(toUnit)}';
    }
  }

  String _getDisplayName(String unit) {
    if (state.selectedCategory == ConversionCategory.distance) {
      return _convertDistance.unitDisplayNames[unit] ?? unit;
    } else {
      return _convertWeight.unitDisplayNames[unit] ?? unit;
    }
  }

  Future<void> _saveToHistory(double inputValue, double result) async {
    try {
      // Use demo user ID for in-memory storage
      const effectiveUserId = 'demo-user-123';

      final entry = ConversionEntry(
        id: const Uuid().v4(),
        userId: effectiveUserId,
        category: state.selectedCategory,
        fromUnit: state.fromUnit,
        toUnit: state.toUnit,
        inputValue: inputValue,
        outputValue: result,
        createdAt: DateTime.now(),
      );

      final repository = ref.read(conversionHistoryRepositoryMemoryProvider);
      await repository.addEntry(entry);
      
      await _loadConversionHistory();
    } catch (e) {
      // Log error for debugging purposes
      debugPrint('Failed to save conversion to history: $e');
    }
  }

  Future<void> _loadConversionHistory() async {
    try {
      // Use demo user ID for in-memory storage
      const effectiveUserId = 'demo-user-123';

      final repository = ref.read(conversionHistoryRepositoryMemoryProvider);
      final history = await repository.getEntriesForUser(effectiveUserId);
      state = state.copyWith(conversionHistory: history);
    } catch (e) {
      // Log error for debugging purposes
      debugPrint('Failed to load conversion history: $e');
    }
  }

  List<String> get availableUnits {
    if (state.selectedCategory == ConversionCategory.distance) {
      return _convertDistance.availableUnits;
    } else {
      return _convertWeight.availableUnits;
    }
  }

  Map<String, String> get unitDisplayNames {
    if (state.selectedCategory == ConversionCategory.distance) {
      return _convertDistance.unitDisplayNames;
    } else {
      return _convertWeight.unitDisplayNames;
    }
  }

  bool get isFormValid {
    return state.inputValue.isNotEmpty && 
           state.fromUnit.isNotEmpty && 
           state.toUnit.isNotEmpty;
  }

  void clearResult() {
    state = state.copyWith(
      result: null,
      error: null,
    );
  }

  void clearInputValue() {
    state = state.copyWith(
      inputValue: '',
      result: null,
      error: null,
    );
  }

  void clearError() {
    state = state.copyWith(
      error: null,
    );
  }

  Future<void> deleteHistoryEntry(String id) async {
    try {
      final repository = ref.read(conversionHistoryRepositoryMemoryProvider);
      await repository.deleteEntry(id);
      await _loadConversionHistory();
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to delete history entry: ${e.toString()}',
      );
    }
  }
}

final conversionViewModelProvider = NotifierProvider<ConversionViewModel, ConversionState>(() {
  return ConversionViewModel();
});
