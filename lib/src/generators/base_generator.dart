import 'package:orbital_rapid_cli/src/engine/template_engine.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/flow_config.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/utils/logger.dart';

abstract class BaseGenerator {
  final FlowConfig config;
  final TemplateEngine engine;
  final AppLogger logger;

  BaseGenerator({
    required this.config,
    required this.engine,
    required this.logger,
  });

  String get name;
  List<Dependency> get requiredDependencies;
  Future<List<GeneratedFile>> generate();

  // Convenience: render template and return GeneratedFile
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

  // Shorthand for the state management folder name
  String get sm => config.stateManagement.folderName;
}