import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class HomeGenerator extends BaseGenerator {
  HomeGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Home';

  @override
  List<Dependency> get requiredDependencies => const [];

  @override
  Future<List<GeneratedFile>> generate() async {
    return [
      await renderToFile(
        templatePath: 'templates/home/home_screen.dart.tmpl',
        outputPath: 'lib/features/home/presentation/home_screen.dart',
      ),
    ];
  }
}
