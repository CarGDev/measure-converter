import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/features/conversion/view/conversion_view.dart';

/// Main application widget
class MeasureConverterApp extends ConsumerWidget {
  const MeasureConverterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        ),
      ),
      home: const ConversionView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
