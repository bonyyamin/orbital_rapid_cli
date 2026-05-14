import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

import '../base_generator.dart';

/// A helper class for generating shared authentication components that only
/// need to be generated once, regardless of how many auth screens are selected.
class AuthSharedGenerator {
  static bool _generated = false;

  /// Generates shared auth components (repositories, models, use cases).
  ///
  /// This ensures that if both Login and Register are generated, the
  /// shared data/domain layers are only produced once.
  static Future<List<GeneratedFile>> generateOnce(BaseGenerator generator) async {
    if (_generated) return [];
    _generated = true;

    final backendTemplate = switch (generator.config.backend) {
      Backend.firebase => 'templates/auth/repository/firebase/auth_repository.dart.tmpl',
      Backend.rest => 'templates/auth/repository/rest/auth_repository.dart.tmpl',
      Backend.supabase => 'templates/auth/repository/supabase/auth_repository.dart.tmpl',
      Backend.none => 'templates/auth/repository/none/auth_repository.dart.tmpl',
    };

    return [
      await generator.renderToFile(
        templatePath: 'templates/shared/auth_repository_interface.dart.tmpl',
        outputPath: 'lib/features/auth/data/auth_repository_interface.dart',
      ),
      await generator.renderToFile(
        templatePath: backendTemplate,
        outputPath: 'lib/features/auth/data/auth_repository.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/shared/user_model.dart.tmpl',
        outputPath: 'lib/features/auth/data/models/user_model.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/login_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/login_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/register_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/register_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/logout_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/logout_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/forgot_password_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/forgot_password_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/social_login_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/social_login_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/verify_email_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/verify_email_usecase.dart',
      ),
      await generator.renderToFile(
        templatePath: 'templates/auth/usecases/resend_verification_usecase.dart.tmpl',
        outputPath: 'lib/features/auth/domain/usecases/resend_verification_usecase.dart',
      ),
    ];
  }
}

