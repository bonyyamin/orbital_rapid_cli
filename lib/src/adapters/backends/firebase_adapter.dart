import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_backend_adapter.dart';

class FirebaseAdapter extends BaseBackendAdapter {
  @override
  Backend get type => Backend.firebase;

  @override
  List<Dependency> get dependencies => [
    const Dependency('firebase_core', '^2.27.0'),
    const Dependency('firebase_auth', '^4.19.0'),
    const Dependency('google_sign_in', '^6.2.1'),
    const Dependency('cloud_firestore', '^4.17.0'),
  ];

  @override
  String get authRepositoryTemplate =>
      'templates/auth/repository/firebase/auth_repository.dart.tmpl';

  @override
  String get userModelTemplate =>
      'templates/shared/user_model.dart.tmpl';

  @override
  List<String> get additionalTemplatePaths => [];

  @override
  Map<String, dynamic> get templateVars => {
    'authRepoClass': 'FirebaseAuthRepository',
    'hasGoogleSignIn': true,
    'hasAppleSignIn': true,
  };
}
