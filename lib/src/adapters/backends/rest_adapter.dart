import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_backend_adapter.dart';

class RestAdapter extends BaseBackendAdapter {
  @override
  Backend get type => Backend.rest;

  @override
  List<Dependency> get dependencies => [
    const Dependency('dio', '^5.4.3+1'),
    const Dependency('flutter_secure_storage', '^9.0.0'),
    const Dependency('pretty_dio_logger', '^1.3.1'),
  ];

  @override
  String get authRepositoryTemplate =>
      'templates/auth/repository/rest/auth_repository.dart.tmpl';

  @override
  String get userModelTemplate =>
      'templates/shared/user_model.dart.tmpl';

  @override
  List<String> get additionalTemplatePaths => [
    'templates/core/network/api_client.dart.tmpl',
    'templates/core/network/api_endpoints.dart.tmpl',
    'templates/core/network/interceptors/auth_interceptor.dart.tmpl',
    'templates/core/network/interceptors/logging_interceptor.dart.tmpl',
  ];

  @override
  Map<String, dynamic> get templateVars => {
    'authRepoClass': 'RestAuthRepository',
  };
}
