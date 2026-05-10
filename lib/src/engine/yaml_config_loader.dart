import 'dart:io';
import 'package:orbital_rapid_cli/src/engine/config_builder.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:yaml/yaml.dart';

class YamlConfigLoader {
  static FlowConfig load(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('Config file not found', filePath);
    }

    final content = file.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap;

    final name = yaml['name'] ?? 'my_app';
    return ConfigBuilder.fromAnswers(
      projectName: name,
      packageName: yaml['package'] ?? name,
      stateManagement: StateManagement.values.firstWhere(
        (e) => e.key == yaml['state'],
        orElse: () => StateManagement.riverpod,
      ),
      backend: Backend.values.firstWhere(
        (e) => e.key == yaml['backend'],
        orElse: () => Backend.none,
      ),
      emailVerificationMethod: EmailVerificationMethod.values.firstWhere(
        (e) => e.key == yaml['email_verification'],
        orElse: () => EmailVerificationMethod.link,
      ),
      projectStructure: ProjectStructure.values.firstWhere(
        (e) => e.key == yaml['structure'],
        orElse: () => ProjectStructure.separate,
      ),
      screens: _parseScreens(yaml['screens']),
      socialProviders: _parseSocialProviders(yaml['social_providers']),
      onboardingPageCount: yaml['onboarding_pages'] ?? 3,
      hasDarkMode: yaml['dark_mode'] ?? true,
      hasL10n: yaml['l10n'] ?? false,
      generateTests: yaml['tests'] ?? true,
      dryRun: false, // Yaml config doesn't usually specify dry run
      outputPath: yaml['output'],
    );
  }

  static FlowConfig? tryLoad(String filePath) {
    try {
      return load(filePath);
    } catch (_) {
      return null;
    }
  }

  static List<Screen> _parseScreens(dynamic screens) {
    if (screens == null) return const [];
    if (screens == 'all') return Screen.values;
    if (screens is YamlList) {
      return Screen.values.where((s) => screens.contains(s.key)).toList();
    }
    return const [];
  }

  static List<SocialProvider> _parseSocialProviders(dynamic providers) {
    if (providers == null) return const [];
    if (providers == 'all') return SocialProvider.values;
    if (providers is YamlList) {
      return SocialProvider.values
          .where((s) => providers.contains(s.key))
          .toList();
    }
    return const [];
  }
}
