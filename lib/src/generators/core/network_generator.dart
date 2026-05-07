import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class NetworkGenerator extends BaseGenerator {
  NetworkGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Network';

  @override
  List<Dependency> get requiredDependencies => const [
    Dependency('dio', '^5.4.3+1'),
    Dependency('pretty_dio_logger', '^1.3.1'),
    Dependency('get_it', '^7.6.7'),
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
 
