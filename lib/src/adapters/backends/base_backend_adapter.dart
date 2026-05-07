import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

abstract class BaseBackendAdapter {
  Backend get type;

  List<Dependency> get dependencies;

  /// Returns template path for auth repository
  String get authRepositoryTemplate;

  /// Returns template path for user model
  String get userModelTemplate;

  /// Additional files this backend needs
  List<String> get additionalTemplatePaths;

  /// Additional variables this backend injects into templates
  Map<String, dynamic> get templateVars;
}
