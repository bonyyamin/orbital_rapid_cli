// All interactive prompts live here
import 'package:interact/interact.dart';
import 'package:orbital_rapid_cli/src/engine/config_builder.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';
import 'package:orbital_rapid_cli/src/utils/validators.dart';

class PromptService {
  final AppLogger logger;

  PromptService({required this.logger});

  Future<FlowConfig> collectConfig({bool dryRun = false}) async {
    logger.printBanner();

    // interact's Input validator must return bool (true = valid)
    final projectName = Input(
      prompt: 'Project name',
      validator: (v) => Validators.projectName(v) == null,
    ).interact();

    final packageName = Input(
      prompt: 'Package identifier (e.g. com.company.app)',
      validator: (v) => Validators.packageName(v) == null,
    ).interact();

    final stateIndex = Select(
      prompt: 'State management',
      options: StateManagement.values.map((e) => e.label).toList(),
    ).interact();

    final backendIndex = Select(
      prompt: 'Backend',
      options: Backend.values.map((e) => e.label).toList(),
    ).interact();

    final screenIndices = MultiSelect(
      prompt: 'Screens to generate',
      options: Screen.values.map((e) => e.label).toList(),
      defaults: List.filled(Screen.values.length, true),
    ).interact();

    final onboardingPageCount = int.parse(
      Input(
        prompt: 'Number of onboarding pages',
        defaultValue: '3',
        validator: (v) => int.tryParse(v) != null,
      ).interact(),
    );

    final hasDarkMode = Confirm(
      prompt: 'Enable dark mode?',
      defaultValue: true,
    ).interact();

    final hasL10n = Confirm(
      prompt: 'Enable localization (l10n)?',
      defaultValue: false,
    ).interact();

    final generateTests = Confirm(
      prompt: 'Generate tests?',
      defaultValue: true,
    ).interact();

    return ConfigBuilder.fromAnswers(
      projectName: projectName,
      packageName: packageName,
      stateManagement: StateManagement.values[stateIndex],
      backend: Backend.values[backendIndex],
      screens: screenIndices.map((i) => Screen.values[i]).toList(),
      onboardingPageCount: onboardingPageCount,
      hasDarkMode: hasDarkMode,
      hasL10n: hasL10n,
      generateTests: generateTests,
      dryRun: dryRun,
    );
  }
}