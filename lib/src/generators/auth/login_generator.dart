import 'package:orbital_rapid_cli/src/adapters/backends/base_backend_adapter.dart';
import 'package:orbital_rapid_cli/src/adapters/backends/firebase_adapter.dart';
import 'package:orbital_rapid_cli/src/adapters/backends/rest_adapter.dart';
import 'package:orbital_rapid_cli/src/adapters/backends/supabase_adapter.dart';
import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

import 'auth_shared.dart';

class LoginGenerator extends BaseGenerator {
  LoginGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Login';

  @override
  List<Dependency> get requiredDependencies {
    final BaseBackendAdapter adapter = switch (config.backend) {
      Backend.firebase => FirebaseAdapter(),
      Backend.rest => RestAdapter(),
      Backend.supabase => SupabaseAdapter(),
      Backend.none => throw UnimplementedError('No backend adapter for none'),
    };
    return adapter.dependencies;
  }

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      ...await AuthSharedGenerator.generateOnce(this),
      await renderToFile(
        templatePath: 'templates/auth/login/$sm/login_screen.dart.tmpl',
        outputPath: 'lib/features/auth/presentation/login/login_screen.dart',
      ),
      await renderToFile(
        templatePath: 'templates/auth/login/widgets/login_form.dart.tmpl',
        outputPath:
            'lib/features/auth/presentation/login/widgets/login_form.dart',
      ),
      await renderToFile(
        templatePath:
            'templates/auth/login/widgets/social_login_button.dart.tmpl',
        outputPath:
            'lib/features/auth/presentation/login/widgets/social_login_button.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath:
              'templates/auth/login/riverpod/login_notifier.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/riverpod/login_notifier.dart',
        ),
        await renderToFile(
          templatePath:
              'templates/auth/login/riverpod/login_provider.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/riverpod/login_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/login/riverpod/login_state.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/riverpod/login_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/login/bloc/login_bloc.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/bloc/login_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/login/bloc/login_event.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/bloc/login_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/login/bloc/login_state.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/bloc/login_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/auth/login/getx/login_controller.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/getx/login_controller.dart',
        ),
        await renderToFile(
          templatePath: 'templates/auth/login/getx/login_binding.dart.tmpl',
          outputPath:
              'lib/features/auth/presentation/login/getx/login_binding.dart',
        ),
      ]);
    }

    return files;
  }
}
