import 'package:orbital_rapid_cli/src/engine/template_engine.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

/// The base class for all file generators in the CLI.
///
/// It provides common utilities for rendering templates and accessing
/// the project configuration.
abstract class BaseGenerator {
  /// The project configuration.
  final FlowConfig config;

  /// The template engine used for rendering.
  final TemplateEngine engine;

  /// The logger used for reporting progress.
  final AppLogger logger;

  /// Creates a [BaseGenerator] instance.
  BaseGenerator({
    required this.config,
    required this.engine,
    required this.logger,
  });

  /// The human-readable name of this generator.
  String get name;

  /// A list of Pub dependencies that this generator requires.
  List<Dependency> get requiredDependencies;

  /// Generates the list of files managed by this generator.
  Future<List<GeneratedFile>> generate();

  /// A convenience method that renders a template and returns a [GeneratedFile].
  Future<GeneratedFile> renderToFile({
    required String templatePath,
    required String outputPath,
    Map<String, dynamic> extraVars = const {},
    FileType type = FileType.dart,
  }) async {
    final content = await engine.render(
      templatePath,
      {...config.toTemplateVars(), ...extraVars},
    );
    return GeneratedFile(
      relativePath: outputPath,
      content: content,
      type: type,
    );
  }

  /// Shorthand for the selected state management folder name.
  String get sm => config.stateManagement.folderName;
}