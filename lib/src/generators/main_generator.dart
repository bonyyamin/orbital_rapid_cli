import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

class MainGenerator extends BaseGenerator {
  MainGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Main';

  @override
  List<Dependency> get requiredDependencies {
    switch (config.stateManagement) {
      case StateManagement.riverpod:
        return const [Dependency('flutter_riverpod', '^3.3.1')];
      case StateManagement.bloc:
        return const [
          Dependency('flutter_bloc', '^8.1.4'),
          Dependency('bloc', '^9.1.1'),
          Dependency('get_it', '^9.2.1'),
          Dependency('injectable', '^3.0.0'),
        ];
      case StateManagement.getx:
        return const [Dependency('get', '^4.7.3')];
    }
  }

  @override
  Future<List<GeneratedFile>> generate() async {
    final templatePath = switch (config.stateManagement) {
      StateManagement.riverpod => 'templates/main/main_riverpod.dart.tmpl',
      StateManagement.bloc => 'templates/main/main_bloc.dart.tmpl',
      StateManagement.getx => 'templates/main/main_getx.dart.tmpl',
    };

    return [
      await renderToFile(
        templatePath: templatePath,
        outputPath: 'lib/main.dart',
      ),
    ];
  }
}
