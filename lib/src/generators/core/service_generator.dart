import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

/// Generates core application services such as local storage,
/// navigation, and authentication.
class ServiceGenerator extends BaseGenerator {
  /// Creates a [ServiceGenerator] instance.
  ServiceGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Services';

  @override
  List<Dependency> get requiredDependencies => const [
    Dependency('shared_preferences', '^2.5.5'),
  ];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/core/services/storage_service.dart.tmpl',
        outputPath: 'lib/core/services/storage_service.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/services/navigation_service.dart.tmpl',
        outputPath: 'lib/core/services/navigation_service.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/services/auth_service.dart.tmpl',
        outputPath: 'lib/core/services/auth_service.dart',
      ),
    ];
  }
}
 
