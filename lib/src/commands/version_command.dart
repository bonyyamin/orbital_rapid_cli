import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

import 'package:orbital_rapid_cli/src/version.dart';

class VersionCommand extends Command<void> {
  final AppLogger logger;

  VersionCommand(this.logger);

  @override
  String get name => 'version';

  @override
  String get description => 'Check the current version of Orbital Rapid CLI';

  @override
  void run() {
    logger.info('Orbital Rapid CLI v$packageVersion');
  }
}
