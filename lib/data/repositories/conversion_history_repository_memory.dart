import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:measure_converter/domain/entities/conversion_entry.dart';
import 'package:measure_converter/domain/repositories/conversion_history_repository.dart';

/// In-memory implementation of the ConversionHistoryRepository
/// This provides temporary storage during app sessions
class ConversionHistoryRepositoryMemory implements ConversionHistoryRepository {
  final Map<String, List<ConversionEntry>> _userHistory = {};
  final StreamController<List<ConversionEntry>> _historyController = StreamController<List<ConversionEntry>>.broadcast();

  @override
  Future<void> addEntry(ConversionEntry entry) async {
    final userHistory = _userHistory[entry.userId] ?? [];
    userHistory.insert(0, entry); // Add to beginning for most recent first
    
    // Keep only the last 20 entries
    if (userHistory.length > 20) {
      userHistory.removeRange(20, userHistory.length);
    }
    
    _userHistory[entry.userId] = userHistory;
    _historyController.add(userHistory);
  }

  @override
  Stream<List<ConversionEntry>> watchRecent({int limit = 20}) {
    return _historyController.stream.map((history) => 
      history.take(limit).toList()
    );
  }

  @override
  Future<void> deleteEntry(String id) async {
    for (final userId in _userHistory.keys) {
      final userHistory = _userHistory[userId]!;
      userHistory.removeWhere((entry) => entry.id == id);
      _userHistory[userId] = userHistory;
      _historyController.add(userHistory);
    }
  }

  @override
  Future<List<ConversionEntry>> getEntriesForUser(String userId) async {
    return _userHistory[userId] ?? [];
  }

  @override
  Future<void> clearHistoryForUser(String userId) async {
    _userHistory[userId] = [];
    _historyController.add([]);
  }

  void dispose() {
    _historyController.close();
  }
}

/// Provider for the in-memory ConversionHistoryRepository
final conversionHistoryRepositoryMemoryProvider = Provider<ConversionHistoryRepository>((ref) {
  return ConversionHistoryRepositoryMemory();
});
