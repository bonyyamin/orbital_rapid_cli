// Writes all GeneratedFile objects atomically (all or nothing)
class FileWriter {
  final bool dryRun;
  final AppLogger logger;

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