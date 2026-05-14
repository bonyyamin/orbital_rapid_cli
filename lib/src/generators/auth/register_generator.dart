import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

import 'auth_shared.dart';

/// Generates the user registration flow, including screens and state management.
class RegisterGenerator extends BaseGenerator {
  /// Creates a [RegisterGenerator] instance.
  RegisterGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Register';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      ...await AuthSharedGenerator.generateOnce(this),
      await renderToFile(
        templatePath: 'templates/auth/register/$sm/register_screen.dart.tmpl',
        outputPath: 'lib/features/auth/presentation/register/register_screen.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/register/riverpod/register_notifier.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/riverpod/register_notifier.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/register/riverpod/register_provider.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/riverpod/register_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/register/riverpod/register_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/riverpod/register_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/register/bloc/register_bloc.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/bloc/register_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/register/bloc/register_event.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/bloc/register_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/register/bloc/register_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/bloc/register_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/register/getx/register_controller.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/getx/register_controller.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/register/getx/register_binding.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/register/getx/register_binding.dart',
        ),
      ]);
    }

    return files;
  }
}
 
