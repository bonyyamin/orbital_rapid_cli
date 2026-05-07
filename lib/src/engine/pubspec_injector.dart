// Safely adds dependencies to pubspec.yaml using yaml_edit
import 'dart:io';

import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:path/path.dart' as path;
import 'package:yaml_edit/yaml_edit.dart';

class PubspecInjector {
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