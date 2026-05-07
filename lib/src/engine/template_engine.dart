import 'dart:io';
import 'package:mustache_template/mustache.dart';
import 'package:path/path.dart' as path;

class TemplateEngine {
  Future<String> render(String templatePath, Map<String, dynamic> vars) async {
    final source = await _loadTemplate(templatePath);
    final template = Template(source, lenient: true);
    return template.renderString(vars);
  }

  Future<String> _loadTemplate(String relativePath) async {
    final packageRoot = _resolvePackageRoot();
    final file = File(path.join(packageRoot, 'lib/src', relativePath));
    if (!file.existsSync()) {
      throw TemplateNotFoundException(relativePath);
    }
    return file.readAsStringSync();
  }

  String _resolvePackageRoot() {
    // For local development and 'dart run', the current directory or a known path is used.
    // In a real published package, you'd use Isolate.resolvePackageUri or similar.
    // For this CLI, we assume templates are in the same directory as the lib folder.
    return Directory.current.path;
  }
}

class TemplateNotFoundException implements Exception {
  final String path;
  TemplateNotFoundException(this.path);
  @override
  String toString() => 'Template not found: $path';
}