import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

class VersionCommand extends Command<void> {
  final AppLogger logger;

  VersionCommand(this.logger);

  @override
  String get name => 'version';

  @override
  String get description => 'Check the current version of Orbital Rapid CLI';

  @override
  void run() {
    // This could be pulled from pubspec.yaml in a real scenario
    logger.info('Orbital Rapid CLI v0.1.0');
  }
}
