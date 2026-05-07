import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_backend_adapter.dart';

class SupabaseAdapter extends BaseBackendAdapter {
  @override
  Backend get type => Backend.supabase;

  @override
  List<Dependency> get dependencies => [
    const Dependency('supabase_flutter', '^2.4.0'),
  ];

  @override
  String get authRepositoryTemplate =>
      'templates/auth/repository/supabase/auth_repository.dart.tmpl';

  @override
  String get userModelTemplate =>
      'templates/shared/user_model.dart.tmpl';

  @override
  List<String> get additionalTemplatePaths => [];

  @override
  Map<String, dynamic> get templateVars => {
    'authRepoClass': 'SupabaseAuthRepository',
  };
}
