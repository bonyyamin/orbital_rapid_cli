import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

/// Generates the network layer (Dio client, interceptors, endpoints)
/// for projects using a REST API backend.
class NetworkGenerator extends BaseGenerator {
  /// Creates a [NetworkGenerator] instance.
  NetworkGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Network';

  @override
  List<Dependency> get requiredDependencies => const [
    Dependency('dio', '^5.9.2'),
    Dependency('pretty_dio_logger', '^1.4.0'),
    Dependency('get_it', '^9.2.1'),
  ];

  @override
  Future<List<GeneratedFile>> generate() async {
    if (!config.isRest) return [];

    return [
      await renderToFile(
        templatePath: 'templates/core/network/api_client.dart.tmpl',
        outputPath: 'lib/core/network/api_client.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/network/api_endpoints.dart.tmpl',
        outputPath: 'lib/core/network/api_endpoints.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/network/interceptors/auth_interceptor.dart.tmpl',
        outputPath: 'lib/core/network/interceptors/auth_interceptor.dart',
      ),
      await renderToFile(
        templatePath: 'templates/core/network/interceptors/logging_interceptor.dart.tmpl',
        outputPath: 'lib/core/network/interceptors/logging_interceptor.dart',
      ),
    ];
  }
}
 
