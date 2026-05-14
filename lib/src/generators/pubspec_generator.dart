import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

/// Generates the core project configuration files: `pubspec.yaml`,
/// `analysis_options.yaml`, and `.gitignore`.
class PubspecGenerator extends BaseGenerator {
  /// Creates a [PubspecGenerator] instance.
  PubspecGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Pubspec';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/pubspec/pubspec.yaml.tmpl',
        outputPath: 'pubspec.yaml',
        type: FileType.yaml,
      ),
      await renderToFile(
        templatePath: 'templates/pubspec/analysis_options.yaml.tmpl',
        outputPath: 'analysis_options.yaml',
        type: FileType.yaml,
      ),
      await renderToFile(
        templatePath: 'templates/pubspec/gitignore.tmpl',
        outputPath: '.gitignore',
        type: FileType.markdown,
      ),
    ];
  }
}
