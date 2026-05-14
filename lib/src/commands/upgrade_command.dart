import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

/// The command responsible for self-upgrading the CLI.
///
/// It uses `dart pub global activate` to fetch the latest version from pub.dev.
class UpgradeCommand extends Command<void> {
  /// The logger used for outputting progress and feedback.
  final AppLogger logger;

  /// Creates an [UpgradeCommand] instance.
  UpgradeCommand(this.logger);

  @override
  String get name => 'upgrade';

  @override
  String get description => 'Upgrade Orbital Rapid CLI to the latest version';

  @override
  Future<void> run() async {
    final progress = logger.progress('Upgrading Orbital Rapid CLI...');
    
    try {
      final result = await Process.run('dart', ['pub', 'global', 'activate', 'orbital_rapid_cli']);
      
      if (result.exitCode == 0) {
        progress.complete('✅ Successfully upgraded to the latest version');
      } else {
        progress.fail('❌ Failed to upgrade: ${result.stderr}');
      }
    } catch (e) {
      progress.fail('❌ An error occurred during upgrade: $e');
    }
  }
}

