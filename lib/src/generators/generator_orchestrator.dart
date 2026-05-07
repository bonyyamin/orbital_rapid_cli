import 'package:orbital_rapid_cli/src/engine/pubspec_injector.dart';
import 'package:orbital_rapid_cli/src/engine/template_engine.dart';
import 'package:orbital_rapid_cli/src/generators/account/delete_account_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/forgot_password_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/login_generator.dart';
import 'package:orbital_rapid_cli/src/generators/auth/register_generator.dart';
import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
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

class GeneratorOrchestrator {
  final FlowConfig config;
  final AppLogger logger;

  GeneratorOrchestrator({
    required this.config,
    required this.logger,
  });

  Future<void> generate() async {
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

    final writerProgress = logger.progress('Writing files to ${config.outputPath}...');
    try {
      await FileWriter(dryRun: config.dryRun, logger: logger)
          .writeAll(allFiles, config.outputPath);
      writerProgress.complete('✅ Files written');
    } catch (e) {
      writerProgress.fail('❌ Failed to write files: $e');
      rethrow;
    }

    if (!config.dryRun) {
      final pubspecProgress = logger.progress('Injecting dependencies into pubspec.yaml...');
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

  List<BaseGenerator> _resolveGenerators(({FlowConfig config, TemplateEngine engine, AppLogger logger}) args) {
    return [
      UtilsGenerator(config: args.config, engine: args.engine, logger: args.logger),
      ThemeGenerator(config: args.config, engine: args.engine, logger: args.logger),
      SharedGenerator(config: args.config, engine: args.engine, logger: args.logger),
      ConstantsGenerator(config: args.config, engine: args.engine, logger: args.logger),
      ServiceGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.isRest)
        NetworkGenerator(config: args.config, engine: args.engine, logger: args.logger),
      MainGenerator(config: args.config, engine: args.engine, logger: args.logger),
      PubspecGenerator(config: args.config, engine: args.engine, logger: args.logger),
      
      if (config.screens.contains(Screen.splash))
        SplashGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.onboarding))
        OnboardingGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.login))
        LoginGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.register))
        RegisterGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.forgotPassword))
        ForgotPasswordGenerator(config: args.config, engine: args.engine, logger: args.logger),
      if (config.screens.contains(Screen.accountDeletion))
        DeleteAccountGenerator(config: args.config, engine: args.engine, logger: args.logger),
    ];
  }
}