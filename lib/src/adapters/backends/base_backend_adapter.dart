import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

/// The base class for all backend adapters.
///
/// Each adapter defines the specific dependencies, templates, and variables
/// required for a particular backend (e.g., Firebase, Supabase).
abstract class BaseBackendAdapter {
  /// The type of backend this adapter handles.
  Backend get type;

  /// The list of Pub dependencies required by this backend.
  List<Dependency> get dependencies;

  /// The path to the template for the authentication repository.
  String get authRepositoryTemplate;

  /// The path to the template for the user model.
  String get userModelTemplate;

  /// A list of additional template paths required by this backend.
  List<String> get additionalTemplatePaths;

  /// A map of additional variables to be injected into Mustache templates.
  Map<String, dynamic> get templateVars;
}

