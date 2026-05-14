import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_backend_adapter.dart';

/// An adapter for the Google Firebase backend.
///
/// It provides dependencies for `firebase_core`, `firebase_auth`, and `cloud_firestore`.
class FirebaseAdapter extends BaseBackendAdapter {

  @override
  Backend get type => Backend.firebase;

  @override
  List<Dependency> get dependencies => [
    const Dependency('firebase_core', '^4.7.0'),
    const Dependency('firebase_auth', '^6.4.0'),
    const Dependency('cloud_firestore', '^6.3.0'),
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
  };
}
