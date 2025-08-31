import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:measure_converter/domain/entities/conversion_entry.dart';
import 'package:measure_converter/presentation/features/conversion/viewmodel/conversion_viewmodel.dart';

/// Main conversion view that displays the conversion interface
class ConversionView extends ConsumerStatefulWidget {
  const ConversionView({super.key});

  @override
  ConsumerState<ConversionView> createState() => _ConversionViewState();
}

class _ConversionViewState extends ConsumerState<ConversionView> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    
    // Clear error when user starts typing
    _textController.addListener(() {
      final viewModel = ref.read(conversionViewModelProvider.notifier);
      if (_textController.text.isNotEmpty) {
        viewModel.clearError();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversionViewModelProvider);
    final viewModel = ref.read(conversionViewModelProvider.notifier);

    // Update controller when state changes
    if (_textController.text != state.inputValue) {
      _textController.text = state.inputValue;
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measures Converter',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Selection
            _buildCategorySelector(context, state, viewModel),
            const SizedBox(height: 24),
            
            // Value Input
            _buildValueInput(context, state, viewModel),
            const SizedBox(height: 24),
            
            // Unit Selection
            _buildUnitSelection(context, state, viewModel),
            const SizedBox(height: 32),
            
            // Convert Button
            _buildConvertButton(context, state, viewModel),
            const SizedBox(height: 24),
            
            // Result Display
            _buildResultDisplay(context, state),
            const SizedBox(height: 24),
            
            // Error Display
            _buildErrorDisplay(context, state),
            const SizedBox(height: 24),
            
            // Conversion History
            Expanded(
              child: _buildConversionHistory(context, state, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(BuildContext context, ConversionState state, ConversionViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: ConversionCategory.values.map((category) {
            final isSelected = state.selectedCategory == category;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () => viewModel.changeCategory(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
                    foregroundColor: isSelected ? Colors.white : Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(category.displayName),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildValueInput(BuildContext context, ConversionState state, ConversionViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          onChanged: viewModel.updateInputValue,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter value to convert',
            border: const UnderlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitSelection(BuildContext context, ConversionState state, ConversionViewModel viewModel) {
    final availableUnits = viewModel.availableUnits;
    final unitDisplayNames = viewModel.unitDisplayNames;

    return Row(
      children: [
        // From Unit
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: state.fromUnit.isNotEmpty ? state.fromUnit : null,
                onChanged: (value) {
                  if (value != null) viewModel.updateFromUnit(value);
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                ),
                items: availableUnits.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unitDisplayNames[unit] ?? unit),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        
        // To Unit
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: state.toUnit.isNotEmpty ? state.toUnit : null,
                onChanged: (value) {
                  if (value != null) viewModel.updateToUnit(value);
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                ),
                items: availableUnits.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unitDisplayNames[unit] ?? unit),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConvertButton(BuildContext context, ConversionState state, ConversionViewModel viewModel) {
    final isDisabled = state.isLoading || !viewModel.isFormValid;
    
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: isDisabled ? null : viewModel.convert,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey[300] : Colors.blue,
          foregroundColor: isDisabled ? Colors.grey[600] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: state.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Convert',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildResultDisplay(BuildContext context, ConversionState state) {
    if (state.result == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Text(
        state.result!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildErrorDisplay(BuildContext context, ConversionState state) {
    if (state.error == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Text(
        state.error!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildConversionHistory(BuildContext context, ConversionState state, ConversionViewModel viewModel) {
    if (state.conversionHistory.isEmpty) {
      return const Center(
        child: Text(
          'No conversion history yet',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Conversions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: state.conversionHistory.length,
            itemBuilder: (context, index) {
              final entry = state.conversionHistory[index];
              return _buildHistoryItem(context, entry, viewModel);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, ConversionEntry entry, ConversionViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          '${entry.inputValue.toStringAsFixed(1)} ${entry.fromUnit} → ${entry.outputValue.toStringAsFixed(3)} ${entry.toUnit}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${entry.category.displayName} • ${_formatDate(entry.createdAt)}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => viewModel.deleteHistoryEntry(entry.id),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
