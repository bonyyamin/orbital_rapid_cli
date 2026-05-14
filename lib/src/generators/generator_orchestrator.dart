import 'dart:io';
import 'package:orbital_rapid_cli/src/engine/pubspec_injector.dart';
import 'package:orbital_rapid_cli/src/engine/template_engine.dart';
import 'package:orbital_rapid_cli/src/generators/account/delete_account_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/forgot_password_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/login_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/register_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/verify_email_generator.dart';
import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/generators/home_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth_provider_generator.dart';
import 'package:orbital_rapid_cli/src/generators/core/constants_generator.dart';
import 'package:orbital_rapid_cli/src/generators/main_generator.dart';
import 'package:orbital_rapid_cli/src/generators/core/network_generator.dart';
import 'package:orbital_rapid_cli/src/generators/pubspec_generator.dart';
import 'package:orbital_rapid_cli/src/generators/core/service_generator.dart';
import 'package:orbital_rapid_cli/src/generators/theme_generator.dart';
import 'package:orbital_rapid_cli/src/generators/shared_generator.dart';
import 'package:orbital_rapid_cli/src/generators/utils_generator.dart';
import 'package:orbital_rapid_cli/src/generators/onboarding_generator.dart';
import 'package:orbital_rapid_cli/src/generators/splash_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/utils/file_writer.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

/// The primary class responsible for orchestrating the entire project generation flow.
///
/// It resolves the necessary generators based on the configuration, collects
/// the generated files and dependencies, and manages the final writing process.
class GeneratorOrchestrator {
  /// The project configuration.
  final FlowConfig config;

  /// The logger used for reporting generation progress.
  final AppLogger logger;

  /// Creates a [GeneratorOrchestrator] instance.
  GeneratorOrchestrator({
    required this.config,
    required this.logger,
  });

  /// Runs the generation process.
  ///
  /// This includes:
  /// 1. Resolving which generators to run.
  /// 2. Executing each generator to produce in-memory files.
  /// 3. Writing those files to the disk using [FileWriter].
  /// 4. Injecting required dependencies into `pubspec.yaml`.
  Future<void> generate() async {
    // Validate and warn for in-place generation
    if (config.isInplace) {
      await _validateInplaceGeneration();
    }

    final engine = TemplateEngine();
    final args = (config: config, engine: engine, logger: logger);

    final generators = _resolveGenerators(args);
    final allFiles = <GeneratedFile>[];
    final allDeps = <Dependency>[];

    for (final gen in generators) {
      final progress = logger.progress('Generating ${gen.name}...');
      try {
        final files = await gen.generate();
        allFiles.addAll(files);
        allDeps.addAll(gen.requiredDependencies);
        progress.complete('✅ ${gen.name}');
      } catch (e) {
        progress.fail('❌ ${gen.name}: $e');
        rethrow;
      }
    }

    final writerProgress =
        logger.progress('Writing files to ${config.outputPath}...');
    try {
      await FileWriter(dryRun: config.dryRun, logger: logger)
          .writeAll(allFiles, config.outputPath);
      writerProgress.complete('✅ Files written');
    } catch (e) {
      writerProgress.fail('❌ Failed to write files: $e');
      rethrow;
    }

    if (!config.dryRun) {
      final pubspecProgress =
          logger.progress('Injecting dependencies into pubspec.yaml...');
      try {
        PubspecInjector.inject(
          projectPath: config.outputPath,
          dependencies: allDeps,
        );
        pubspecProgress.complete('✅ Dependencies injected');
      } catch (e) {
        pubspecProgress.fail('❌ Failed to inject dependencies: $e');
      }
    }
  }


  List<BaseGenerator> _resolveGenerators(
      ({FlowConfig config, TemplateEngine engine, AppLogger logger}) args) {
    return [
      UtilsGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      ThemeGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      SharedGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      ConstantsGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      ServiceGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      if (config.isRest)
        NetworkGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      MainGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      HomeGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      AuthProviderGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      PubspecGenerator(
          config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.splash))
        SplashGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.onboarding))
        OnboardingGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.login))
        LoginGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.register))
        RegisterGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.verifyEmail))
        VerifyEmailGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.forgotPassword))
        ForgotPasswordGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.accountDeletion))
        DeleteAccountGenerator(
            config: args.config, engine: args.engine, logger: args.logger),
    ];
  }

  Future<void> _validateInplaceGeneration() async {
    final currentDir = Directory('.');
    final files = await currentDir.list().toList();

    // Check for common Flutter files that might conflict
    final conflictingFiles = files.where((entity) {
      if (entity is File) {
        final name = entity.path.split('/').last.toLowerCase();
        return name == 'pubspec.yaml' ||
            name == 'main.dart' ||
            name.startsWith('android/') ||
            name.startsWith('ios/') ||
            name.startsWith('lib/');
      }
      return false;
    }).toList();

    if (conflictingFiles.isNotEmpty) {
      logger.warn(
          '⚠️  Warning: In-place generation may overwrite existing files!');
      logger.warn('   Found potential conflicts in current directory:');
      for (final file in conflictingFiles.take(5)) {
        logger.warn('   - ${file.path}');
      }
      if (conflictingFiles.length > 5) {
        logger.warn('   ... and ${conflictingFiles.length - 5} more');
      }

      // Continue anyway since user explicitly chose in-place
      logger.info('   Continuing with in-place generation...');
    }
  }
}
