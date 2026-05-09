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
    final files = <GeneratedFile>[];

    if (config.isRiverpod) {
      files.add(await renderToFile(
        templatePath: 'templates/auth/providers/auth_provider.dart.tmpl',
        outputPath: 'lib/features/auth/providers/auth_provider.dart',
      ));
    }

    if (config.isBloc) {
      files.add(await renderToFile(
        templatePath: 'templates/auth/bloc/auth_bloc.dart.tmpl',
        outputPath: 'lib/features/auth/presentation/bloc/auth_bloc.dart',
      ));
    }

    if (config.isGetX) {
      files.add(await renderToFile(
        templatePath: 'templates/auth/getx/auth_controller.dart.tmpl',
        outputPath:
            'lib/features/auth/presentation/controllers/auth_controller.dart',
      ));
    }

    return files;
  }
}
