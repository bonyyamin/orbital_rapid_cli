import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

import 'auth_shared.dart';

class VerifyEmailGenerator extends BaseGenerator {
  VerifyEmailGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Verify Email';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      ...await AuthSharedGenerator.generateOnce(this),
      await renderToFile(
        templatePath: 'templates/auth/verify_email/$sm/verify_email_screen.dart.tmpl',
        outputPath: 'lib/features/auth/presentation/verify_email/verify_email_screen.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/verify_email/riverpod/verify_email_notifier.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/riverpod/verify_email_notifier.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/verify_email/riverpod/verify_email_provider.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/riverpod/verify_email_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/verify_email/riverpod/verify_email_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/riverpod/verify_email_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/verify_email/bloc/verify_email_bloc.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/bloc/verify_email_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/verify_email/bloc/verify_email_event.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/bloc/verify_email_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/verify_email/bloc/verify_email_state.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/bloc/verify_email_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/verify_email/getx/verify_email_controller.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/getx/verify_email_controller.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/verify_email/getx/verify_email_binding.dart.tmpl',
          outputPath: 'lib/features/auth/presentation/verify_email/getx/verify_email_binding.dart',
        ),
      ]);
    }

    return files;
  }
}
