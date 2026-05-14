import 'dart:io';
import 'dart:isolate';
import 'package:mustache_template/mustache.dart';
import 'package:path/path.dart' as path;

/// A service responsible for loading and rendering Mustache templates.
///
/// It handles resolving template files within the package structure and
/// injecting variables into them.
class TemplateEngine {
  /// Renders a template located at [templatePath] using the provided [vars].
  ///
  /// The [templatePath] should be relative to `lib/src/`.
  Future<String> render(String templatePath, Map<String, dynamic> vars) async {
    final source = await _loadTemplate(templatePath);
    final template = Template(source, lenient: true);
    return template.renderString(vars);
  }

  Future<String> _loadTemplate(String relativePath) async {
    final packageRoot = await _resolvePackageRoot();
    
    // Use the 'path' package to join paths correctly for the current OS (Windows)
    final fullPath = path.normalize(path.join(packageRoot, 'lib', 'src', relativePath));
    final file = File(fullPath);
    
    if (!file.existsSync()) {
      // If it fails, show the EXACT path so we can debug
      throw TemplateNotFoundException('Tried searching at: $fullPath');
    }
    return file.readAsStringSync();
  }

  /// Resolves the CLI package root by asking the Dart runtime where
  /// [package:orbital_rapid_cli] lives. This is correct regardless of the
  /// current working directory, which lets users run `orbitalRapid init` from
  /// any directory.
  Future<String> _resolvePackageRoot() async {
    // 1. Try to resolve via package URI
    final packageUri = Uri.parse('package:orbital_rapid_cli/orbital_rapid_cli.dart');
    final resolvedUri = await Isolate.resolvePackageUri(packageUri);
    if (resolvedUri != null && resolvedUri.scheme == 'file') {
      return File(resolvedUri.toFilePath()).parent.parent.path;
    }

    // 2. Fallback: Try to resolve via Platform.script (useful for global activate)
    final scriptPath = Platform.script.toFilePath();
    if (scriptPath.endsWith('.dart') || scriptPath.endsWith('.snapshot')) {
      // If running from bin/orbital_rapid.dart, root is two levels up
      final binDir = File(scriptPath).parent;
      if (binDir.path.endsWith('bin')) {
        return binDir.parent.path;
      }
    }

    // 3. Last resort: current directory (for development)
    return Directory.current.path;
  }
}

/// Exception thrown when a requested template file cannot be found.
class TemplateNotFoundException implements Exception {
  /// The path where the template was expected to be found.
  final String path;

  /// Creates a [TemplateNotFoundException] for the given [path].
  TemplateNotFoundException(this.path);

  @override
  String toString() => 'Template not found: $path';
}