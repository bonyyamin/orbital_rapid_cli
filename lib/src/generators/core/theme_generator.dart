import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class ThemeGenerator extends BaseGenerator {
  ThemeGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Theme';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      await renderToFile(
        templatePath: 'templates/theme/app_theme.dart.tmpl',
        outputPath: 'lib/core/theme/app_theme.dart',
      ),
    ];

    if (config.hasDarkMode) {
      files.add(
        await renderToFile(
          templatePath: 'templates/theme/app_dark_theme.dart.tmpl',
          outputPath: 'lib/core/theme/app_dark_theme.dart',
        ),
      );
    }

    return files;
  }
}
