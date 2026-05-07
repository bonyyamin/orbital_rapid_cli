import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class UtilsGenerator extends BaseGenerator {
  UtilsGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Design System';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/utils/app_fonts.dart.tmpl',
        outputPath: 'lib/core/utils/app_fonts.dart',
      ),
      await renderToFile(
        templatePath: 'templates/utils/app_colors.dart.tmpl',
        outputPath: 'lib/core/utils/app_colors.dart',
      ),
      await renderToFile(
        templatePath: 'templates/utils/app_gradients.dart.tmpl',
        outputPath: 'lib/core/utils/app_gradients.dart',
      ),
      await renderToFile(
        templatePath: 'templates/utils/app_text_styles.dart.tmpl',
        outputPath: 'lib/core/utils/app_text_styles.dart',
      ),
      await renderToFile(
        templatePath: 'templates/utils/app_dimensions.dart.tmpl',
        outputPath: 'lib/core/utils/app_dimensions.dart',
      ),
      await renderToFile(
        templatePath: 'templates/utils/app_strings.dart.tmpl',
        outputPath: 'lib/core/utils/app_strings.dart',
      ),
    ];
  }
}
