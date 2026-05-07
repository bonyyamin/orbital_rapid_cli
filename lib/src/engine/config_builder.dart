// Assembles FlowConfig from user prompt answers
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
}