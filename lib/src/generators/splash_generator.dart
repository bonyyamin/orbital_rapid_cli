import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class SplashGenerator extends BaseGenerator {
  SplashGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Splash Screen';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      await renderToFile(
        templatePath: 'templates/splash/$sm/splash_screen.dart.tmpl',
        outputPath: 'lib/features/splash/presentation/splash_screen.dart',
      ),
    ];

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/splash/bloc/splash_bloc.dart.tmpl',
          outputPath: 'lib/features/splash/presentation/bloc/splash_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/splash/bloc/splash_event.dart.tmpl',
          outputPath: 'lib/features/splash/presentation/bloc/splash_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/splash/bloc/splash_state.dart.tmpl',
          outputPath: 'lib/features/splash/presentation/bloc/splash_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.add(
        await renderToFile(
          templatePath: 'templates/splash/getx/splash_controller.dart.tmpl',
          outputPath: 'lib/features/splash/presentation/getx/splash_controller.dart',
        ),
      );
    }

    return files;
  }
}
 
