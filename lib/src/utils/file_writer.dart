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
    if (dryRun) {
      _printDryRun(files, outputPath);
      return;
    }

    final outputDir = Directory(outputPath);

    // Handle in-place generation (directory already exists)
    if (outputDir.existsSync()) {
      logger.info('Writing files to existing directory: $outputPath');
      for (final f in files) {
        final dest = File(path.join(outputPath, f.relativePath));
        dest.createSync(recursive: true);
        dest.writeAsStringSync(f.content);
      }
      return;
    }

    // Handle separate generation (new directory)
    final tempDir = Directory.systemTemp.createTempSync('orbitalRapid_');
    try {
      for (final f in files) {
        final dest = File(path.join(tempDir.path, f.relativePath));
        dest.createSync(recursive: true);
        dest.writeAsStringSync(f.content);
      }

      try {
        // Attempt atomic move
        tempDir.renameSync(outputPath);
      } catch (e) {
        // Fallback for cross-drive moves (OS Error: errno = 17 on Windows)
        if (e is FileSystemException) {
          _copyDirectory(tempDir, Directory(outputPath));
          tempDir.deleteSync(recursive: true);
        } else {
          rethrow;
        }
      }
    } catch (e) {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
      rethrow;
    }
  }

  void _copyDirectory(Directory source, Directory destination) {
    destination.createSync(recursive: true);
    source.listSync(recursive: false).forEach((entity) {
      if (entity is Directory) {
        final newDirectory = Directory(
            path.join(destination.absolute.path, path.basename(entity.path)));
        _copyDirectory(entity, newDirectory);
      } else if (entity is File) {
        entity.copySync(
            path.join(destination.absolute.path, path.basename(entity.path)));
      }
    });
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
