import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/generators/generator_orchestrator.dart';
import 'package:orbital_rapid_cli/src/engine/prompt_service.dart';
import 'package:orbital_rapid_cli/src/engine/yaml_config_loader.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';
import 'package:collection/collection.dart';

/// The command responsible for adding new screens to an existing project.
///
/// This command looks for an `orbitalRapid.yaml` file in the current directory
/// to understand the project's configuration before generating the new screen.
class AddCommand extends Command<void> {
  /// The logger used for outputting progress and feedback.
  final AppLogger logger;

  /// Creates an [AddCommand] and defines its expected arguments and flags.
  AddCommand(this.logger) {
    argParser.addFlag('dry-run', help: 'Show what files would be generated', defaultsTo: false);
  }

  @override
  String get name => 'add';

  @override
  String get description => 'Add a screen to an existing Flutter project';

  @override
  Future<void> run() async {
    final screenName = argResults!.rest.firstOrNull;
    if (screenName == null) {
      usageException('Please specify a screen: orbitalRapid add <screen>');
    }

    final screen = Screen.values.firstWhereOrNull((s) => s.key == screenName);
    if (screen == null) {
      usageException('Unknown screen: $screenName. Available: ${Screen.values.map((s) => s.key).join(", ")}');
    }

    // Load config from orbitalRapid.yaml or prompt
    final baseConfig = YamlConfigLoader.tryLoad('./orbitalRapid.yaml')
        ?? await PromptService(logger: logger).collectConfig();

    // We only want to generate the specific screen
    final config = baseConfig.copyWith(
      screens: [screen],
      outputPath: '.',
      dryRun: argResults!['dry-run'] as bool? ?? false,
    );

    await GeneratorOrchestrator(config: config, logger: logger).generate();
    
    logger.success('\n✅ Screen "$screenName" added successfully!');
  }
}

