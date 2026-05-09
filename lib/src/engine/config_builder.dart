import 'package:args/args.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/utils/string_utils.dart';

class ConfigBuilder {
  static FlowConfig fromAnswers({
    required String projectName,
    required String packageName,
    required StateManagement stateManagement,
    required Backend backend,
    required List<Screen> screens,
    required int onboardingPageCount,
    required bool hasDarkMode,
    required bool hasL10n,
    required bool generateTests,
    required bool dryRun,
    String? outputPath,
  }) {
    final snakeName = StringUtils.toSnakeCase(projectName);
    return FlowConfig(
      projectName: snakeName,
      projectNamePascal: StringUtils.toPascalCase(snakeName),
      packageName: packageName,
      outputPath: outputPath ?? './$snakeName',
      stateManagement: stateManagement,
      backend: backend,
      screens: screens,
      onboardingPageCount: onboardingPageCount,
      hasDarkMode: hasDarkMode,
      hasL10n: hasL10n,
      generateTests: generateTests,
      dryRun: dryRun,
    );
  }

  static FlowConfig fromArgs(ArgResults args) {
    final stateStr = args['state'] as String?;
    final backendStr = args['backend'] as String?;
    final screensStr = args['screens'] as String?;

    final stateManagement = StateManagement.values.firstWhere(
      (e) => e.key == stateStr,
      orElse: () => StateManagement.riverpod,
    );

    final backend = Backend.values.firstWhere(
      (e) => e.key == backendStr,
      orElse: () => Backend.none,
    );

    List<Screen> screens;
    if (screensStr == 'all') {
      screens = Screen.values;
    } else if (screensStr != null && screensStr.isNotEmpty) {
      final keys = screensStr.split(',').map((s) => s.trim());
      screens = Screen.values.where((s) => keys.contains(s.key)).toList();
    } else {
      screens = const [];
    }

    final name = args['name'] as String? ?? 'my_app';
    return fromAnswers(
      projectName: name,
      packageName: args['package'] as String? ?? name,
      stateManagement: stateManagement,
      backend: backend,
      screens: screens,
      onboardingPageCount:
          int.tryParse(args['onboarding-pages'] as String? ?? '3') ?? 3,
      hasDarkMode: args['dark-mode'] as bool? ?? true,
      hasL10n: args['l10n'] as bool? ?? false,
      generateTests: args['tests'] as bool? ?? true,
      dryRun: args['dry-run'] as bool? ?? false,
      outputPath: args['output'] as String?,
    );
  }
}
