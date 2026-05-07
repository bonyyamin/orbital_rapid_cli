// Writes all GeneratedFile objects atomically (all or nothing)
import 'dart:io';

import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';
import 'package:path/path.dart' as path;

class FileWriter {
  final bool dryRun;
  final AppLogger logger;

  FileWriter({required this.dryRun, required this.logger});

  Future<void> writeAll(List<GeneratedFile> files, String outputPath) async {
    if (dryRun) { _printDryRun(files, outputPath); return; }

    final tempDir = Directory.systemTemp.createTempSync('orbitalRapid_');
    try {
      for (final f in files) {
        final dest = File(path.join(tempDir.path, f.relativePath));
        dest.createSync(recursive: true);
        dest.writeAsStringSync(f.content);
      }
      // Move entire temp dir to output path atomically
      if (Directory(outputPath).existsSync()) {
        throw OutputExistsException(outputPath);
      }
      tempDir.renameSync(outputPath);
    } catch (e) {
      tempDir.deleteSync(recursive: true);
      rethrow;
    }
  }

  void _printDryRun(List<GeneratedFile> files, String outputPath) {
    logger.info('DRY RUN — files that would be created:');
    for (final f in files) {
      logger.info('  ${f.relativePath}');
    }
    logger.info('\nTotal: ${files.length} files → $outputPath/');
  }
}

class OutputExistsException implements Exception {
  final String path;
  OutputExistsException(this.path);
  @override
  String toString() => 'Output directory already exists: $path';
}