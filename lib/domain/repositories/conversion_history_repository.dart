import 'package:measure_converter/domain/entities/conversion_entry.dart';

abstract class ConversionHistoryRepository {
  Future<void> addEntry(ConversionEntry entry);
  Stream<List<ConversionEntry>> watchRecent({int limit = 20});
  Future<void> deleteEntry(String id);
  Future<List<ConversionEntry>> getEntriesForUser(String userId);
  Future<void> clearHistoryForUser(String userId);
}
