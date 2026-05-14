import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

/// Generates application-wide constant files such as assets, routes, and enums.
class ConstantsGenerator extends BaseGenerator {
  /// Creates a [ConstantsGenerator] instance.
  ConstantsGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Constants';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/core/app_assets.dart.tmpl',
        outputPath: 'lib/core/constants/app_assets.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/app_routes.dart.tmpl',
        outputPath: 'lib/core/constants/app_routes.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/app_enums.dart.tmpl',
        outputPath: 'lib/core/constants/app_enums.dart',
      ),
    ];
  }
}
 
