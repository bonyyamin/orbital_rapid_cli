// Loads .tmpl files from the package and renders them with mustache
class TemplateEngine {
  // Renders a template file with the given variables
  Future<String> render(String templatePath, Map<String, dynamic> vars) async {
    final source = await _loadTemplate(templatePath);
    final template = Template(source, lenient: true);
    return template.renderString(vars);
  }

  Future<String> _loadTemplate(String relativePath) async {
    // Templates are bundled inside the package
    // Load from package root using path resolution
    final packageRoot = _resolvePackageRoot();
    final file = File(path.join(packageRoot, 'lib/src', relativePath));
    if (!file.existsSync()) {
      throw TemplateNotFoundException(relativePath);
    }
    return file.readAsStringSync();
  }
}