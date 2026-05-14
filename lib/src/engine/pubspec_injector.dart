// Safely adds dependencies to pubspec.yaml using yaml_edit
import 'dart:io';

import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:path/path.dart' as path;
import 'package:yaml_edit/yaml_edit.dart';

/// A utility class for safely modifying a project's `pubspec.yaml` file.
///
/// It uses the `yaml_edit` package to add or update dependencies without
/// destroying the existing formatting or comments in the YAML file.
class PubspecInjector {
  /// Injects a list of [dependencies] into the `pubspec.yaml` located
  /// at [projectPath].
  static void inject({
    required String projectPath,
    required List<Dependency> dependencies,
  }) {
    final file = File(path.join(projectPath, 'pubspec.yaml'));
    final content = file.readAsStringSync();
    final editor = YamlEditor(content);

    for (final dep in dependencies) {
      final section = dep.isDev ? 'dev_dependencies' : 'dependencies';
      try {
        editor.update([section, dep.name], dep.version);
      } catch (_) {
        // Node doesn't exist yet — add it
        editor.update([section, dep.name], dep.version);
      }
    }

    file.writeAsStringSync(editor.toString());
  }
}