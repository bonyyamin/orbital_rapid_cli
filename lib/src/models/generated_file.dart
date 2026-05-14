/// Supported file types for generation.
enum FileType {
  /// Dart source code.
  dart,

  /// YAML configuration files.
  yaml,

  /// Markdown documentation files.
  markdown,

  /// JSON data files.
  json,

  /// XML configuration files.
  xml
}

/// Represents a file that has been generated in memory but not yet written to disk.
class GeneratedFile {
  /// The path of the file relative to the project root.
  final String relativePath;

  /// The string content of the file.
  final String content;

  /// The type of the file.
  final FileType type;

  /// Creates a [GeneratedFile] instance.
  const GeneratedFile({
    required this.relativePath,
    required this.content,
    required this.type,
  });
}