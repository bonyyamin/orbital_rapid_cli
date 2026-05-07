import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class SharedGenerator extends BaseGenerator {
  SharedGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Shared Components';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/shared/widgets/primary_button.dart.tmpl',
        outputPath: 'lib/shared/widgets/primary_button.dart',
      ),
      await renderToFile(
        templatePath: 'templates/shared/widgets/social_login_button.dart.tmpl',
        outputPath: 'lib/shared/widgets/social_login_button.dart',
      ),
      await renderToFile(
        templatePath: 'templates/shared/widgets/text_input.dart.tmpl',
        outputPath: 'lib/shared/widgets/text_input.dart',
      ),
    ];
  }
}
