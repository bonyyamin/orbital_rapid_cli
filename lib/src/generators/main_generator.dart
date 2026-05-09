import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

class MainGenerator extends BaseGenerator {
  MainGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });

  @override
  String get name => 'Main';

  @override
  List<Dependency> get requiredDependencies {
    final deps = switch (config.stateManagement) {
      StateManagement.riverpod => [Dependency('flutter_riverpod', '^3.3.1')],
      StateManagement.bloc => [
          Dependency('flutter_bloc', '^9.1.1'),
          Dependency('bloc', '^9.1.1'),
          Dependency('get_it', '^9.2.1'),
          Dependency('injectable', '^3.0.0'),
        ],
      StateManagement.getx => [Dependency('get', '^4.7.3')],
    };

    // Add backend-specific dependencies
    switch (config.backend) {
      case Backend.firebase:
        deps.addAll([
          Dependency('firebase_core', '^4.7.0'),
          Dependency('firebase_auth', '^6.4.0'),
        ]);
        break;
      case Backend.rest:
        deps.add(Dependency('http', '^1.6.0'));
        break;
      case Backend.supabase:
        deps.add(Dependency('supabase_flutter', '^2.12.4'));
        break;
      case Backend.none:
        break;
    }

    // Add social auth dependencies
    if (config.hasGoogleAuth) {
      deps.add(Dependency('google_sign_in', '^6.2.1'));
    }
    if (config.hasFacebookAuth) {
      deps.add(Dependency('flutter_facebook_auth', '^7.1.1'));
    }
    if (config.hasAppleAuth) {
      deps.add(Dependency('sign_in_with_apple', '^6.1.1'));
    }
    // GitHub usually uses OAuth which can be handled by Supabase/Firebase natively
    // or requires a custom flow for REST.

    return deps;
  }

  @override
  Future<List<GeneratedFile>> generate() async {
    final templatePath = switch (config.stateManagement) {
      StateManagement.riverpod => 'templates/main/main_riverpod.dart.tmpl',
      StateManagement.bloc => 'templates/main/main_bloc.dart.tmpl',
      StateManagement.getx => 'templates/main/main_getx.dart.tmpl',
    };

    final files = [
      await renderToFile(
        templatePath: templatePath,
        outputPath: 'lib/main.dart',
        extraVars: {
          'isFirebaseBackend': config.backend == Backend.firebase,
          'isRestBackend': config.backend == Backend.rest,
          'isSupabaseBackend': config.backend == Backend.supabase,
          'isNoneBackend': config.backend == Backend.none,
          'hasSplashScreen': config.screens.contains(Screen.splash),
          'hasOnboardingScreen': config.screens.contains(Screen.onboarding),
          'hasLoginScreen': config.screens.contains(Screen.login),
          'hasRegisterScreen': config.screens.contains(Screen.register),
          'hasForgotPasswordScreen': config.screens.contains(Screen.forgotPassword),
          'hasDeleteAccountScreen': config.screens.contains(Screen.accountDeletion),
        },
      ),
    ];

    // Add backend-specific config files
    switch (config.backend) {
      case Backend.rest:
        files.add(await renderToFile(
          templatePath: 'templates/core/config/api_config.dart.tmpl',
          outputPath: 'lib/core/config/api_config.dart',
        ));
        break;
      case Backend.supabase:
        files.add(await renderToFile(
          templatePath: 'templates/core/config/supabase_config.dart.tmpl',
          outputPath: 'lib/core/config/supabase_config.dart',
        ));
        break;
      case Backend.firebase:
        files.add(await renderToFile(
          templatePath: 'templates/firebase/firebase_options.dart.tmpl',
          outputPath: 'lib/firebase_options.dart',
        ));
        break;
      case Backend.none:
        break;
    }

    // Add mock auth service for all backends
    files.add(await renderToFile(
      templatePath: 'templates/core/services/mock_auth_service.dart.tmpl',
      outputPath: 'lib/core/services/mock_auth_service.dart',
    ));

    return files;
  }
}
