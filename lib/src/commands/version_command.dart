import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

import 'package:orbital_rapid_cli/src/version.dart';

/// The command responsible for displaying the current CLI version.
class VersionCommand extends Command<void> {
  /// The logger used for outputting feedback.
  final AppLogger logger;

  /// Creates a [VersionCommand] instance.
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

