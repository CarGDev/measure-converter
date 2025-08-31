# Measures Converter

A Flutter unit conversion application built with Clean Architecture, MVVM pattern, and Riverpod state management. The app converts between **miles ↔ kilometers** and **kilograms ↔ pounds** with a beautiful, modern UI.

## Features

- **Distance Conversions**: Miles ↔ Kilometers
- **Weight Conversions**: Kilograms ↔ Pounds
- **Clean Architecture**: Separation of concerns with clear boundaries
- **MVVM Pattern**: ViewModel-based state management
- **Riverpod**: Modern state management and dependency injection
- **Conversion History**: Track and manage your conversion history
- **Responsive UI**: Beautiful Material Design 3 interface

## Screenshots

### Android
![Android Start App](assets/Androing%20start%20app.png)
*Android app startup screen*

![Android Measurements](assets/Androing%20measurements.png)
*Android measurement conversion interface*

### iOS
![iPhone Start App](assets/Iphone%20start%20app.png)
*iOS app startup screen*

![iPhone Measurements](assets/Iphone%203%20measurements.png)
*iOS measurement conversion interface*

![iPhone Measurement Log](assets/Iphone%20measurement%20log.png)
*iOS conversion history log*

![iPhone Measurement Log 2](assets/Iphone%20measurement%20log%202.png)
*iOS detailed conversion history*

## Architecture Overview

This project follows **Clean Architecture** principles with a **lite** implementation:

```
lib/
├── data/           # Data layer (repositories, datasources)
├── domain/         # Business logic (entities, use cases)
└── presentation/   # UI layer (views, viewmodels)
```

### Design Patterns

- **MVVM (Model-View-ViewModel)**: Separation of UI logic from business logic
- **Repository Pattern**: Abstract data access layer
- **Dependency Injection**: Using Riverpod providers
- **Observer Pattern**: Reactive state management

### State Management

- **Riverpod**: Modern, type-safe state management
- **NotifierProvider**: For complex state logic
- **Provider**: For simple dependencies

## Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS Simulator (macOS) or Android Emulator

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/CarGDev/measure-converter
cd measure_converter
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
# iOS Simulator (macOS)
cd ios && pod install && cd ../
flutter run -d "iPhone 16 Plus"

# Android Emulator
flutter run -d emulator-5554
```

## Project Structure

```
lib/
├── data/
│   └── repositories/
│       └── conversion_history_repository_memory.dart  # Repository implementation
├── domain/
│   ├── entities/
│   │   └── conversion_entry.dart     # Conversion history entity
│   ├── repositories/
│   │   └── conversion_history_repository.dart  # Repository interface
│   └── usecases/
│       ├── convert_distance.dart     # Distance conversion logic
│       └── convert_weight.dart       # Weight conversion logic
├── presentation/
│   └── features/
│       └── conversion/
│           ├── view/
│           │   └── conversion_view.dart      # Main UI
│           └── viewmodel/
│               └── conversion_viewmodel.dart # Business logic
├── app.dart                           # App configuration
└── main.dart                          # Entry point
```

## Testing

Run the test suite:

```bash
# Unit tests
flutter test

# With coverage
flutter test --coverage
```

### Test Results

✅ **All tests passing**: 39/39 tests passed successfully

**Test Coverage:**
- **Domain Entities**: `ConversionEntry` - Complete test coverage for JSON serialization, equality, and utility methods
- **Use Cases**: `ConvertDistance` and `ConvertWeight` - Comprehensive testing of all conversion methods
- **Business Logic**: All conversion calculations tested with edge cases and error conditions

**Test Categories:**
- **Unit Tests**: 39 tests covering core business logic
- **Entity Tests**: JSON serialization/deserialization, equality, copyWith methods
- **Use Case Tests**: Distance and weight conversion accuracy and error handling
- **Edge Cases**: Negative values, invalid units, boundary conditions

**Quality Metrics:**
- **Code Analysis**: 1 minor warning (unused import in test file)
- **Test Reliability**: 100% pass rate
- **Error Handling**: Comprehensive validation and error testing

**Detailed Test Results:**
For complete test execution details, performance metrics, and verbose output, see: [`test-results-verbose.md`](test-results-verbose.md)

**Deployment Logs:**
For detailed build and deployment logs showing successful cross-platform deployment, see: [`deployment-logs.md`](deployment-logs.md)

### Testing Commands

#### **General Unit Tests (All Platforms)**
```bash
# Run all unit tests (recommended for development)
flutter test

# Run tests with coverage report
flutter test --coverage

# Run tests with verbose output
flutter test --verbose

# Run specific test file
flutter test test/domain/entities/conversion_entry_test.dart

# Run tests matching a pattern
flutter test --name="ConvertDistance"
```

#### **Platform-Specific Testing**
```bash
# Android Testing
flutter test --device-id=emulator-5554
flutter test --platform=android

# iOS Testing  
flutter test --device-id=D0ED3562-795F-4942-A67E-9A202F4ABCCB
flutter test --platform=ios
```

#### **Advanced Testing Options**
```bash
# Run tests with specific tags
flutter test --tags="unit"

# Run tests excluding specific tags
flutter test --exclude-tags="integration"

# Run tests with custom test timeout
flutter test --timeout=60s

# Run tests and generate HTML coverage report
flutter test --coverage --coverage-path=coverage/lcov.info

# Run tests for CI/CD pipeline
flutter test --coverage --reporter=json
```

#### **Recommended Testing Workflow**
1. **During Development**: Use `flutter test` for quick feedback
2. **Before Committing**: Use `flutter test --coverage` to ensure good coverage
3. **CI/CD**: Use platform-specific commands for automated testing
4. **Debugging**: Use `flutter test --verbose` for detailed output

## Code Quality

The project follows Flutter best practices:

- **Effective Dart**: Following official Dart style guidelines
- **Flutter Lints**: Using `flutter_lints` package
- **Code Formatting**: `dart format` for consistent code style
- **Documentation**: Comprehensive Dartdoc comments

## Dependencies

### Core Dependencies
- `flutter_riverpod`: State management
- `uuid`: Unique ID generation

### Development Dependencies
- `build_runner`: Code generation
- `riverpod_generator`: Riverpod code generation
- `flutter_lints`: Code quality rules

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For questions or issues:
- Create an issue in the repository
- Check the [Flutter documentation](https://flutter.dev/docs)
- Review [Riverpod documentation](https://riverpod.dev)

## Acknowledgments

- Built with [Flutter](https://flutter.dev)
- State management with [Riverpod](https://riverpod.dev)
- Following Clean Architecture principles by Robert C. Martin
