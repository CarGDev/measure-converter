// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:measure_converter/app.dart';

void main() {
  testWidgets('Measures Converter app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MeasureConverterApp(),
      ),
    );

    // Verify that our app title is displayed.
    expect(find.text('Measures Converter'), findsOneWidget);

    // Verify that category buttons are displayed.
    expect(find.text('Distance'), findsOneWidget);
    expect(find.text('Weight'), findsOneWidget);

    // Verify that the value input field is displayed.
    expect(find.text('Value'), findsOneWidget);
    expect(find.text('Enter value to convert'), findsOneWidget);

    // Verify that unit selection fields are displayed.
    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);

    // Verify that the convert button is displayed.
    expect(find.text('Convert'), findsOneWidget);
  });
}
