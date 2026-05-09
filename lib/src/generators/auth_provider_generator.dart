import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class AuthProviderGenerator extends BaseGenerator {
  AuthProviderGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Auth Provider';

  @override
  List<Dependency> get requiredDependencies => const [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/auth/providers/auth_provider.dart.tmpl',
        outputPath: 'lib/features/auth/providers/auth_provider.dart',
      ),
    ];
  }
}
