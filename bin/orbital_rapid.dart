import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/commands/add_command.dart';
import 'package:orbital_rapid_cli/src/commands/init_command.dart';
import 'package:orbital_rapid_cli/src/commands/upgrade_command.dart';
import 'package:orbital_rapid_cli/src/commands/version_command.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

import 'package:orbital_rapid_cli/src/version.dart';

Future<void> main(List<String> arguments) async {
  final logger = AppLogger();
  
  final runner = CommandRunner<void>(
    'orbitalRapid',
    'Generate Flutter splash/onboarding/auth flows with Riverpod, BLoC, or GetX',
  )
    ..addCommand(InitCommand(logger))
    ..addCommand(AddCommand(logger))
    ..addCommand(VersionCommand(logger))
    ..addCommand(UpgradeCommand(logger))
    ..argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the current version.',
    );

  try {
    final results = runner.argParser.parse(arguments);
    if (results['version'] == true) {
      logger.info('Orbital Rapid CLI v$packageVersion');
      return;
    }

    await runner.run(arguments);
  } on UsageException catch (e) {
    logger.err(e.message);
    logger.info('\n${e.usage}');
    exit(64);
  } catch (e, st) {
    logger.err('An unexpected error occurred: $e');
    logger.info(st.toString());
    exit(1);
  }
}
