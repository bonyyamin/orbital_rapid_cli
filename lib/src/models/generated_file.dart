enum FileType { dart, yaml, markdown, json, xml }

class GeneratedFile {
  final String relativePath;
  final String content;
  final FileType type;
  const GeneratedFile({ required this.relativePath,
                        required this.content,
                        required this.type });
}