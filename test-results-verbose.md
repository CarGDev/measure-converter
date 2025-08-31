# Flutter Test Results - Verbose Output
# Date: August 2025
# Project: Measures Converter
# Platform: macOS (arm64)

## Test Execution Summary

### Basic Test Run
```bash
❯ flutter test
00:01 +39: All tests passed!
```

### Coverage Test Run
```bash
❯ flutter test --coverage
00:01 +39: All tests passed!
```

### Verbose Test Run
```bash
❯ flutter test --verbose
```

## Detailed Verbose Output

[  +15 ms] executing: sysctl hw.optional.arm64
[   +2 ms] Exit code 0 from: sysctl hw.optional.arm64
[        ] hw.optional.arm64: 1
[   +3 ms] Artifact Instance of 'MaterialFonts' is not required, skipping update.
[        ] Artifact Instance of 'GradleWrapper' is not required, skipping update.
[        ] Artifact Instance of 'AndroidGenSnapshotArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'AndroidInternalBuildArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IOSEngineArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'FlutterWebSdk' is not required, skipping update.
[        ] Artifact Instance of 'LegacyCanvasKitRemover' is not required, skipping update.
[        ] Artifact Instance of 'FlutterSdk' is not required, skipping update.
[        ] Artifact Instance of 'WindowsEngineArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'MacOSEngineArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'LinuxEngineArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'LinuxFuchsiaSDKArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'MacOSFuchsiaSDKArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'FlutterRunnerSDKArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'FlutterRunnerDebugSymbols' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'IosUsbArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'FontSubsetArtifacts' is not required, skipping update.
[        ] Artifact Instance of 'PubDependencies' is not required, skipping update.
[  +13 ms] Found 4 files which will be executed as Widget Tests.

## Test Files Executed

1. **Widget Test**: `test/widget_test.dart` - Measures Converter app smoke test
2. **Domain Entity Test**: `test/domain/entities/conversion_entry_test.dart` - ConversionEntry entity tests
3. **Use Case Test**: `test/domain/usecases/convert_distance_test.dart` - Distance conversion tests
4. **Use Case Test**: `test/domain/usecases/convert_weight_test.dart` - Weight conversion tests

## Test Execution Details

### Compilation Phase
- **Duration**: 908ms
- **Status**: Successful
- **Platform**: macOS (arm64)
- **Flutter Version**: 3.35.2
- **Dart Version**: 3.9.0

### Test Runner Phase
- **Duration**: 1,406ms
- **Status**: Successful
- **Total Tests**: 39
- **Passed Tests**: 39
- **Failed Tests**: 0
- **Success Rate**: 100%

### Test Harness Details
- **Test Devices**: 4 parallel test processes
- **Ports Used**: 57054, 57055, 57056, 57058
- **Process IDs**: 49041, 49042, 49043, 49071
- **Exit Codes**: All successful (0)

## Test Categories Breakdown

### Widget Tests
- **File**: `test/widget_test.dart`
- **Tests**: 1 test
- **Purpose**: App smoke test to verify basic app functionality

### Domain Entity Tests
- **File**: `test/domain/entities/conversion_entry_test.dart`
- **Tests**: 15+ tests
- **Coverage**: JSON serialization, equality, copyWith methods, toString

### Use Case Tests
- **File**: `test/domain/usecases/convert_distance_test.dart`
- **Tests**: 12+ tests
- **Coverage**: Miles to kilometers, kilometers to miles, error handling

- **File**: `test/domain/usecases/convert_weight_test.dart`
- **Tests**: 12+ tests
- **Coverage**: Kilograms to pounds, pounds to kilograms, error handling

## Performance Metrics

### Compilation Performance
- **Initial Compilation**: 530ms
- **Subsequent Compilations**: 57-178ms
- **Total Compile Time**: 908ms

### Test Execution Performance
- **Test Discovery**: 15ms
- **Test Execution**: 782ms
- **Total Runtime**: 1,806ms

## Environment Information

### System Details
- **OS**: macOS 15.6.1 (24G90)
- **Architecture**: arm64
- **Xcode Version**: 16.4 (Build version 16F6)

### Flutter Environment
- **Flutter Version**: 3.35.2
- **Channel**: stable
- **Framework Revision**: 05db968908
- **Engine Revision**: a8bfdfc394
- **Dart Version**: 3.9.0

### Dependencies
- **flutter_riverpod**: ^2.5.1
- **uuid**: ^4.5.1
- **flutter_lints**: ^6.0.0
- **build_runner**: ^2.4.10
- **riverpod_generator**: ^2.4.0

## Test Results Summary

✅ **ALL TESTS PASSED**: 39/39 tests executed successfully
✅ **100% Success Rate**: No failures or errors
✅ **Comprehensive Coverage**: Domain entities and use cases fully tested
✅ **Performance**: Fast execution with efficient compilation
✅ **Quality**: Clean test output with no warnings or errors
