import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

import 'auth_shared.dart';

class ForgotPasswordGenerator extends BaseGenerator {
  ForgotPasswordGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Forgot Password';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      ...await AuthSharedGenerator.generateOnce(this),
      await renderToFile(
        templatePath: 'templates/auth/forgot_password/$sm/forgot_password_screen.dart.tmpl',
        outputPath: 'lib/features/auth/presentation/forgot_password/forgot_password_screen.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/riverpod/forgot_password_notifier.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/riverpod/forgot_password_notifier.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/riverpod/forgot_password_provider.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/riverpod/forgot_password_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/riverpod/forgot_password_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/riverpod/forgot_password_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/bloc/forgot_password_bloc.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/bloc/forgot_password_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/bloc/forgot_password_event.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/bloc/forgot_password_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/bloc/forgot_password_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/bloc/forgot_password_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/getx/forgot_password_controller.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/getx/forgot_password_controller.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/forgot_password/getx/forgot_password_binding.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/forgot_password/getx/forgot_password_binding.dart',
        ),
      ]);
    }

    return files;
  }
}
 
