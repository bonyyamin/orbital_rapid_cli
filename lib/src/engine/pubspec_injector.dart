// Safely adds dependencies to pubspec.yaml using yaml_edit
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