import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

class OnboardingGenerator extends BaseGenerator {
  OnboardingGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Onboarding';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      await renderToFile(
        templatePath: 'templates/onboarding/$sm/onboarding_screen.dart.tmpl',
        outputPath: 'lib/features/onboarding/presentation/onboarding_screen.dart',
      ),
      await renderToFile(
        templatePath: 'templates/onboarding/$sm/widgets/onboarding_page.dart.tmpl',
        outputPath: 'lib/features/onboarding/presentation/widgets/onboarding_page.dart',
      ),
      await renderToFile(
        templatePath: 'templates/onboarding/$sm/widgets/page_indicator.dart.tmpl',
        outputPath: 'lib/features/onboarding/presentation/widgets/page_indicator.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/onboarding/riverpod/onboarding_provider.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/riverpod/onboarding_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/onboarding/riverpod/onboarding_state.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/riverpod/onboarding_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/onboarding/bloc/onboarding_bloc.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/bloc/onboarding_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/onboarding/bloc/onboarding_event.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/bloc/onboarding_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/onboarding/bloc/onboarding_state.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/bloc/onboarding_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.add(
        await renderToFile(
          templatePath: 'templates/onboarding/getx/onboarding_controller.dart.tmpl',
          outputPath: 'lib/features/onboarding/presentation/getx/onboarding_controller.dart',
        ),
      );
    }

    return files;
  }
}
 
