import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_backend_adapter.dart';

class NoneAdapter extends BaseBackendAdapter {
  @override
  Backend get type => Backend.none;

  @override
  List<Dependency> get dependencies => [];

  @override
  String get authRepositoryTemplate =>
      'templates/auth/repository/none/auth_repository.dart.tmpl';

  @override
  String get userModelTemplate =>
      'templates/shared/user_model.dart.tmpl';

  @override
  List<String> get additionalTemplatePaths => [];

  @override
  Map<String, dynamic> get templateVars => {
    'authRepoClass': 'LocalAuthRepository',
  };
}
