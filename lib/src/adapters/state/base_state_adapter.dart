import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

/// The base class for all state management adapters.
///
/// Each adapter defines the dependencies and template variables required
/// for a specific state management solution (e.g., BLoC, Riverpod).
abstract class BaseStateAdapter {
  /// The type of state management this adapter handles.
  StateManagement get type;

  /// The list of Pub dependencies required by this state management solution.
  List<Dependency> get dependencies;

  /// A map of additional variables to be injected into Mustache templates.
  Map<String, dynamic> get templateVars;
}

