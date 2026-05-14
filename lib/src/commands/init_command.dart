import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/engine/config_builder.dart';
import 'package:orbital_rapid_cli/src/engine/config_validator.dart';
import 'package:orbital_rapid_cli/src/generators/generator_orchestrator.dart';
import 'package:orbital_rapid_cli/src/engine/prompt_service.dart';
import 'package:orbital_rapid_cli/src/engine/yaml_config_loader.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

/// The command responsible for initializing and scaffolding a new Flutter project.
///
/// This command collects configuration from command-line arguments, a YAML file,
/// or interactive prompts, and then orchestrates the generation process.
class InitCommand extends Command<void> {
  /// The logger used for outputting progress and feedback.
  final AppLogger logger;

  /// Creates an [InitCommand] and defines its expected arguments and flags.
  InitCommand(this.logger) {
    argParser
      ..addOption('name', abbr: 'n', help: 'Project name (snake_case)')
      ..addOption('package',
          abbr: 'p', help: 'Package identifier (e.g. com.company.app)')
      ..addOption('state',
          allowed: ['riverpod', 'bloc', 'getx'],
          help: 'State management library')
      ..addOption('backend',
          allowed: ['firebase', 'rest', 'supabase', 'none'],
          help: 'Backend service')
      ..addOption('screens', help: 'Comma-separated screens or "all"')
      ..addOption('social-providers',
          help:
              'Comma-separated social providers (google,facebook,apple,github) or "all"')
      ..addOption('config',
          abbr: 'c', help: 'Path to orbitalRapid.yaml config file')
      ..addOption('output', abbr: 'o', help: 'Output directory')
      ..addOption('onboarding-pages',
          help: 'Number of onboarding pages', defaultsTo: '3')
      ..addOption('structure',
          allowed: ['separate', 'inplace'],
          help:
              'Project structure: separate (new directory) or inplace (current directory)',
          defaultsTo: 'separate')
      ..addFlag('dark-mode', help: 'Enable dark mode support', defaultsTo: true)
      ..addFlag('l10n', help: 'Enable localization support', defaultsTo: false)
      ..addFlag('tests',
          help: 'Generate unit and widget tests', defaultsTo: true)
      ..addOption('email-verify',
          allowed: ['link', 'otp'],
          help: 'Email verification method',
          defaultsTo: 'link')
      ..addFlag('dry-run',
          help: 'Show what files would be generated without writing them',
          defaultsTo: false);
  }

  @override
  String get name => 'init';

  @override
  String get description => 'Scaffold a new Flutter project with auth flows';

  @override
  Future<void> run() async {
    _printWelcome();
    FlowConfig config;

    if (argResults!['config'] != null) {
      config = YamlConfigLoader.load(argResults!['config'] as String);
    } else if (_hasAllRequiredFlags()) {
      config = ConfigBuilder.fromArgs(argResults!);
    } else {
      config = await PromptService(logger: logger).collectConfig(
        dryRun: argResults!['dry-run'] as bool? ?? false,
      );
    }

    await ConfigValidator.validate(config);
    await GeneratorOrchestrator(config: config, logger: logger).generate();

    _printSuccess(config);
  }


  bool _hasAllRequiredFlags() {
    return argResults!['name'] != null;
  }

  void _printWelcome() {
    logger.info('''
   ____       _     _ _        _   ____                _     _ 
  / __ \\     | |   (_) |      | | |  _ \\              (_)   | |
 | |  | |_ __| |__  _| |_ __ _| | | |_) |__ _ _ __  _ _  __| |
 | |  | | '__| '_ \\| | __/ _` | | |  _ < / _` | '_ \\| | |/ _` |
 | |__| | |  | |_) | | || (_| | | | |_) | (_| | |_) | | | (_| |
  \\____/|_|  |_.__/|_|\\__\\__,_|_| |____/ \\__,_| .__/|_|_|\\__,_|
                                              | |              
                                              |_|              
    ''');
    logger.info('🚀 Welcome to Orbital Rapid CLI');
    logger.info('Scaffolding production-ready Flutter apps in seconds\n');
  }

  void _printSuccess(FlowConfig config) {
    logger.success('\n✅ Project generated at ./${config.projectName}/');
    logger.info('\nNext steps:');
    logger.info('  cd ${config.projectName}');
    logger.info('  flutter pub get');
    logger.info('  flutter run');
    logger.info('\nCustomize your design system:');
    logger.info('  lib/core/utils/ ← change colors, fonts, strings here');
  }
}
