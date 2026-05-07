// All interactive prompts live here
import 'package:orbital_rapid_cli/src/utils/logger.dart';

class PromptService {
  final AppLogger logger;

  Future<FlowConfig> collectConfig() async {
    logger.printBanner();

    final projectName = Input(
      prompt: 'Project name',
      validator: Validators.projectName,
    ).interact();

    final packageName = Input(
      prompt: 'Package identifier (e.g. com.company.app)',
      validator: Validators.packageName,
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

    // ... more prompts for onboarding pages, dark mode, l10n

    return ConfigBuilder.fromAnswers(
      projectName: projectName,
      packageName: packageName,
      stateManagement: StateManagement.values[stateIndex],
      backend: Backend.values[backendIndex],
      screens: screenIndices.map((i) => Screen.values[i]).toList(),
      // ...
    );
  }
}