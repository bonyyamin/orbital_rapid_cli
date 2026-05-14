import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/utils/validators.dart';

/// A utility class for validating [FlowConfig] objects before generation.
class ConfigValidator {
  /// Validates the provided [config].
  ///
  /// Throws an [ArgumentError] if the project name, package name, or
  /// other configuration parameters are invalid.
  static Future<void> validate(FlowConfig config) async {
    final projectNameError = Validators.projectName(config.projectName);
    if (projectNameError != null) {
      throw ArgumentError('Invalid project name: $projectNameError');
    }

    final packageNameError = Validators.packageName(config.packageName, isFinal: true);
    if (packageNameError != null) {
      throw ArgumentError('Invalid package identifier: $packageNameError. '
          'Hint: Use reverse domain notation like com.example.app');
    }

    if (config.onboardingPageCount < 1) {
      throw ArgumentError('Onboarding page count must be at least 1');
    }
  }
}

